import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

import 'package:home/data/record.dart';
import 'package:home/data/record_repository.dart';
import 'package:home/tools/record_validator.dart';
import 'package:ui/tools/fixed_values.dart';

import 'record_view.dart';

class RecordList extends StatefulWidget {
  const RecordList(
      this.recordValidatorProvider,
      this.recordRepository,
      this.products,
      this.maxChildRecords,
      this.onClick,
      {Key? key}
  ) : super(key: key);

  final RecordValidatorProvider recordValidatorProvider;
  final RecordRepository recordRepository;
  final List<Record> products;
  final int maxChildRecords;
  final Function(Record) onClick;

  @override
  State<StatefulWidget> createState() => _RecordListForDialogState();
}

class _RecordListForDialogState extends State<RecordList> {

  late List<Record> _products;

  @override
  Widget build(BuildContext context) {

    _products = widget.products;

    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(
          children: [
            _products.length > widget.maxChildRecords
                ? Container(
              margin: const EdgeInsets.only(bottom: 5),
              child: const Icon(
                Icons.keyboard_arrow_up,
                color: Colors.white,
                size: 25,
              ),
            )
                : Container(),
            Container(
              //height: _products.length > widget.maxChildRecords ? ((34*widget.maxChildRecords)+(10*(widget.maxChildRecords))).toDouble() : null,
                margin: EdgeInsets.only(
                    top: _products.length <= widget.maxChildRecords
                        ? 13
                        : 0),
                child: GroupedListView<dynamic, String?>(
                  shrinkWrap: true,
                  sort: false,
                  groupBy: (element) => element.getId(),
                  elements: _products,
                  physics: const ClampingScrollPhysics(),
                  groupSeparatorBuilder: (String? groupValue) => Container(),
                  itemBuilder: (context, dynamic element) => RecordView(
                    widget.recordValidatorProvider,
                    widget.recordRepository,
                    element,
                    Colors.black,
                        (record) {
                      int elementIndex = _products.indexOf(element);
                      setState(() {
                        _products[elementIndex] = record;
                        _products.sort((record1, record2) => FixedValues.date.parse(record2.getTime()).compareTo(FixedValues.date.parse(record1.getTime())));
                      });
                      widget.onClick.call(record);
                    },
                  ).setParentDetail(true),
                )),
            _products.length > widget.maxChildRecords
                ? const Icon(Icons.keyboard_arrow_down,
                color: Colors.white, size: 25)
                : Container(),
          ],
        ));
  }
}
