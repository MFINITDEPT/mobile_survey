import 'package:date_utils/date_utils.dart';
import 'package:intl/intl.dart';

// ignore: public_member_api_docs
class DateUtilities {
  // ignore: public_member_api_docs
  static DateTime convertStringDate(String date,
      {String format = 'dd/MM/yyyy'}) {
    try {
      var _df = DateFormat(format);
      if (date == null) throw Exception("Date Null");
      return _df.parse(date);
    } on Exception catch (e) {
      return null;
    }
  }

  // ignore: public_member_api_docs
  static String convertDateTimeToString(DateTime dateTime,
      {String format = 'dd/MM/yyyy'}) {
    try {
      var _df = DateFormat(format);
      if (dateTime == null) throw Exception("Date Null");
      return _df.format(dateTime);
    } on Exception catch (e) {
      return null;
    }
  }

  // ignore: public_member_api_docs
  static String convertDateTimeToTimeString(DateTime dateTime,
      {String format = 'hh.mm'}) {
    try {
      var _df = DateFormat(format);
      if (dateTime == null) throw Exception("Date Null");
      return _df.format(dateTime);
    } on Exception catch (e) {
      return null;
    }
  }

  static List<DateTime> getNowAndOneMonthBefore(DateTime now) {
    var result = List<DateTime>(2);
    DateTime lastMonth;
    if (now.day == Utils.lastDayOfMonth(now).day) {
      lastMonth = now.month == 1
          ? DateTime(now.year - 1, 12)
          : DateTime(now.year, now.month - 1);
      result[0] = now;
      result[1] = Utils.lastDayOfMonth(lastMonth);
    } else {
      lastMonth = now.month == 1
          ? DateTime(now.year - 1, 12, now.day)
          : DateTime(now.year, now.month - 1, now.day);
      result[0] = (now);
      result[1] = (lastMonth);
    }

    return result;
  }

  static DateTime now() => DateTime.now();

  static DateTime getMonth(int x) {
    switch (x) {
      case 0:
        return DateTime(now().year, 12);
      case 1:
        return DateTime(now().year, 1);
      case 2:
        return DateTime(now().year, 2);
      case 3:
        return DateTime(now().year, 3);
      case 4:
        return DateTime(now().year, 4);
      case 5:
        return DateTime(now().year, 5);
      case 6:
        return DateTime(now().year, 6);
      case 7:
        return DateTime(now().year, 7);
      case 8:
        return DateTime(now().year, 8);
      case 9:
        return DateTime(now().year, 9);
      case 10:
        return DateTime(now().year, 10);
      case 11:
        return DateTime(now().year, 11);
    }
  }
}
