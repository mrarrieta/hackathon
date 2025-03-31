import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:home/data/record_repository.dart';
import 'package:home/dialogs/add_record_dialog.dart';
import 'package:home/tools/record_validator.dart';
import 'package:home/widgets/record_separaor.dart';
import 'package:home/widgets/record_view.dart';
import 'package:icons/font_awesome_flutter.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:ui/tools/date_tools.dart';

import '../data/record.dart';
import 'text_recognizer.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    required this.recordRepository,
    required this.recordValidatorProvider,
    required this.goToLogin,
    required this.goToProfile,
    required this.startCaptureFlow,
    super.key,
  });

  final RecordRepository recordRepository;
  final RecordValidatorProvider recordValidatorProvider;
  final Function() goToLogin;
  final Function() goToProfile;
  final Function() startCaptureFlow;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(
              child: Card(
                color: Theme.of(context).primaryColor,
                child: const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                       "\$1,000",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      textAlign: TextAlign.center,
                   )
                ),
              )
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(25.0),
                  ),
                ),
                builder: (BuildContext context) => TextRecognizerView(
                  RecordValidatorProvider(context.l10n, DateTools()),
                  recordRepository,
                  Record(),
                      (record)  => recordRepository.addRecord(record)
                          .then((value) {
                            record.children?.forEach((element) {
                              recordRepository.addRecord(element);
                            });
                            Navigator.pop(context);
                          }),
                ),
              );
            },
            child: Card(
              color: Theme.of(context).primaryColor,
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Icon(FontAwesomeIcons.wandMagicSparkles, color: Colors.white),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return AddRecordDialog(
                      recordValidatorProvider,
                      recordRepository,
                      Record(),
                      null,
                          (record) {
                        recordRepository.addRecord(record)
                            .then((_) {
                              Navigator.pop(context);
                            });
                        },
                    );
                  }
              );
            },
            child: Card(
              color: Theme.of(context).primaryColor,
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Icon(FontAwesomeIcons.plus, color: Colors.white),
              ),
            ),
          )
        ],),
        const SizedBox(height: 20,),
        FutureBuilder(
            future: recordRepository.getAllRecords(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Expanded(child: GroupedListView<dynamic, String?>(
                    //shrinkWrap: true,
                    sort: false,
                    order: GroupedListOrder.DESC,
                    elements: snapshot.data ?? [],
                    physics: const ClampingScrollPhysics(),
                    groupBy: (element) => element.getTime().split(' ')[0],
                    groupSeparatorBuilder: (String? groupValue) => RecordSeparator(groupValue, Colors.white, Colors.black),
                    itemBuilder: (context, dynamic element) =>
                        RecordView(
                          recordValidatorProvider,
                          recordRepository,
                          element,
                          Colors.black,
                              (record) {},
                        )
              ));
              }
            }
        )
      ],
    );
  }
}
