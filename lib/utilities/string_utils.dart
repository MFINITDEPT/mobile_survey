import 'package:intl/intl.dart';

import 'enum.dart';

class StringUtils {
  static String getContentType(contentType type) {
    switch (type) {
      case contentType.json:
        return 'application/json';
      case contentType.urlEncoded:
        return 'application/x-www-form-urlencoded';
      case contentType.html:
        return 'text/html';
      case contentType.multipart:
        return 'multipart/form-data';
    }
  }

  static String simpleNumber(num number) {
    String string = number.toInt().toString();
    String result = '';

    if (string.length <= 3) result = string;

    if (string.length > 3 && string.length <= 6) {
      var newString = _getSimpleNumber(string, 3);
      if (newString == "00") {
        result = '${string.substring(0, (string.length - 3))}K';
      } else {
        result =
            '${string.substring(0, (string.length - 3))},${newString.endsWith('0') ? newString.replaceAll('0', '') : newString}K';
      }
    }

    if (string.length > 6 && string.length <= 9) {
      var newString = _getSimpleNumber(string, 6);
      if (newString == "00") {
        result = '${string.substring(0, (string.length - 6))}M';
      } else {
        result =
            '${string.substring(0, (string.length - 6))},${newString.endsWith('0') ? newString.replaceAll('0', '') : newString}M';
      }
    }

    if (string.length > 9) {
      if (string.length <= 12) {
        var newString = _getSimpleNumber(string, 9);
        if (newString == "00") {
          result = '${string.substring(0, (string.length - 9))}B';
        } else {
          result =
              '${string.substring(0, (string.length - 9))},${newString.endsWith('0') ? newString.replaceAll('0', '') : newString}B';
        }
      } else {
        var newString = _getSimpleNumber(string, 9);
        if (newString == "00") {
          result = '${string.substring(0, (string.length - 9))}B';
        } else {
          result =
              '${string.substring(0, (string.length - 9))},${newString.endsWith('0') ? newString.replaceAll('0', '') : newString}B';
        }
      }
    }

    return result;
  }

  static String _getSimpleNumber(String string, int start) => string.length > 12
      ? string[string.length - 9] + string[string.length - 8]
      : string.substring(string.length - ((start - 3) + 1) - 2,
          string.length - ((start - 3) + 1));

  static String formatNumber(num number) {
    try {
      NumberFormat _nf = NumberFormat('#,###', 'id');
      return _nf.format(number);
    } catch (Exception) {
      return 'error';
    }
  }
}
