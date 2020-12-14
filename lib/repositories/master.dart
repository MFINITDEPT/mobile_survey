import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:mobilesurvey/model/ao.dart';
import 'package:mobilesurvey/model/configuration.dart';
import 'package:mobilesurvey/model/quisioner.dart';
import 'package:mobilesurvey/model/zipcode.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/enum.dart';
import 'package:mobilesurvey/utilities/shared_preferences_utils.dart';
import 'package:path_provider/path_provider.dart';

class MasterRepositories {
  static List<ZipCodeModel> _zipcodes;

  static List<ZipCodeModel> get zipcodes => _zipcodes;

  static List<QuisionerModel> _quisioners;

  static List<QuisionerModel> get quisioners => _quisioners;

  static List<AoModel> _ao;

  static List<AoModel> get ao => _ao;

  static void saveZipCodes(List<ZipCodeModel> value) {
    _saveZipCodeToLocalStorage(value);
    _zipcodes = value;
    _zipcodes.sort((a, b) => a.kota.compareTo(b.kota));
  }

  static void saveQuestion(List<QuisionerModel> value) {
    _saveQuisionerToLocalStorage(value);
    _quisioners = value;
  }

  static void saveAO(List<AoModel> value) {
    _saveAOToLocalStorage(value);
    _ao = value;
  }

  static void saveConfiguration(ConfigurationModel value) {
    PreferenceUtils.setString(kLastUpdateQuestion, value.lastUpdateQuestion);
    PreferenceUtils.setString(kLastUpdateZipCode, value.lastUpdateZipCode);
    PreferenceUtils.setString(kLastUpdateAO, value.lastUpdateAo);
  }

  static Future<void> _saveZipCodeToLocalStorage(
      List<ZipCodeModel> value) async {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/ZipCode.json");
    List<Map<String, dynamic>> result = List<Map<String, dynamic>>();
    for (ZipCodeModel item in value) {
      result.add(item.toJson());
    }
    file.writeAsString(json.encode(result));
  }

  static Future<void> _saveQuisionerToLocalStorage(
      List<QuisionerModel> value) async {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/Quisioner.json");
    List<Map<String, dynamic>> result = List<Map<String, dynamic>>();
    for (QuisionerModel item in value) {
      result.add(item.toJson());
    }
    file.writeAsString(json.encode(result));
  }

  static Future<void> _saveAOToLocalStorage(List<AoModel> value) async {
    Directory dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/AO.json");
    List<Map<String, dynamic>> result = List<Map<String, dynamic>>();
    for (AoModel item in value) {
      result.add(item.toJson());
    }
    file.writeAsString(json.encode(result));
  }

  static Future<bool> readFromFile(master masterType) async {
    switch (masterType) {
      case master.question:
        return await _readQuisionerFromFile();
      case master.zipcode:
        return await _readZipCodeFromFile();
      case master.ao:
        return await _readAOFromFile();
      default:
        debugPrint("error: masterType");
        return false;
    }
  }

  static Future<bool> _readQuisionerFromFile() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/Quisioner.json');
      String text = await file.readAsString();
      List<Map<String, dynamic>> res = List.from(jsonDecode(text));
      List<QuisionerModel> finalResult = [];
      for (var item in res) {
        finalResult.add(QuisionerModel.fromJson(item));
      }
      saveQuestion(finalResult);
      return Future.value(true);
    } catch (e) {
      debugPrint("error :${e.toString()}");
      return Future.value(false);
    }
  }

  static Future<bool> _readZipCodeFromFile() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/ZipCode.json');
      String text = await file.readAsString();
      List<Map<String, dynamic>> res = List.from(jsonDecode(text));
      List<ZipCodeModel> finalResult = [];
      for (var item in res) {
        finalResult.add(ZipCodeModel.fromJson(item));
      }
      saveZipCodes(finalResult);
      return Future.value(true);
    } catch (e) {
      debugPrint("error :${e.toString()}");
      return Future.value(false);
    }
  }

  static Future<bool> _readAOFromFile() async {
    try {
      Directory dir = await getApplicationDocumentsDirectory();
      File file = File('${dir.path}/AO.json');
      String text = await file.readAsString();
      List<Map<String, dynamic>> res = List.from(jsonDecode(text));
      List<AoModel> finalResult = [];
      for (var item in res) {
        finalResult.add(AoModel.fromJson(item));
      }
      saveAO(finalResult);
      return Future.value(true);
    } catch (e) {
      debugPrint("error :${e.toString()}");
      return Future.value(false);
    }
  }

  static Future<bool> checkFileExist(master masterType) async {
    Directory dir = await getApplicationDocumentsDirectory();

    switch (masterType) {
      case master.question:
        return await File('${dir.path}/Quisioner.json').exists();
      case master.zipcode:
        return await File('${dir.path}/ZipCode.json').exists();
      default:
        debugPrint("error : masterType unrecognized");
        return false;
    }
  }
}
