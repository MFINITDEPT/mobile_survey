import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
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

  static Future<void> _saveToHive(List<dynamic> value, master masterType) async {
   try{
     switch(masterType){
       case master.zipcode:
         var box = await Hive.openBox<ZipCodeModel>('zipcode');
         List<ZipCodeModel> values = List<ZipCodeModel>.from(value);
         box.addAll(values);
         break;
       case master.ao:
         var box = await Hive.openBox<AoModel>('ao');
         List<AoModel> values = List<AoModel>.from(value);
         box.addAll(values);
         break;
       case master.question:
         var box = await Hive.openBox<QuisionerModel>('quisioner');
         List<QuisionerModel> values = List<QuisionerModel>.from(value);
         box.addAll(values);
         break;
       default:
         break;
     }
   } catch(Exception){
   }

  /*  if (value.runtimeType is List<ZipCodeModel>) {
      print('valeus :$value');
      Hive.openBox<List<ZipCodeModel>>('zipcode')
          .then((box) => box.put('zipcode', value));
    } else if (value.runtimeType is List<AoModel>) {
      print('valeus :$value');
      Hive.openBox<List<AoModel>>('ao').then((box) => box.put('ao', value));
    } else if (value.runtimeType is List<QuisionerModel>) {
      print('valeus :$value');
      Hive.openBox<List<QuisionerModel>>('quisioner')
          .then((box) => box.put('quisioner', value));
    }*/
  }

  static Future<bool> readFromHive(master masterType) async {
    try {
      switch (masterType) {
        case master.question:
          bool _boxExists = await Hive.boxExists('quisioner');
          if (_boxExists) {
            var box = await Hive.openBox<QuisionerModel>('quisioner');
            await saveQuestion(box.values.toList());
            box.close();
          }
          return Future.value(true);
        case master.zipcode:
          bool _boxExists = await Hive.boxExists('zipcode');
          if (_boxExists) {
            var box = await Hive.openBox<ZipCodeModel>('zipcode');
            await saveZipCodes(box.values.toList());
            box.close();
          }
          return Future.value(true);
        case master.ao:
          bool _boxExists = await Hive.boxExists('ao');
          if (_boxExists) {
            var box = await Hive.openBox<AoModel>('ao');
            await saveAO(box.values.toList());
            box.close();
          }
          return Future.value(true);
        default:
          return Future.value(false);
      }
    } catch (Exception ) {
      return Future.value(false);
    }
  }
}
