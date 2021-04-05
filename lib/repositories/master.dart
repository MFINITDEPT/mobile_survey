import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart' as crypt;
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import '../model/ao.dart';
import '../model/configuration.dart';
import '../model/photo_form.dart';
import '../model/photo_result.dart';
import '../model/quisioner.dart';
import '../model/quisioner_answer.dart';
import '../model/zipcode.dart';
import '../utilities/constant.dart';
import '../utilities/enum.dart';
import '../utilities/shared_preferences_utils.dart';

// ignore: public_member_api_docs
Future<void> heavyTaskWriteZipCode(Map<String, dynamic> map) async {
  var hive = Hive..init(map['path']);

  if (!hive.isAdapterRegistered(ZipCodeModelAdapter().typeId)) {
    hive..registerAdapter(ZipCodeModelAdapter());
  }

  var box = await Hive.openBox<ZipCodeModel>(kHiveKeys_3,
      encryptionCipher: map['chiper']);

  await box.deleteAll(box.keys);
  var values = List<ZipCodeModel>.from(map['value']);
  await box.addAll(values);
}

// ignore: public_member_api_docs
Future<void> heavyTaskWriteAo(Map<String, dynamic> map) async {
  var hive = Hive..init(map['path']);
  if (!hive.isAdapterRegistered(AoModelAdapter().typeId)) {
    hive..registerAdapter(AoModelAdapter());
  }

  var box =
      await Hive.openBox<AoModel>(kHiveKeys_1, encryptionCipher: map['chiper']);
  await box.deleteAll(box.keys);
  var values = List<AoModel>.from(map['value']);
  await box.addAll(values);
}

// ignore: public_member_api_docs
Future<void> heavyTaskWriteQuestion(Map<String, dynamic> map) async {
  var hive = Hive..init(map['path']);
  if (!hive.isAdapterRegistered(QuisionerModelAdapter().typeId)) {
    hive..registerAdapter(QuisionerModelAdapter());
  }

  var box = await Hive.openBox<QuisionerModel>(kHiveKeys_2,
      encryptionCipher: map['chiper']);
  await box.deleteAll(box.keys);
  var values = List<QuisionerModel>.from(map['value']);
  await box.addAll(values);
}

// ignore: public_member_api_docs
Future<void> heavyTaskWritePhotoForm(Map<String, dynamic> map) async {
  var hive = Hive..init(map['path']);
  if (!hive.isAdapterRegistered(PhotoFormAdapter().typeId)) {
    hive..registerAdapter(PhotoFormAdapter());
  }

  var box = await Hive.openBox<PhotoForm>(kHiveKeys_4,
      encryptionCipher: map['chiper']);
  await box.deleteAll(box.keys);
  var values = List<PhotoForm>.from(map['value']);
  await box.addAll(values);
}

// ignore: public_member_api_docs
Future<void> heavyTaskWriteDocForm(Map<String, dynamic> map) async {
  var hive = Hive..init(map['path']);
  if (!hive.isAdapterRegistered(PhotoFormAdapter().typeId)) {
    hive..registerAdapter(PhotoFormAdapter());
  }

  var box = await Hive.openBox<PhotoForm>(kHiveKeys_5,
      encryptionCipher: map['chiper']);
  await box.deleteAll(box.keys);
  var values = List<PhotoForm>.from(map['value']);
  await box.addAll(values);
}

// ignore: avoid_classes_with_only_static_members, public_member_api_docs
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

  static List<QuisionerAnswerModel> _quisioner;

  static List<QuisionerAnswerModel> get quisionerList => _quisioner;

  static String hivePath;

  // ignore: public_member_api_docs, avoid_setters_without_getters
  static set saveQuisioner(List<QuisionerAnswerModel> value) =>
      _quisioner = value;

  // ignore: public_member_api_docs
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

  // ignore: public_member_api_docs
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

  // ignore: public_member_api_docs
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

  // ignore: public_member_api_docs
  static void saveZipCodes(List<ZipCodeModel> value) async {
    await _saveToHive(value, master.zipcode);
    _zipcodes = value;
    _zipcodes.sort((a, b) => a.kota.compareTo(b.kota));
  }

  // ignore: public_member_api_docs
  static void saveQuestion(List<QuisionerModel> value) async {
    await _saveToHive(value, master.question);
    _quisioners = value;
  }

  // ignore: public_member_api_docs
  static void saveAO(List<AoModel> value) async {
    await _saveToHive(value, master.ao);
    _ao = value;
  }

  // ignore: public_member_api_docs
  static void saveConfiguration(ConfigurationModel value) {
    PreferenceUtils.setString(kLastUpdateQuestion, value.lastUpdateQuestion);
    PreferenceUtils.setString(kLastUpdateZipCode, value.lastUpdateZipCode);
    PreferenceUtils.setString(kLastUpdateAO, value.lastUpdateAo);
    PreferenceUtils.setString(kLastUpdateForm, value.lastUpdateForm);
  }

  static Future<void> _saveToHive(
      List<dynamic> value, master masterType) async {
    var _chiper = _key();
    try {
      switch (masterType) {
        case master.zipcode:
          var map = <String,dynamic>{};
          map.putIfAbsent('chiper', () => _chiper);
          map.putIfAbsent('value', () => value);
          map.putIfAbsent('path', () => hivePath);
          await compute(heavyTaskWriteZipCode, map);
          break;
        case master.ao:
          var map = <String,dynamic>{};
          map.putIfAbsent('chiper', () => _chiper);
          map.putIfAbsent('value', () => value);
          map.putIfAbsent('path', () => hivePath);
          await compute(heavyTaskWriteAo, map);
          break;
        case master.question:
          var map = <String,dynamic>{};
          map.putIfAbsent('chiper', () => _chiper);
          map.putIfAbsent('value', () => value);
          map.putIfAbsent('path', () => hivePath);
          await compute(heavyTaskWriteQuestion, map);
          break;
        case master.pic:
          var map = <String,dynamic>{};
          map.putIfAbsent('chiper', () => _chiper);
          map.putIfAbsent('value', () => value);
          map.putIfAbsent('path', () => hivePath);
          await compute(heavyTaskWritePhotoForm, map);
          break;
        case master.doc:
          var map = <String,dynamic>{};
          map.putIfAbsent('chiper', () => _chiper);
          map.putIfAbsent('value', () => value);
          map.putIfAbsent('path', () => hivePath);
          await compute(heavyTaskWriteDocForm, map);
          break;
        default:
          break;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  // ignore: public_member_api_docs
  static Future<bool> readFromHive(master masterType) async {
    var _chiper = _key();
    try {
      switch (masterType) {
        case master.question:
          var _boxExists = await Hive.boxExists(kHiveKeys_2);
          if (_boxExists) {
            var box = await Hive.openBox<QuisionerModel>(kHiveKeys_2,
                encryptionCipher: _chiper);
            saveQuestion(box.values.toList());
          }
          return Future.value(true);
        case master.zipcode:
          var _boxExists = await Hive.boxExists(kHiveKeys_3);
          if (_boxExists) {
            var box = await Hive.openBox<ZipCodeModel>(kHiveKeys_3,
                encryptionCipher: _chiper);
            saveZipCodes(box.values.toList());
          }
          return Future.value(true);
        case master.ao:
          var _boxExists = await Hive.boxExists(kHiveKeys_1);
          if (_boxExists) {
            var box = await Hive.openBox<AoModel>(kHiveKeys_1,
                encryptionCipher: _chiper);
            saveAO(box.values.toList());
          }
          return Future.value(true);
        case master.pic:
          var _boxExists = await Hive.boxExists(kHiveKeys_4);
          if (_boxExists) {
            var box = await Hive.openBox<PhotoForm>(kHiveKeys_4,
                encryptionCipher: _chiper);
            savePhotoForm(box.values.toList(), master.pic);
          }
          return Future.value(true);
        case master.doc:
          var _boxExists = await Hive.boxExists(kHiveKeys_5);
          if (_boxExists) {
            var box = await Hive.openBox<PhotoForm>(kHiveKeys_5,
                encryptionCipher: _chiper);
            savePhotoForm(box.values.toList(), master.doc);
          }
          return Future.value(true);
        default:
          return Future.value(false);
      }
    } on Exception catch (e) {
      print(e.toString());
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
