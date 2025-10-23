import 'package:intl/intl.dart';

extension DateTimeFormatting on DateTime {
  String get toYearMonthDay => DateFormat('yyyy-MM-dd').format(this);
}
