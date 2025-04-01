import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home/data/record.dart';
import 'package:home/data/record_repository.dart';
import 'package:home/tools/amount_tools.dart';
import 'package:home/tools/record_validator.dart';
import 'package:home/widgets/input_field.dart';
import 'package:home/widgets/record_list.dart';
import 'package:locale/l10n/core_localizations_extensions.dart';
import 'package:ui/dialogs/widgets/dialog_button.dart';
import 'package:ui/dialogs/widgets/dialog_title.dart';
import 'package:ui/tools/fixed_values.dart';
import 'package:ui/tools/view_tools.dart';

class AddRecordDialog extends StatefulWidget {
  AddRecordDialog(this.recordValidatorProvider,
      this.recordRepository,
      this.initialRecord,
      this.parentRecord,
      this.onRecordSelected,
      {Key? key}) : super(key: key);

  final RecordValidatorProvider recordValidatorProvider;
  final RecordRepository recordRepository;
  final Record initialRecord;
  final Record? parentRecord;
  final Function(Record) onRecordSelected;

  final _padding = const EdgeInsets.only(top: 5, left: 40, right: 40);

  @override
  State<StatefulWidget> createState() => AddRecordDialogState();

}

class AddRecordDialogState extends State<AddRecordDialog> {

  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController? amountController;

  getAmountController() {
    amountController ??= TextEditingController(
        text: widget.initialRecord.getAmount() == 0.0 ? "0.0" : FixedValues.currency
            .format(widget.initialRecord.getAmount()));
    return amountController;
  }

  TextEditingController? descriptionController;

  getDescriptionController() {
    descriptionController ??=
        TextEditingController(text: widget.initialRecord.getDescription());
    return descriptionController;
  }

  TextEditingController? timeController;

  getTimeController() {
    timeController ??= TextEditingController(text: widget.initialRecord.getTime());
    return timeController;
  }

  @override
  Container build(BuildContext context) {
    Record record = widget.initialRecord;
    double currentAmount = 0.0;

    return Container(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: (MediaQuery.of(context).viewInsets.bottom != 0) ? 200 : 16
        ),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))
        ),
        child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  DialogTittle(
                      getTittle(context, record), () => Navigator.pop(context)),
                  const SizedBox(height: 15.0),
                  Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: ListBody(
                          children: getBody(
                              context,
                              widget.onRecordSelected,
                              getAmountController(),
                              getDescriptionController(),
                              getTimeController(),
                              record,
                              currentAmount,
                                  (newAmount) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                    _) {
                                  /*setState(() {
                                    currentAmount = newAmount;
                                  });*/
                                });
                              })
                      )
                  ),
                  SizedBox(
                      height: record.isParent() ||
                          (!record.isParent() &&
                              record
                                  .getId()
                                  .isEmpty &&
                              currentAmount > 0
                          ) ? 10.0 : 30),
                  DialogButton(
                    context.l10n.save,
                    Theme
                        .of(context)
                        .primaryColor,
                        (_) {
                      if (_formKey.currentState!.validate()) {
                        widget.recordRepository.addRecord(
                          record.addData(
                            getDescriptionController().text,
                            getAmountController().text.isEmpty
                                ? 0.0
                                : AmountTools.getAmount(true, record, getAmountController()),
                            getTimeController().text,
                          ).addParent(widget.parentRecord),
                        ).then((_) {
                          if(widget.parentRecord != null) {
                            widget.recordRepository.addRecord(
                                widget.parentRecord!.makeParent(FixedValues.date.format(DateTime.now()))
                            ).then((_) {
                              Navigator.pop(context);
                              widget.onRecordSelected.call(record);
                            });
                          } else {
                            Navigator.pop(context);
                            widget.onRecordSelected.call(record);
                          }
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 20.0),
                ],
              );
            })
    );
  }

  void printDebug(String data) {
    if (kDebugMode) {
      print(data);
    }
  }

  String getTittle(BuildContext context, Record record) {
    String result = "";
    if (widget.parentRecord != null) {
      result += context.l10n.createChild;
    } else if (record
        .getId()
        .isEmpty) {
      result += context.l10n.create;
    } else {
      result += context.l10n.edit;
    }
    result += context.l10n.record;
    return result;
  }

  getHeader(BuildContext context) {
    if (widget.parentRecord != null) {
      return Container(
        padding: widget._padding,
        child: Card(
          color: Theme
              .of(context)
              .primaryColor,
          shape: FixedValues.getCardBorder(10),
          child: Container(
            margin: const EdgeInsets.all(5),
            child: Text(widget.parentRecord!.getDescription(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 20),),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  getTimePicker(
      TextEditingController? timeController,
      Record record
  ) {
    return Container(
        padding: widget._padding,
        child: InputField(
          timeController,
          TextInputType.datetime,
          widget.recordValidatorProvider.validateTime,
          Icons.calendar_today,
          style: 1,
        )
    );
  }

  List<Widget> getBody(BuildContext context,
      Function(Record) onRecordSelected,
      TextEditingController amountController,
      TextEditingController descriptionController,
      TextEditingController timeController,
      Record record,
      double currentAmount,
      Function(double) onNewAmount) {
    List<Widget> result = [];
    result.add(getHeader(context));
    result.add(
      Container(
        padding: widget._padding,
        child: InputField(
          descriptionController,
          TextInputType.text,
          widget.recordValidatorProvider.validateDescription,
          Icons.drive_file_rename_outline,
          hint: context.l10n.description,
          style: 1,
        ),
      ),
    );

    if (record.isParent()) {
      result.add(getTimePicker(timeController, record));
      result.add(const SizedBox(height: 17));
      result.add(
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: ViewTools.getPercentageWidth(context, 95)),
            child: SingleChildScrollView(
              child:
              RecordList(
                  widget.recordValidatorProvider,
                  widget.recordRepository,
                  record.children == null ? [] : record.children!,
                  8,
                  onRecordSelected
              ),
            ),
          )
      );
    } else {
      result.add(
          Container(
              padding: widget._padding,
              child: InputField(
                amountController,
                TextInputType.phone,
                    (value) =>
                        widget.recordValidatorProvider.validateAmount(
                        value!,
                        record,
                        amountController,
                        onNewAmount
                    ),
                Icons.attach_money,
                hint: context.l10n.amount,
                style: 1,
              )
          )
      );
      result.add(getTimePicker(timeController, record));
    }
    return result;
  }
}