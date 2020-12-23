import 'package:intl/intl.dart';

class DateUtils {
  static DateTime convertStringDate(String date,
      {String format = 'dd/MM/yyyy'}) {
    try {
      DateFormat _df = DateFormat(format);
      return _df.parse(date);
    } catch (Exception) {
      return null;
    }
  }
}
