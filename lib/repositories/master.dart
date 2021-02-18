import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart' as crypt;
import 'package:hive/hive.dart';
import 'package:mobilesurvey/model/ao.dart';
import 'package:mobilesurvey/model/configuration.dart';
import 'package:mobilesurvey/model/quisioner.dart';
import 'package:mobilesurvey/model/zipcode.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/enum.dart';
import 'package:mobilesurvey/utilities/shared_preferences_utils.dart';

class MasterRepositories {
  static List<ZipCodeModel> _zipcodes;

  static List<ZipCodeModel> get zipcodes => _zipcodes;

  static List<QuisionerModel> _quisioners;

  static List<QuisionerModel> get quisioners => _quisioners;

  static List<AoModel> _ao;

  static List<AoModel> get ao => _ao;

  static void saveZipCodes(List<ZipCodeModel> value) {
    _saveToHive(value, master.zipcode);
    _zipcodes = value;
    _zipcodes.sort((a, b) => a.kota.compareTo(b.kota));
  }

  static void saveQuestion(List<QuisionerModel> value) {
    _saveToHive(value, master.question);
    _quisioners = value;
  }

  static void saveAO(List<AoModel> value) {
    _saveToHive(value, master.ao);
    _ao = value;
  }

  static void saveConfiguration(ConfigurationModel value) {
    PreferenceUtils.setString(kLastUpdateQuestion, value.lastUpdateQuestion);
    PreferenceUtils.setString(kLastUpdateZipCode, value.lastUpdateZipCode);
    PreferenceUtils.setString(kLastUpdateAO, value.lastUpdateAo);
  }

  static Future<void> _saveToHive(
      List<dynamic> value, master masterType) async {
    HiveAesCipher _chiper = _key();
    try {
      switch (masterType) {
        case master.zipcode:
          var box = await Hive.openBox<ZipCodeModel>(kHiveKeys_3, encryptionCipher: _chiper);
          await box.deleteAll(box.keys);
          List<ZipCodeModel> values = List<ZipCodeModel>.from(value);
          box.addAll(values);
          break;
        case master.ao:
          var box = await Hive.openBox<AoModel>(kHiveKeys_1,  encryptionCipher: _chiper);
          await box.deleteAll(box.keys);
          List<AoModel> values = List<AoModel>.from(value);
          box.addAll(values);
          break;
        case master.question:
          var box = await Hive.openBox<QuisionerModel>(kHiveKeys_2, encryptionCipher: _chiper);
          await box.deleteAll(box.keys);
          List<QuisionerModel> values = List<QuisionerModel>.from(value);
          box.addAll(values);
          break;
        default:
          break;
      }
    } catch (Exception) {
      print(Exception.toString());
    }
  }

  static Future<bool> readFromHive(master masterType) async {
    HiveAesCipher _chiper = _key();
    try {
      switch (masterType) {
        case master.question:
          bool _boxExists = await Hive.boxExists(kHiveKeys_2);
          if (_boxExists) {
            var box = await Hive.openBox<QuisionerModel>(kHiveKeys_2,
                encryptionCipher: _chiper);
            saveQuestion(box.values.toList());
          }
          return Future.value(true);
        case master.zipcode:
          bool _boxExists = await Hive.boxExists(kHiveKeys_3);
          if (_boxExists) {
            var box = await Hive.openBox<ZipCodeModel>(kHiveKeys_3,
                encryptionCipher: _chiper);
            saveZipCodes(box.values.toList());
          }
          return Future.value(true);
        case master.ao:
          bool _boxExists = await Hive.boxExists(kHiveKeys_1);
          if (_boxExists) {
            var box = await Hive.openBox<AoModel>(kHiveKeys_1,
                encryptionCipher: _chiper);
            saveAO(box.values.toList());
          }
          return Future.value(true);
        default:
          return Future.value(false);
      }
    } catch (Exception) {
      return Future.value(false);
    }
  }

  static HiveAesCipher _key(){
    var _keys = utf8.encode(kHiveKey);
    var _md5 = crypt.md5.convert(_keys);
    var _sha = crypt.sha256.convert(_md5.bytes);
    return HiveAesCipher(_sha.bytes);
  }
}
