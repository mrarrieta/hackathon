import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home/data/record.dart';
import 'package:home/tools/amount_tools.dart';
import 'package:locale/l10n/core_localizations.dart';
import 'package:ui/tools/fixed_values.dart';
import 'package:ui/tools/date_tools.dart';

class RecordValidatorProvider{
  RecordValidatorProvider(this.appLocalizations, this.dateTools);

  final CoreLocalizations appLocalizations;
  final DateTools dateTools;
  String previousValue = "";

  String? validateDescription(String? value){
    if(value!.isEmpty){
      return appLocalizations.invalidDescription;
    }
    return null;
  }

  String? validateAmount(String value, Record record, TextEditingController amountController, Function(double) onNewValue) {
    if (value.isEmpty || value == '\$') {
      previousValue = value;
      return appLocalizations.invalidNumber;
    } else {
      if (previousValue != value) {
        try {
          var result = AmountTools.getAmount(
              false, record, amountController);
          if (result != null) {
            previousValue = value;
            onNewValue.call(result);
          }
        } catch (exception) {
          if (kDebugMode) {
            print(exception);
          }
          previousValue = value;
          return appLocalizations.invalidNumber;
        }
      }
    }
    previousValue = value;
    return null;
  }

  String? validateTime(String? value) {
    try {
      var selectedDate = FixedValues.date.parse(value!);
      var splitted = value.split('-');
      var firstDay = dateTools.getFirstDayForMonth(int.parse(splitted[0]), int.parse(splitted[1]));
      var lastDay = dateTools.getLastDayForMonth(int.parse(splitted[0]), int.parse(splitted[1]));
      if(selectedDate.isAfter(firstDay) || selectedDate.isAtSameMomentAs(firstDay)){
        if(selectedDate.isBefore(lastDay) || selectedDate.isAtSameMomentAs(lastDay)){
          return null;
        } else {
          return " max is ${lastDay.toString().split(" ")[0]}";
        }
      } else {
        return " min is ${firstDay.toString().split(" ")[0]}";
      }
    }catch(exception){
      if (kDebugMode) {
        print(exception);
      }
      return appLocalizations.invalidDate;
    }
  }

}