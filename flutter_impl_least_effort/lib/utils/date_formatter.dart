import 'package:intl/intl.dart';

extension DateFormatter on DateTime {
  String toFormattedDate() {
    return DateFormat(DateFormat.YEAR_NUM_MONTH_DAY, 'de_DE').format(this);
  }
}
