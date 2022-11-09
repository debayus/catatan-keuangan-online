import 'package:intl/intl.dart';

class MahasDateFormat {
  static String displayDate(DateTime? date) {
    if (date == null) return "-";
    var dateFormat = DateFormat("dd MMMM yyyy");
    return dateFormat.format(date);
  }

  static DateTime? stringToDate(String? stringDate) {
    if (stringDate == null) return null;
    try {
      return DateTime.parse(stringDate);
    } catch (ex) {
      return null;
    }
  }
}
