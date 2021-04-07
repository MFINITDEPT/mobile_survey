import 'package:intl/intl.dart';

// ignore: public_member_api_docs
class DateUtils {
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
}
