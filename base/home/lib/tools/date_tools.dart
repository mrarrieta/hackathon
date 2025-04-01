import 'package:ui/tools/fixed_values.dart';

class DateTools {
  DateTools();

  DateTime getFirstDayForMonth(int year, int month){
    DateTime result = DateTime(year, month, 1, 0, 0, 0);
    return result;
  }

  DateTime getLastDayForMonth(int year, int month){
    DateTime result = DateTime(year, month+1, 0, 23, 59, 59);
    return result;
  }
}

extension DateExtentions on DateTime {
  String format() {
    return FixedValues.date.format(this);
  }
}