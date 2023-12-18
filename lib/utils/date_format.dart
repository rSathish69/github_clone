import 'package:intl/intl.dart';

extension DateFormatter on String {
  String dateFormat() {
    var date =
        DateFormat("yyyy-MM-dd - h:mm:a").format(DateTime.parse(toString()));
    return date;
  }
}
