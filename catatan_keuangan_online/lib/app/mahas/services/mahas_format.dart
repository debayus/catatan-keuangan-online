import 'package:intl/intl.dart';

class MahasFormat {
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

  static String toCurrency(double? value) {
    if (value == null) return "";
    var numberFormat = NumberFormat('#,###');
    return numberFormat.format(value);
  }

  static double currencyToString(String? value) {
    if (value == null) return 0;
    value = value.replaceAll(',', '');
    return double.parse(value);
  }
}
