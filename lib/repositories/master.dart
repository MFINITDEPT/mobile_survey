import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart' as crypt;
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:mobilesurvey/model/master_configuration/configuration.dart';
import 'package:mobilesurvey/model/master_configuration/form_upload_item.dart';
import 'package:mobilesurvey/model/master_configuration/quisioner_item.dart';
import 'package:mobilesurvey/model/master_configuration/zipcode_item.dart';
import 'package:mobilesurvey/model/mobile_survey/document_item.dart';
import 'package:mobilesurvey/utilities/hive_utils.dart';
import '../model/master_configuration/form_upload_item.dart';
import '../model/master_configuration/quisioner_item.dart';
import '../model/master_configuration/zipcode_item.dart';
import '../model/mobile_survey/photo_result.dart';
import '../model/mobile_survey/quisioner_answer.dart';
import '../utilities/constant.dart';
import '../utilities/enum.dart';
import '../utilities/shared_preferences_utils.dart';

Future<void> heavyTaskWriteZipCode(Map<String, dynamic> map) async {
  var hive = Hive..init(map['path']);

  if (!hive.isAdapterRegistered(ZipCodeItemAdapter().typeId)) {
    hive..registerAdapter(ZipCodeItemAdapter());
  }

  var box = await Hive.openBox<ZipCodeItem>(kHiveKeys_3,
      encryptionCipher: map['chiper']);

  await box.deleteAll(box.keys);
  var values = List<ZipCodeItem>.from(map['value']);
  await box.addAll(values);
}

Future<void> heavyTaskWriteQuestion(Map<String, dynamic> map) async {
  var hive = Hive..init(map['path']);
  if (!hive.isAdapterRegistered(QuisionerItemAdapter().typeId)) {
    hive..registerAdapter(QuisionerItemAdapter());
  }

  var box = await Hive.openBox<QuisionerItem>(kHiveKeys_2,
      encryptionCipher: map['chiper']);
  await box.deleteAll(box.keys);
  var values = List<QuisionerItem>.from(map['value']);
  await box.addAll(values);
}

Future<void> heavyTaskWritePhotoForm(Map<String, dynamic> map) async {
  var hive = Hive..init(map['path']);
  if (!hive.isAdapterRegistered(FormUploadItemAdapter().typeId)) {
    hive..registerAdapter(FormUploadItemAdapter());
  }

  var box = await Hive.openBox<FormUploadItem>(kHiveKeys_4,
      encryptionCipher: map['chiper']);
  await box.deleteAll(box.keys);
  var values = List<FormUploadItem>.from(map['value']);
  await box.addAll(values);
}

/*Future<void> heavyTaskWriteDocForm(Map<String, dynamic> map) async {
  var hive = Hive..init(map['path']);
  if (!hive.isAdapterRegistered(PhotoFormAdapter().typeId)) {
    hive..registerAdapter(PhotoFormAdapter());
  }

  var box = await Hive.openBox<PhotoForm>(kHiveKeys_5,
      encryptionCipher: map['chiper']);
  await box.deleteAll(box.keys);
  var values = List<PhotoForm>.from(map['value']);
  await box.addAll(values);
}*/

class MasterRepositories {
  static List<ZipCodeItem> _zipcodes;

  static List<ZipCodeItem> get zipcodes => _zipcodes;

  static List<QuisionerItem> _quisioners;

  static List<QuisionerItem> get quisioners => _quisioners;

  static List<FormUploadItem> _photoForm;

  static List<FormUploadItem> get photoForm => _photoForm;

  static List<PhotoResult> _photoFormResult;

  static List<PhotoResult> get photoFormResult => _photoFormResult;

  static List<PhotoResult> _docFormResult;

  static List<PhotoResult> get docFormResult => _docFormResult;

  static List<QuisionerAnswerModel> _quisioner;

  static List<QuisionerAnswerModel> get quisionerList => _quisioner;

  static String hivePath;

  static set saveQuisioner(List<QuisionerAnswerModel> value) =>
      _quisioner = value;

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

  static void savePhotoForm(List<FormUploadItem> value) async {
    await _saveToHive(value, master.pic);
    _photoForm = value;
  }

  static void saveZipCodes(List<ZipCodeItem> value) async {
    _zipcodes = value;
    _zipcodes.sort((a, b) => a.kota.compareTo(b.kota));
    await _saveToHive(value, master.zipcode);

  }

  static void saveQuestion(List<QuisionerItem> value) async {
    await _saveToHive(value, master.question);
    _quisioners = value;
  }

  static void saveConfiguration(ConfigurationModel value) {
    PreferenceUtils.setString(kLastUpdateQuestion, value.quisionerUpdate);
    PreferenceUtils.setString(kLastUpdateZipCode, value.zipCodeUpdate);
    PreferenceUtils.setString(kLastUpdateForm, value.formUpdate);
  }

  static Future<void> _saveToHive(
      List<dynamic> value, master masterType) async {
    var _chiper = _key();
    try {
      switch (masterType) {
        case master.zipcode:
          var map = <String, dynamic>{};
          map.putIfAbsent('chiper', () => _chiper);
          map.putIfAbsent('value', () => value);
          map.putIfAbsent('path', () => hivePath);
          await compute(heavyTaskWriteZipCode, map);
          break;
        case master.question:
          var map = <String, dynamic>{};
          map.putIfAbsent('chiper', () => _chiper);
          map.putIfAbsent('value', () => value);
          map.putIfAbsent('path', () => hivePath);
          await compute(heavyTaskWriteQuestion, map);
          break;
        case master.pic:
          var map = <String, dynamic>{};
          map.putIfAbsent('chiper', () => _chiper);
          map.putIfAbsent('value', () => value);
          map.putIfAbsent('path', () => hivePath);
          await compute(heavyTaskWritePhotoForm, map);
          break;
        default:
          break;
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  static Future<bool> readFromHive(master masterType) async {
    var _chiper = _key();
    try {
      switch (masterType) {
        case master.question:
          var _boxExists = await Hive.boxExists(kHiveKeys_2);
          if (_boxExists) {
            var box = await Hive.openBox<QuisionerItem>(kHiveKeys_2,
                encryptionCipher: _chiper);

            saveQuestion(box.values.toList());
          }
          return Future.value(true);
        case master.zipcode:
          var _boxExists = await Hive.boxExists(kHiveKeys_3);
          if (_boxExists) {
            var box = await Hive.openBox<ZipCodeItem>(kHiveKeys_3,
                encryptionCipher: _chiper);
            saveZipCodes(box.values.toList());
          }
          return Future.value(true);
        case master.pic:
          var _boxExists = await Hive.boxExists(kHiveKeys_4);
          if (_boxExists) {
            var box = await Hive.openBox<FormUploadItem>(kHiveKeys_4,
                encryptionCipher: _chiper);
            savePhotoForm(box.values.toList());
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

  static void getAssetsPhoto() {
    var newPhotoResult = <PhotoResult>[];

    for (var element in photoFormResult) {
      var _photoResult = PhotoResult();
      _photoResult.form = element.form;

      var item = List<DocumentItem>(element.result.length);
      for (var i = 0; i < element.result.length; i++) {
        var result = HiveUtils.readPhotoItemFromBox(
            kLastSavedClient, _photoResult.form, i, "foto");
        if (result != null) {
          item[i] = result;
        }
      }

      _photoResult.result = item;
      newPhotoResult.add(_photoResult);
    }

    clearSavedPhotoFormResult(master.pic);
    savePhotoFormResult(newPhotoResult, master.pic);
  }

  static void getDocumentPhoto() {
    var newDocResult = <PhotoResult>[];

    for (var element in docFormResult) {
      var _photoResult = PhotoResult();
      _photoResult.form = element.form;
      var item = List<DocumentItem>(element.result.length);
      for (var i = 0; i < element.result.length; i++) {
        var result = HiveUtils.readPhotoItemFromBox(
            kLastSavedClient, _photoResult.form, i, "dokumen");
        if (result != null) {
          item[i] = result;
        }
      }
      _photoResult.result = item;
      newDocResult.add(_photoResult);
    }

    clearSavedPhotoFormResult(master.doc);
    savePhotoFormResult(newDocResult, master.doc);
  }

  static void setFotoResult(List<PhotoResult> list) {
    clearSavedPhotoFormResult(master.pic);
    savePhotoFormResult(list, master.pic);
  }

  static void setDocResult(List<PhotoResult> list) {
    clearSavedPhotoFormResult(master.doc);
    savePhotoFormResult(list, master.doc);
  }

  static HiveAesCipher _key() {
    var _keys = utf8.encode(kHiveKey);
    var _md5 = crypt.md5.convert(_keys);
    var _sha = crypt.sha256.convert(_md5.bytes);
    return HiveAesCipher(_sha.bytes);
  }
}
