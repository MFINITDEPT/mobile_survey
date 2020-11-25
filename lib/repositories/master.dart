import 'dart:io';

import 'package:mobilesurvey/model/zipcode.dart';
import 'package:mobilesurvey/utilities/string_utils.dart';
import 'package:path_provider/path_provider.dart';

class MasterRepositories {
  static List<ZipCodeModel> _zipcodes;

  static List<ZipCodeModel> get zipcodes => _zipcodes;

  static void saveZipCodes(List<ZipCodeModel> value) {
    _saveToLocalStorage(value);
    _zipcodes = value;
    _zipcodes.sort((a, b) => a.kota.compareTo(b.kota));
  }

  static Future<void> _saveToLocalStorage(List<ZipCodeModel> value) async {
    Directory dir = await getExternalStorageDirectory();
    File file = File("${dir.path}/${StringUtils.formatDate(DateTime.now(), format: 'ddMMyyyy')}.json");
    file.writeAsString("coba");
    print(file.path);
  }
}
