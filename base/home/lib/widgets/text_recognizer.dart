import 'dart:convert';
import 'dart:io';

import 'package:crossplat_objectid/crossplat_objectid.dart';
import 'package:dart_openai/dart_openai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:home/data/record_parsed_data.dart';
import 'package:home/data/record.dart';
import 'package:home/data/record_repository.dart';
import 'package:home/tools/record_validator.dart';
import 'package:home/widgets/gallery_view.dart';
import 'package:home/widgets/record_view.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:ui/dialogs/widgets/dialog_button.dart';
import 'package:ui/tools/fixed_values.dart';

class TextRecognizerView extends StatefulWidget {
  TextRecognizerView(
      this.recordValidatorProvider,
      this.recordRepository,
      this.record,
      this.onRecordSelected,
      {super.key}
  );

  final RecordValidatorProvider recordValidatorProvider;
  final RecordRepository recordRepository;
  final Record record;
  final Function(Record) onRecordSelected;

  @override
  State<TextRecognizerView> createState() => _TextRecognizerViewState();
}

class _TextRecognizerViewState extends State<TextRecognizerView> {
  final _textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
  bool _canProcess = true;
  bool _isBusy = false;
  String? _text;
  final String defaultLocale = Platform.localeName;

  @override
  void dispose() async {
    _canProcess = false;
    _textRecognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(_text?.isNotEmpty == true) {
      return getFutureOpenAi();
    } else {
      if(_text == null) {
        return GalleryView(
          onImage: _processImage
        );
      } else if(_text?.isEmpty == true) {
        Future.delayed(const Duration(seconds: 2), () {
          setState(() => _text = null);
        });
        return const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Text("Error"),
            SizedBox(height: 20,),
          ],);
      } else {
        return Container();
      }
    }
  }

  Future<void> _processImage(InputImage inputImage) async {
    if (!_canProcess) return;
    if (_isBusy) return;
    _isBusy = true;

    final recognizedText = await _textRecognizer.processImage(inputImage);

    _text = recognizedText.text;

    debugPrint("Image Process Result $_text");

    _text ??= "";

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }

  getFutureOpenAi() {

    OpenAI.apiKey = dotenv.env['OPEN_AI_KEY'] ?? "";

    String promptData = _text!.trim();
    String prompt = "given data from a purchase ticket retrieve the information";
    debugPrint("Prompt: $prompt");
    debugPrint("Input: $promptData");
    String fullPrompt = "$prompt $promptData";
    debugPrint("Prompt Size: ${fullPrompt.length}");

    // the system message that will be sent to the request.
    final systemMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          "return any message you are given as JSON with this structure data = {\"date\":\"format as yyyy-MM-dd\",\"store\":\"\",\"items\":[{\"amount\":\"format as 00\",\"price\": \"format as 0000.00\",\"description\":\"\"}]}",
        ),
      ],
      role: OpenAIChatMessageRole.assistant,
    );

    // the user message that will be sent to the request.
    final userMessage = OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          promptData,
        ),
      ],
      role: OpenAIChatMessageRole.user,
    );

    // all messages to be sent.
    final requestMessages = [
      systemMessage,
      userMessage,
    ];

    // the actual request.
    Future<OpenAIChatCompletionModel> request = OpenAI.instance.chat.create(
      model: "gpt-3.5-turbo-1106",
      responseFormat: {"type": "json_object"},
      seed: 6,
      messages: requestMessages,
      temperature: 0.2,
      maxTokens: 500,
    );

    return FutureBuilder(
        future: request,
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            if(snapshot.data != null && snapshot.data!.choices != null && snapshot.data!.choices.isNotEmpty) {
              var jsonString = snapshot.data!.choices.first.message.content?.first.text;
              print(jsonString);
              final jsonMap = jsonDecode(jsonString!) as Map<String, dynamic>;
              print(jsonMap["data"]);
              var model = RecordParsedData.fromJson(jsonMap["data"]);
              print(model);
              Record record = getRecord(model);
              return ListView(
                  shrinkWrap: true,
                  children: [
                    const SizedBox(height: 20,),
                    RecordView(
                      widget.recordValidatorProvider,
                      widget.recordRepository,
                      record,
                      Colors.black,
                          (_) {},
                    ),
                    const SizedBox(height: 10,),
                    DialogButton(
                        context.l10n.save,
                        Theme.of(context).primaryColor,
                        (_) {
                          widget.onRecordSelected.call(record);
                        }
                    ),
                    const SizedBox(height: 20,),
                  ]);
            } else {
              return getFutureOpenAi();
            }
          } else if(snapshot.hasError){
            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20,),
                Text("Error"),
                SizedBox(height: 20,),
              ],);
          } else {
            return const Row(
                  children: [
                    Spacer(flex: 1),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 20,),
                        CircularProgressIndicator(),
                        SizedBox(height: 20,),
                      ],
                    ),
                    Spacer(flex: 1),
                  ],
            );
          }
        });
  }

  Record getRecord(RecordParsedData data) {
    if(data.items != null && data.items!.length > 1) {
      Record parentRecord = widget.record.addData(
        data.store ?? "",
        0,
        FixedValues.date.format(DateTime.now()),
      );
      return parentRecord
          .makeParent(FixedValues.date.format(DateTime.now()))
          .addChildren(
          data.items
              ?.map((e) {
            try {
              return Record(
                  id: ObjectId().toHexString(),
                  amount: double.parse(
                      e.price?.replaceAll(",", "").replaceAll(" ", "").replaceAll(RegExp(r'[^0-9.]'),'') ?? "0.00"),
                  description: "x${e.amount ?? 1} ${e.description}" ?? "",
                  referenceId: parentRecord.id,
                  time: FixedValues.date.format(DateTime.now()));
            } catch (error) {
              debugPrint("Error: $error");
              return Record(
                  id: ObjectId().toHexString(),
                  description: "x${e.amount ?? 1} ${e.description}" ?? "",
                  referenceId: parentRecord.id,
                  time: FixedValues.date.format(DateTime.now()));
            }
          }).toList() ??
              []
      );
    } else if(data.items != null && data.items!.length == 1) {
      return widget.record.addData(
          "${data.items!.first.description} ${data.store}",
          double.parse(data.items!.first.price?.replaceAll(",", "").replaceAll(" ", "").replaceAll(RegExp(r'[^0-9.]'),'') ?? "0.00"),
          FixedValues.date.format(DateTime.now())
      );
    } else {
      return widget.record.addData(
          "${data.store}",
          0,
          FixedValues.date.format(DateTime.now())
      );
    }
  }
}
