import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension MyInt on int {
  String toDateString() {
    return DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(this));
  }
}

String dateMillisecondsToString(int mills) {
  return DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(mills));
}

class DateUtil {
  static String timeNow() {
    String result;
    if (TimeOfDay.now().hour > 12) {
      result = (TimeOfDay.now().hour - 12).toString() +
          ':' +
          TimeOfDay.now().minute.toString() +
          'PM';
    } else {
      result = TimeOfDay.now().hour.toString() +
          ':' +
          TimeOfDay.now().minute.toString() +
          'AM';
    }
    return result;
  }
}