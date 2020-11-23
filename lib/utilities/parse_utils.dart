import 'package:intl/intl.dart';

class ParseUtils {
  static String castString(var object, [String defaultValue]) {
    defaultValue = "";

    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : "$object";
  }

  static int castInt(var object, [int defaultValue]) {
    defaultValue = 0;

    if (object == null && defaultValue == null) return null;

    if (object == null) {
      return defaultValue;
    } else {
      if (object is num) {
        return (object).toInt();
      } else if (object is String) {
        return int.tryParse(object);
      } else {
        return null;
      }
    }
  }

  static double castDouble(var object, [double defaultValue]) {
    defaultValue = 0;

    if (object == null && defaultValue == null) return null;

    if (object == null) {
      return defaultValue;
    } else {
      if (object is num) {
        return (object).toDouble();
      } else if (object is String) {
        return double.tryParse(object);
      } else {
        return null;
      }
    }
  }

  static bool castBool(var object, [bool defaultValue]) {
    defaultValue = false;

    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : (object as bool);
  }

  static List castList(var object, [List defaultValue]) {
    defaultValue = [];
    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : object as List;
  }

  static Map castMap(var object, [Map defaultValue]) {
    defaultValue = {};

    if (object == null && defaultValue == null) return null;

    return object == null ? defaultValue : object as Map;
  }

  static DateTime castDate8601(var object, [DateTime defaultValue]) {
    if (object == null && defaultValue == null) return null;
    if (!(object is String) || object == null || object.isEmpty) return null;

    DateFormat result = DateFormat("yyyy-MM-dd'T'hh:mm:ss");
    DateTime dt;
    try {
      dt = result.parse(object);
    } on Exception catch (e) {
      DateFormat anotherFormat = DateFormat("yyyy-MM-dd");

      try {
        dt = anotherFormat.parse(object);
      } on Exception catch (e) {
        DateFormat yetAnotherFormat = DateFormat("hh:mm a");
        dt = yetAnotherFormat.parse(object);
      }
    }
    return dt;
  }
//
//  static DateTime castDateYmd(var object, [DateTime defaultValue]) {
//    if (object == null && defaultValue == null) return null;
//
//    return object == null
//        ? defaultValue
//        : DateTimeHelper.stringToDateYmd(object);
//  }
//
//  static DateTime castDateYmdHm(var object, [DateTime defaultValue]) {
//    if (object == null && defaultValue == null) return null;
//
//    return object == null
//        ? defaultValue
//        : DateTimeHelper.stringToDateYmdHm(object);
//  }
//
//  static DateTime castDateYyyyMm(var object, [DateTime defaultValue]) {
//    if (object == null && defaultValue == null) return null;
//    return object == null
//        ? defaultValue
//        : DateTimeHelper.stringToDateYyyyMm(object);
//  }
}
