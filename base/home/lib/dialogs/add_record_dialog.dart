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
import 'package:ui/widgets/custom_button.dart';

class AddRecordDialog extends Container {
  AddRecordDialog(
      this.recordValidatorProvider,
      this.recordRepository,
      this.initialRecord,
      this.parentRecord,
      this.onRecordSelected,
      {Key? key}
  ) : super(key: key);

  final RecordValidatorProvider recordValidatorProvider;
  final RecordRepository recordRepository;
  final Record initialRecord;
  final Record? parentRecord;
  final Function(Record) onRecordSelected;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Container build(BuildContext context) {

    Record record = initialRecord;
    TextEditingController amountController = TextEditingController(text: record.getAmount() == 0.0 ? "" : FixedValues.currency.format(record.getAmount()));
    TextEditingController descriptionController = TextEditingController(text: record.getDescription());
    TextEditingController timeController = TextEditingController(text: record.getTime());

    double currentAmount = 0.0;

    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration:  const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))
        ),
        child: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  DialogTittle(getTittle(context, record), () => Navigator.pop(context)),
                  const SizedBox(height: 15.0),
                  Form(
                      key: _formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: ListBody(
                          children: getBody(
                              context,
                              onRecordSelected,
                              amountController,
                              descriptionController,
                              timeController,
                              record,
                              currentAmount,
                                  (newAmount) {
                                WidgetsBinding.instance.addPostFrameCallback((_){
                                  setState(() {
                                    currentAmount = newAmount;
                                  });
                                });
                              })
                      )
                  ),
                  SizedBox(
                      height: record.isParent() ||
                          (!record.isParent() &&
                              record.getId().isEmpty &&
                              currentAmount > 0
                          )  ? 10.0 : 30),
                  DialogButton(
                    context.l10n.save,
                    Theme.of(context).primaryColor,
                    (_) {
                      if (_formKey.currentState!.validate()) {
                        recordRepository.addRecord(
                            record.addData(
                              descriptionController.text,
                              amountController.text.isEmpty ? 0.0 : AmountTools.getAmount(true, record, amountController),
                              timeController.text,
                            ),
                        ).then((_) {
                          Navigator.pop(context);
                          onRecordSelected.call(record);
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

  void printDebug(String data){
    if (kDebugMode) {
      print(data);
    }
  }

  String getTittle(BuildContext context, Record record) {
    String result = "";
    if (parentRecord != null) {
      result += context.l10n.createChild;
    } else if (record.getId().isEmpty) {
      result += context.l10n.create;
    } else {
      result += context.l10n.edit;
    }
    result += context.l10n.record;
    return result;
  }

  getHeader() {
    if (parentRecord != null) {
      return Container(
        padding: const EdgeInsets.only(bottom: 15, left: 20.0, right: 20),
        child: Card(
          color: Colors.white,
          shape: FixedValues.getCardBorder(10),
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Text(parentRecord!.getDescription(),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.black, fontSize: 15),),
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
          padding: const EdgeInsets.only(top: 5, left: 20.0, right: 55),
          child: InputField(
            timeController,
            TextInputType.datetime,
            recordValidatorProvider.validateTime,
            Icons.calendar_today,
            style: 1,
          )
      );
  }

  List<Widget> getBody(
      BuildContext context,
      Function(Record) onRecordSelected,
      TextEditingController amountController,
      TextEditingController descriptionController,
      TextEditingController timeController,
      Record record,
      double currentAmount,
      Function(double) onNewAmount) {

    List<Widget> result = [];
    result.add(getHeader());
    result.add(
      Container(
        padding: const EdgeInsets.only(left: 20.0, right: 55),
        child: InputField(
          descriptionController,
          TextInputType.text,
          recordValidatorProvider.validateDescription,
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
            constraints: BoxConstraints(maxHeight: ViewTools.getPercentageWidth(context, 95)),
            child: SingleChildScrollView(
              child:
              RecordList(
                recordValidatorProvider,
                  recordRepository,
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
              padding: const EdgeInsets.only(top: 5, left: 20.0, right: 55),
              child: InputField(
                amountController,
                TextInputType.phone,
                    (value) => recordValidatorProvider.validateAmount(
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