import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MahasFormat {
  static String displayDate(DateTime? date) {
    if (date == null) return "-";
    var dateFormat = DateFormat("dd MMMM yyyy");
    return dateFormat.format(date);
  }

  static String displayTime(
    TimeOfDay? time, {
    bool twentyFour = true,
    bool returnNull = false,
  }) {
    if (time == null) return "-";
    var hour =
        twentyFour ? time.hour : (time.hour > 12 ? time.hour - 12 : time.hour);
    if (hour == 0) {
      hour = 12;
    }
    var minute = time.minute;
    var strHour = hour > 9 ? '$hour' : '0$hour';
    var strMinute = minute > 9 ? '$minute' : '0$minute';
    var r = "$strHour:$strMinute";
    return twentyFour ? r : '$r ${time.hour > 12 ? 'PM' : 'AM'}';
  }

  static DateTime? stringToDate(String? stringDate) {
    if (stringDate == null) return null;
    try {
      return DateTime.parse(stringDate);
    } catch (ex) {
      return null;
    }
  }

  static TimeOfDay? stringToTime(String? time) {
    if (time == null) return null;
    final add = time.indexOf("PM") > 0 ? 12 : 0;
    final r = TimeOfDay(
        hour: int.parse(time.split(":")[0]) + add,
        minute: int.parse(time.split(":")[1].split(' ')[0]));
    return r;
  }

  static String toCurrency(double? value) {
    if (value == null) return "";
    var numberFormat = NumberFormat('#,###');
    return numberFormat.format(value);
  }

  static double currencyToDouble(String? value) {
    if (value == null) return 0;
    value = value.replaceAll(',', '');
    return double.parse(value);
  }

  static double? dynamicToDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value);
  }
}
