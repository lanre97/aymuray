import 'package:intl/intl.dart';

extension FormatDate on DateTime {
  String format(String pattern) {
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(this);
  }
}