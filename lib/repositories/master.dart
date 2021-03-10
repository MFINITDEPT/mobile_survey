import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart' as crypt;
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:mobilesurvey/model/ao.dart';
import 'package:mobilesurvey/model/configuration.dart';
import 'package:mobilesurvey/model/photo_form.dart';
import 'package:mobilesurvey/model/photo_result.dart';
import 'package:mobilesurvey/model/quisioner.dart';
import 'package:mobilesurvey/model/zipcode.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/enum.dart';
import 'package:mobilesurvey/utilities/shared_preferences_utils.dart';

Future<void> heavyTaskWriteZipCode(Map<String, dynamic> map) async {
  HiveInterface hive = Hive..init(map['path']);
  if (!hive.isAdapterRegistered(ZipCodeModelAdapter().typeId))
    hive..registerAdapter(ZipCodeModelAdapter());
  var box = await Hive.openBox<ZipCodeModel>(kHiveKeys_3,
      encryptionCipher: map['chiper']);
  await box.deleteAll(box.keys);
  List<ZipCodeModel> values = List<ZipCodeModel>.from(map['value']);
  await box.addAll(values);
}

Future<void> heavyTaskWriteAo(Map<String, dynamic> map) async {
  HiveInterface hive = Hive..init(map['path']);
  if (!hive.isAdapterRegistered(AoModelAdapter().typeId))
    hive..registerAdapter(AoModelAdapter());
  var box =
      await Hive.openBox<AoModel>(kHiveKeys_1, encryptionCipher: map['chiper']);
  await box.deleteAll(box.keys);
  List<AoModel> values = List<AoModel>.from(map['value']);
  await box.addAll(values);
}

Future<void> heavyTaskWriteQuestion(Map<String, dynamic> map) async {
  HiveInterface hive = Hive..init(map['path']);
  if (!hive.isAdapterRegistered(QuisionerModelAdapter().typeId))
    hive..registerAdapter(QuisionerModelAdapter());
  var box = await Hive.openBox<QuisionerModel>(kHiveKeys_2,
      encryptionCipher: map['chiper']);
  await box.deleteAll(box.keys);
  List<QuisionerModel> values = List<QuisionerModel>.from(map['value']);
  await box.addAll(values);
}

Future<void> heavyTaskWritePhotoForm(Map<String, dynamic> map) async {
  HiveInterface hive = Hive..init(map['path']);
  if (!hive.isAdapterRegistered(PhotoFormAdapter().typeId))
    hive..registerAdapter(PhotoFormAdapter());
  var box = await Hive.openBox<PhotoForm>(kHiveKeys_4,
      encryptionCipher: map['chiper']);
  await box.deleteAll(box.keys);
  List<PhotoForm> values = List<PhotoForm>.from(map['value']);
  await box.addAll(values);
}

Future<void> heavyTaskWriteDocForm(Map<String, dynamic> map) async {
  HiveInterface hive = Hive..init(map['path']);
  if (!hive.isAdapterRegistered(PhotoFormAdapter().typeId))
    hive..registerAdapter(PhotoFormAdapter());
  var box = await Hive.openBox<PhotoForm>(kHiveKeys_5,
      encryptionCipher: map['chiper']);
  await box.deleteAll(box.keys);
  List<PhotoForm> values = List<PhotoForm>.from(map['value']);
  await box.addAll(values);
}

class MasterRepositories {
  static List<ZipCodeModel> _zipcodes;

  static List<ZipCodeModel> get zipcodes => _zipcodes;

  static List<QuisionerModel> _quisioners;

  static List<QuisionerModel> get quisioners => _quisioners;

  static List<AoModel> _ao;

  static List<AoModel> get ao => _ao;

  static List<String> get aoList =>
      MasterRepositories.ao.map((e) => e.descs).toList();

  static List<PhotoForm> _photoForm;

  static List<PhotoForm> get photoForm => _photoForm;

  static List<PhotoForm> _docPhoto;

  static List<PhotoForm> get docPhoto => _docPhoto;

  static List<PhotoResult> _photoFormResult;

  static List<PhotoResult> get photoFormResult => _photoFormResult;

  static List<PhotoResult> _docFormResult;

  static List<PhotoResult> get docFormResult => _docFormResult;

  static String hivePath;

  static void clearSavedPhotoFormResult(master type) {
    switch (type) {
      case master.doc:
        _docFormResult = null;
        break;
      case master.pic:
        _photoFormResult = null;
        break;
      default:
        break;
    }
  }

  static void savePhotoFormResult(List<PhotoResult> value, master type) {
    switch (type) {
      case master.doc:
        _docFormResult = value;
        break;
      case master.pic:
        _photoFormResult = value;
        break;
      default:
        break;
    }
  }

  static void savePhotoForm(List<PhotoForm> value, master type) async {
    //type 1 = foto; 0 = dokumen
    switch (type) {
      case master.doc:
        await _saveToHive(value, master.doc);
        _docPhoto = value;
        break;
      case master.pic:
        await _saveToHive(value, master.pic);
        _photoForm = value;
        break;
      default:
        return;
    }
  }

  static void saveZipCodes(List<ZipCodeModel> value) async {
    await _saveToHive(value, master.zipcode);
    _zipcodes = value;
    _zipcodes.sort((a, b) => a.kota.compareTo(b.kota));
  }

  static void saveQuestion(List<QuisionerModel> value) async {
    await _saveToHive(value, master.question);
    _quisioners = value;
  }

  static void saveAO(List<AoModel> value) async {
    await _saveToHive(value, master.ao);
    _ao = value;
  }

  static void saveConfiguration(ConfigurationModel value) {
    PreferenceUtils.setString(kLastUpdateQuestion, value.lastUpdateQuestion);
    PreferenceUtils.setString(kLastUpdateZipCode, value.lastUpdateZipCode);
    PreferenceUtils.setString(kLastUpdateAO, value.lastUpdateAo);
    PreferenceUtils.setString(kLastUpdateForm, value.lastUpdateForm);
  }

  static Future<void> _saveToHive(
      List<dynamic> value, master masterType) async {
    HiveAesCipher _chiper = _key();
    try {
      switch (masterType) {
        case master.zipcode:
          Map<String, dynamic> map = Map<String, dynamic>();
          map.putIfAbsent('chiper', () => _chiper);
          map.putIfAbsent('value', () => value);
          map.putIfAbsent('path', () => hivePath);
          await compute(heavyTaskWriteZipCode, map);
          break;
        case master.ao:
          Map<String, dynamic> map = Map<String, dynamic>();
          map.putIfAbsent('chiper', () => _chiper);
          map.putIfAbsent('value', () => value);
          map.putIfAbsent('path', () => hivePath);
          await compute(heavyTaskWriteAo, map);
          break;
        case master.question:
          Map<String, dynamic> map = Map<String, dynamic>();
          map.putIfAbsent('chiper', () => _chiper);
          map.putIfAbsent('value', () => value);
          map.putIfAbsent('path', () => hivePath);
          await compute(heavyTaskWriteQuestion, map);
          break;
        case master.pic:
          Map<String, dynamic> map = Map<String, dynamic>();
          map.putIfAbsent('chiper', () => _chiper);
          map.putIfAbsent('value', () => value);
          map.putIfAbsent('path', () => hivePath);
          await compute(heavyTaskWritePhotoForm, map);
          break;
        case master.doc:
          Map<String, dynamic> map = Map<String, dynamic>();
          map.putIfAbsent('chiper', () => _chiper);
          map.putIfAbsent('value', () => value);
          map.putIfAbsent('path', () => hivePath);
          await compute(heavyTaskWriteDocForm, map);
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
        case master.pic:
          bool _boxExists = await Hive.boxExists(kHiveKeys_4);
          if (_boxExists) {
            var box = await Hive.openBox<PhotoForm>(kHiveKeys_4,
                encryptionCipher: _chiper);
            savePhotoForm(box.values.toList(), master.pic);
          }
          return Future.value(true);
        case master.doc:
          bool _boxExists = await Hive.boxExists(kHiveKeys_5);
          if (_boxExists) {
            var box = await Hive.openBox<PhotoForm>(kHiveKeys_5,
                encryptionCipher: _chiper);
            savePhotoForm(box.values.toList(), master.doc);
          }
          return Future.value(true);
        default:
          return Future.value(false);
      }
    } catch (Exception) {
      print(Exception.toString());
      return Future.value(false);
    }
  }

  static HiveAesCipher _key() {
    var _keys = utf8.encode(kHiveKey);
    var _md5 = crypt.md5.convert(_keys);
    var _sha = crypt.sha256.convert(_md5.bytes);
    return HiveAesCipher(_sha.bytes);
  }
}
