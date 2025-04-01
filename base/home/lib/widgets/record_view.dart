import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home/data/record.dart';
import 'package:home/data/record_repository.dart';
import 'package:home/dialogs/add_record_dialog.dart';
import 'package:home/tools/record_validator.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:ui/dialogs/confirmation_dialog.dart';
import 'package:ui/resources/icons/fa_icons.dart';
import 'package:ui/tools/fixed_values.dart';
import 'package:ui/tools/text_tools.dart';
import 'package:ui/tools/view_tools.dart';

//ignore: must_be_immutable
class RecordView extends StatefulWidget {
  RecordView(
      this.recordValidatorProvider,
      this.recordRepository,
      this.record,
      this.textColor,
      this.onRefresh,
      {Key? key}
  ) : super(key: key);

  final RecordValidatorProvider recordValidatorProvider;
  final RecordRepository recordRepository;
  final Record record;
  final Color textColor;
  final Function(Record) onRefresh;
  final int maxChildRecords = 5;
  final GlobalKey mainContainer = GlobalKey();

  Color? color;
  bool isChild = false;
  bool isParentDetail = false;

  static Key dialogKey = Key("widget.record.getId()");

  @override
  State<StatefulWidget> createState() => _RecordViewState();

  RecordView setAsChild(){
    isChild = true;
    return this;
  }

  RecordView setParentDetail(bool val) {
    isParentDetail = val;
    return this;
  }

  Color _getColor() {
    if (record.referenceId == null) {
      if (record.isParent()) {
        return Colors.blue;
      }
      if (record.getAmount() > 0) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    } else {
      return Colors.grey;
    }
  }
}

class _RecordViewState extends State<RecordView>{

  double viewHeight = 0;
  double parentAmount = 0;
  final ScrollController _childScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    widget.color = widget._getColor();
    return createWidget();
  }

  Widget createWidget(){
    return Dismissible(
        key: Key(widget.record.getId()),
        confirmDismiss: widget.record.getId().isEmpty ? (direction) {
          return Future.value(false);
        } : (direction) {
          return showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder( // <-- SEE HERE
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              builder: (BuildContext context) =>
                  ConfirmationDialog(
                    title: context.l10n.deleteRecord,
                    message: context.l10n.areYouSureDeleteRecord,
                    onClick: () {
                      if(widget.record.isParent()){
                        widget.recordRepository.getRecordsByParent(widget.record.getId()).then((value) => {
                          for (var element in value) {
                            widget.recordRepository.removeRecord(element)
                          }
                        });
                      }
                      widget.recordRepository.removeRecord(widget.record);
                      Navigator.of(context).pop(true);
                    },
                  )
          );
        },
        child: Stack(
            children: [
              GestureDetector(
                  onTap: widget.record.getId().isEmpty ? (){ if(! widget.record.isParent()) widget.onRefresh.call(widget.record); } : () => showModalBottomSheet(
                    isScrollControlled: true,
                    context: context,
                    shape: const RoundedRectangleBorder( // <-- SEE HERE
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(25.0),
                      ),
                    ),
                    builder: (BuildContext context) =>
                        AddRecordDialog(
                            widget.recordValidatorProvider,
                            widget.recordRepository,
                            widget.record,
                            null,
                            widget.onRefresh,
                          key: RecordView.dialogKey,
                        ),
                  ),
                  onDoubleTap: widget.record.isChild() || widget.record.getId().isEmpty ? (){} : (){
                    var newRecord = widget.record.cloneAddChild();
                    newRecord.id = "";
                    newRecord.description = "";
                    newRecord.referenceId = null;
                    newRecord.amount = 0.0;
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder( // <-- SEE HERE
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0),
                        ),
                      ),
                      builder: (BuildContext context) =>
                          AddRecordDialog(
                              widget.recordValidatorProvider,
                              widget.recordRepository,
                              newRecord,
                              widget.record,
                              widget.onRefresh
                          ),
                    );
                  },
                  child: Card(
                    key: widget.mainContainer,
                    shape: FixedValues.getCardBorder(10),
                    shadowColor: Colors.blue,
                    elevation: 5,
                    color: widget.color,
                    margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              // big icon
                              widget.isParentDetail ? Container() : Container(margin: const EdgeInsets.only(left: 15, top: 5), child: Icon(getTypeIcon(), color: widget.textColor, size: 20),),
                              // detail date
                              widget.isParentDetail ? Container(margin: EdgeInsets.only(top: 5, left: 10, right: widget.isParentDetail ? 0 : 10),child:Text(widget.record.getShortTime(),textScaleFactor:0.9, style: TextStyle(color: widget.textColor)),) : Container(),
                              // record name
                              Expanded(child:Container(margin: EdgeInsets.only(top: 5, left: widget.isParentDetail ? 0 : 10, right: widget.isParentDetail ? 5 : 10),child:Text(widget.record.getDescription(),textScaleFactor: widget.isParentDetail ? 0.9 : 1.1, style: TextStyle(color: widget.textColor), overflow: widget.record.isParent() || widget.record.isChild() ? TextOverflow.ellipsis : null, textAlign: widget.isParentDetail ? TextAlign.center : TextAlign.left,),),),
                              // record price
                              Container(margin: const EdgeInsets.only(top: 5),child:Text(FixedValues.currency.format(widget.record.isParent() ? parentAmount : widget.record.getAmount()), textAlign: TextAlign.center,textScaleFactor: widget.isParentDetail ? 0.9 : 1.1, style: TextStyle(color: widget.textColor),),),
                              // icon copy in edit mode
                              const SizedBox(width: 15,),
                            ],
                          ),
                          widget.record.isParent() ?
                          widget.record.children == null || widget.record.children!.isEmpty ? getChildRecords() : drawChildList() : Container(height: 5),
                        ],
                      ),
                    ),
                  )
              ),
              //getDisabledLine(context),
            ]
        )
    );
  }

  IconData getTypeIcon() {
    return FontAwesomeIcons.creditCard;
  }

  double getSize() {
    if (!widget.isParentDetail){
      return 11;
    } else{
      return 0;
    }
  }

  getDisabledLine(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10), () {
      if (viewHeight != widget.mainContainer.currentContext!.size!.height) {
        setState(() =>
        viewHeight = widget.mainContainer.currentContext!.size!.height);
      }
      if (kDebugMode) {
        print("Alfredo size: ${widget.mainContainer.currentContext!.size!
            .width} / ${widget.mainContainer.currentContext!.size!.height}");
      }
    });
    return Positioned(
      top: viewHeight / 2 - 5,
      left: 5,
      child: Container(
        alignment: Alignment.center,
        width: ViewTools.getPercentageWidth(context, 100) - 10,
        height: 2,
        color: Colors.white,
      ),
    );
  }

  Record fixRecordAmount(Record record, double parentAmount) {
    if(widget.record.isParent()){
      record.amount = parentAmount;
    }
    return record;
  }

  List<Record> getAllRecords(Record record) {
    var result = [record];
    if(record.children != null) {
      result.addAll(record.children!);
    }
    return result;
  }

  Widget drawChildList() {
    return widget.record.children != null && widget.record.children!.isNotEmpty ? Column(
      children: [
        widget.record.children!.length > widget.maxChildRecords ? GestureDetector(onTap: () => _childScrollController.animateTo(_childScrollController.offset-150, duration: const Duration(milliseconds: 500), curve: Curves.easeOut),child: const Icon(Icons.keyboard_arrow_up,size: 25,),) : Container(),
        Container(
          height: widget.record.children!.length > widget.maxChildRecords ? ((34*widget.maxChildRecords)+(10*(widget.maxChildRecords))).toDouble() : null,
          margin: EdgeInsets.only(top: widget.record.children!.length > widget.maxChildRecords ? 5 : 10),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
              controller: widget.record.children!.length > widget.maxChildRecords ? _childScrollController : null,
              padding: const EdgeInsets.only(bottom: 5),
              shrinkWrap: true,
              physics: widget.record.children!.length > widget.maxChildRecords ? const NeverScrollableScrollPhysics() : const ClampingScrollPhysics(),
              itemCount: widget.record.children!.length,
              itemBuilder: (context,index) => RecordView(
                  widget.recordValidatorProvider,
                  widget.recordRepository,
                  widget.record.children![index],
                  widget.textColor,
                  widget.onRefresh
              )
                  .setAsChild()
            ),
          ),
        ),
        widget.record.children!.length > widget.maxChildRecords ?  GestureDetector(onTap: () => _childScrollController.animateTo(_childScrollController.offset+150, duration: const Duration(milliseconds: 500), curve: Curves.easeOut),child: Container(padding: const EdgeInsets.only(bottom: 5), child: const Icon(Icons.keyboard_arrow_down,size: 25),),) : Container(),
      ],
    ) : Container(height: 5);
  }

  Widget getChildRecords() {
    return FutureBuilder(
        future: widget.recordRepository.getRecordsByParent(widget.record.getId()).then((value) {
          widget.record.children = value;
          double newAmount = 0.0;
          for (var element in value) {
            newAmount += element.getAmount();
          }
          if(newAmount != 0 && widget.record.getAmount() != newAmount) {
            if (parentAmount != newAmount) {
              setState(() {
                parentAmount = newAmount;
              });
            }
          }
        }),
        builder: (context,snapshot) {
          if (snapshot.hasError) {
            return Container(margin: const EdgeInsets.only(top: 100), child: Text("Error ${snapshot.error}", textAlign: TextAlign.center, textScaleFactor: 0.4,));
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return drawChildList();
          }
          return const SizedBox(
              height: 300,
              child: CircularProgressIndicator()
          );
        }
    );
  }
}