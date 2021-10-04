import 'package:intl/intl.dart';

extension FormatDate on DateTime {
  String format(String pattern) {
    final DateFormat formatter = DateFormat(pattern);
    return formatter.format(this);
  }
}

/*extension StringToDate on String{
  DateTime toDateTime({String? pattern}){
    final DateFormat formatter = DateFormat(pattern);
    if(pattern==null){
      return DateTime.parse(this);
    }
    return formatter.parse(this);
  }
}*/
