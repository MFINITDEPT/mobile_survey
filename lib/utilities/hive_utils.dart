import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:mobilesurvey/model/photo_form.dart';

class HiveUtils {
  static void _saveTextFieldControllerToHive(
      String id, TextEditingController controller, String controllerName,
      [String type = 'Client', Box<dynamic> box]) {
    box.put("$controllerName$id$type", controller.text);
  }

  static void _readTextFieldControllerFromHive(String id,
      TextEditingController controller, String controllerName, Box<dynamic> box,
      [String type = 'Client']) {
    if (box.get("$controllerName$id$type") == null) {
      controller.value = TextEditingValue.empty;
    } else {
      controller.text = box.get("$controllerName$id$type");
    }
  }

  static Future<void> readFromBox(String id,
      List<TextEditingController> controllers, List<String> controllerNames,
      [String type = "Client"]) async {
    String boxName = "$type$id";
    if (Hive.isBoxOpen(boxName)) {
      Box<dynamic> box = Hive.box(boxName);
      for (var value in controllers) {
        _readTextFieldControllerFromHive(
            id, value, controllerNames[controllers.indexOf(value)], box, type);
      }
    } else {
      Box<dynamic> box = await Hive.openBox(boxName);
      for (var value in controllers) {
        _readTextFieldControllerFromHive(
            id, value, controllerNames[controllers.indexOf(value)], box, type);
      }
    }
  }

  static Future<void> addListenner(
      String id, TextEditingController controller, String controllerName,
      [String type = "Client"]) async {
    String boxName = "$type$id";
    if (Hive.isBoxOpen(boxName)) {
      Box<dynamic> box = Hive.box(boxName);
      _saveTextFieldControllerToHive(id, controller, controllerName, type, box);
    } else {
      Box<dynamic> box = await Hive.openBox(boxName);
      _saveTextFieldControllerToHive(id, controller, controllerName, type, box);
    }
  }

  static Future<void> saveFilePathToBox(
      String id, String filePath, PhotoForm form, int index,
      [String type = "foto"]) async {
    String boxName = "$type$id";
    if (Hive.isBoxOpen(boxName)) {
      Box<dynamic> box = Hive.box(boxName);
      box.put("${form.kelengkapan}$id$type$index", filePath);
    } else {
      Box<dynamic> box = await Hive.openBox(boxName);
      box.put("${form.kelengkapan}$id$type$index", filePath);
    }
  }

  static Future<void> deleteFilePathFromBox(
      String id, PhotoForm form, int index,
      [String type = "foto"]) async {
    String boxName = "$type$id";
    if (Hive.isBoxOpen(boxName)) {
      Box<dynamic> box = Hive.box(boxName);
      box.delete("${form.kelengkapan}$id$type$index");
    } else {
      Box<dynamic> box = await Hive.openBox(boxName);
      box.delete("${form.kelengkapan}$id$type$index");
    }
  }

  static String readFilePathFromBox(
      String id, PhotoForm form, int index,
      [String type = "foto"]) {
    String boxName = "$type$id";
    if (Hive.isBoxOpen(boxName)) {
      Box<dynamic> box = Hive.box(boxName);
      return(box.get("${form.kelengkapan}$id$type$index"));
    } else {
     Hive.openBox(boxName).then((value){
       return value.get("${form.kelengkapan}$id$type$index");
      });
    }
  }
}
