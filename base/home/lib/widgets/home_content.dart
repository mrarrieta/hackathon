import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:home/data/record_repository.dart';
import 'package:home/dialogs/add_record_dialog.dart';
import 'package:home/tools/date_tools.dart';
import 'package:home/tools/record_validator.dart';
import 'package:home/widgets/record_separaor.dart';
import 'package:home/widgets/record_view.dart';
import 'package:icons/font_awesome_flutter.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:ui/tools/fixed_values.dart';

import '../data/record.dart';
import 'text_recognizer.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({
    required this.recordRepository,
    required this.recordValidatorProvider,
    required this.goToLogin,
    required this.goToProfile,
    super.key,
  });

  final RecordRepository recordRepository;
  final RecordValidatorProvider recordValidatorProvider;
  final Function() goToLogin;
  final Function() goToProfile;

  @override
  State<StatefulWidget> createState() => _HomeContentState();

}

class _HomeContentState extends State<HomeContent> {

  double totalAmount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        getFirstRowInformation(context,totalAmount),
        const SizedBox(height: 20,),
        Expanded(child:
          ListView(children: [
            FutureBuilder(
                future: widget.recordRepository.getAllRecords(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    var drawList = snapshot.data?.where((item) => item.referenceId == null || item.referenceId == "1").toList();
                    double newAmount = snapshot.data?.fold(0, (previousValue, element) => previousValue != null ? previousValue + element.getAmount() : 0) ?? 0;
                    if(totalAmount != newAmount) {
                      totalAmount = newAmount;
                      WidgetsBinding.instance.addPostFrameCallback((_){
                        setState(() {});
                      });
                    }
                    return MediaQuery.removePadding(
                        context: context,
                        removeTop: true,
                        child: GroupedListView<dynamic, String?>(
                        shrinkWrap: true,
                        sort: false,
                        order: GroupedListOrder.DESC,
                        elements: drawList ?? [],
                        physics: const ClampingScrollPhysics(),
                        groupBy: (element) => element.getTime().split(' ')[0],
                        groupSeparatorBuilder: (String? groupValue) =>
                            RecordSeparator(
                                groupValue,
                                Theme.of(context).primaryColor,
                                Colors.white
                            ),
                        itemBuilder: (context, dynamic element) =>
                            RecordView(
                              widget.recordValidatorProvider,
                              widget.recordRepository,
                              element,
                              Colors.black,
                              (record) => setState(() {}),
                            )
                  ));
                  }
                }
            ),
          ]),
        ),
      ],
    );
  }

  getFirstRowInformation(BuildContext context, double totalAmount) {
    return Row(children: [
      Expanded(
          child: Card(
            color: Theme
                .of(context)
                .primaryColor,
            child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  FixedValues.currency.format(totalAmount),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                )
            ),
          )
      ),
      GestureDetector(
        onTap: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
            ),
            builder: (BuildContext context) =>
                TextRecognizerView(
                  RecordValidatorProvider(context.l10n, DateTools()),
                  widget.recordRepository,
                  Record(),
                  (record) => widget.recordRepository.addRecord(record)
                      .then((value) {
                        record.children?.forEach((element) {
                          widget.recordRepository.addRecord(element);
                          setState(() {});
                        });
                        Navigator.pop(context);
                      }),
                ),
          );
        },
        child: Card(
          color: Theme
              .of(context)
              .primaryColor,
          child: const Padding(
            padding: EdgeInsets.all(15),
            child: Icon(
                FontAwesomeIcons.wandMagicSparkles, color: Colors.white),
          ),
        ),
      ),
      GestureDetector(
        onTap: () {
          var record = Record();
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              builder: (BuildContext context) {
                return AddRecordDialog(
                  widget.recordValidatorProvider,
                  widget.recordRepository,
                  record,
                  null,
                      (record) {
                        widget.recordRepository.addRecord(record)
                        .then((_) => setState(() {}));
                  },
                  key: Key(record.id.toString()),
                );
              }
          );
        },
        child: Card(
          color: Theme
              .of(context)
              .primaryColor,
          child: const Padding(
            padding: EdgeInsets.all(15),
            child: Icon(FontAwesomeIcons.plus, color: Colors.white),
          ),
        ),
      )
    ],);
  }
}
