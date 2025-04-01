import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:home/data/record.dart';
import 'package:ui/tools/fixed_values.dart';

class AmountTools{

  static int times = 0;

  static String clean(String text){
    String result;
    result = text.replaceAll(',', '');
    result = result.replaceAll('\$', '');
    result = result.replaceAll('*', '');
    result = result.replaceAll('#', '');
    result = result.replaceAll(';', '');
    result = result.replaceAll('(', '');
    result = result.replaceAll(')', '');
    result = result.replaceAll('/', '');
    result = result.replaceAll('N', '');
    return result;
  }

  static double? getAmount(bool isFinal, Record record, TextEditingController? amountController){
    if(amountController != null && times == 0) {
      //print("Amount "+amountController.text);
      int initialOffset = amountController.selection.extentOffset;
      int initialLength = amountController.text.length;
      String initialValue = amountController.text;
      amountController.text = clean(amountController.text);
      //print("Clean Amount "+amountController.text);
      bool hadMultipleDots = false;
      double? result;
      if (amountController.text != '-') {
        var value = amountController.text;
        // detects when we want to write decimal data
        if('.'.allMatches(value).length >= 2 && !_isOperation(amountController)) {
          value = value.replaceFirst('.','');
          hadMultipleDots = true;
        }
        if(value.contains(".") && initialOffset > value.indexOf(".")) {
          if (kDebugMode) {
            print("previous: $value");
          }
          // remove extra digits after . when a new one is added
          value = value.substring(0, value.indexOf(".")+3);
          if (kDebugMode) {
            print("cutted decimals: $value");
          }
        }
        if (_isOperation(amountController) && isFinal) {
          result = _getOperationAmount(amountController);
        } else if (!_isOperation(amountController)) {
          result = double.parse(value);
        }
      }
      if (!amountController.text.contains('.') ||
          !amountController.text.contains('\$')) {
        if (amountController.text != '-' && !_isOperation(amountController)) {
          amountController.text = FixedValues.currency.format(result);
          // this ignores false triggers after first change
          if(hadMultipleDots) {
            times++;
          }
        }
        // ignores cursor fix when a decimal is changed
        int realOffset = hadMultipleDots ? amountController.text.indexOf('.')+1 : _getRealOffset(
            initialOffset,
            initialLength,
            amountController.text.length,
            amountController.text,
            initialValue
        );
        //print("Real Offset "+realOffset.toString());
        if (realOffset > amountController.text.length) {
          realOffset = amountController.text.length;
        }
        amountController.selection =
            TextSelection.fromPosition(TextPosition(offset: realOffset));
      }
      return result;
    } else {
      times = 0;
    }
    return 0.0;
  }

  static bool _isOperation(TextEditingController amountController) {
    var minusOperations = '-'.allMatches(amountController.text).length;
    //print("Minus "+minusOperations.toString());
    var plusOperations = '+'.allMatches(amountController.text).length;
    //print("Plus "+plusOperations.toString());
    var lastChar = amountController.text.characters.last;
    //print("Last Char "+lastChar);
    var firstChar = amountController.text.characters.first;
    //print("First Char "+firstChar);
    return minusOperations + plusOperations > 1 || lastChar == '-' ||  lastChar == '+' ||
        (minusOperations == 1 && firstChar != '-' ) || (plusOperations == 1 && firstChar != '+' );
  }

  static double _getOperationAmount(TextEditingController amountController){
    double result = 0;
    amountController.text.split('-').asMap().forEach((negativeIndex,negativeElement) {
      if(negativeElement.isNotEmpty){
        if(negativeElement.contains('+')) {
          negativeElement.split('+').asMap().forEach((positiveIndex, positiveElement) {
            if(positiveElement.isNotEmpty) {
              if(positiveIndex == 0 && negativeIndex != 0) {
                //print("Negative Element " + negativeElement);
                result -= double.parse(positiveElement);
              }else{
                //print("Positive Element " + positiveElement);
                result += double.parse(positiveElement);
              }
              //print("Result " + result.toString());
            }
          });
        } else {
          if(negativeIndex == 0) {
            //print("Positive Element " + negativeElement);
            result += double.parse(negativeElement);
          }else{
            //print("Negative Element " + negativeElement);
            result -= double.parse(negativeElement);
          }
        }
        //print("Result " + result.toString());
      }
    });
    //print("Result " + result.toString());
    return result;
  }

  static int _getRealOffset(int initialOffset, int initialLength, int newLength, String value, String initialValue) {
    if (kDebugMode) {
      print("initial length $initialLength / new length $newLength / initial offset $initialOffset / initial Value $initialValue");
    }
    if(!value.contains('-') && initialLength > 1 || value.contains('-') && initialLength > 2) {
      if (initialLength < newLength) {
        // add extra offset if , are added.
        return initialOffset + (newLength - initialLength);
      } else if (initialLength > newLength) {
        // add extra offset if , are removed.
        return initialOffset + (newLength - initialLength);
      } else if(initialLength == newLength && initialOffset >= newLength-2) {
        // add extra offset if added number after the .
        return initialOffset + 1;
      }
    } else if (!value.contains('-') && initialLength == 1 || value.contains('-') && initialLength == 2) {
      // add extra offset if $ is added.
      return initialOffset + 1;
    }
    if(initialOffset == 1) {
      // add extra offset if added number before $
      return initialOffset+1;
    }
    return initialOffset;
  }
}