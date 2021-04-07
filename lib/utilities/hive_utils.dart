import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/model/photo_form.dart';
import 'package:mobilesurvey/model/document_item.dart';

// ignore: public_member_api_docs
class HiveUtils {
  static void _saveTextFieldControllerToHive(
      String id, TextEditingController controller, String controllerName,
      [String type = 'Client', Box<dynamic> box]) {
    box.put("${controllerName}_${id}_$type", controller.text);
  }

  static void _readTextFieldControllerFromHive(String id,
      TextEditingController controller, String controllerName, Box<dynamic> box,
      [String type = 'Client']) {
    if (box.get("${controllerName}_${id}_$type") == null) {
      controller.value = TextEditingValue.empty;
    } else {
      controller.text = box.get("${controllerName}_${id}_$type");
    }
  }

  static Future<void> readFromBox(String id,
      List<TextEditingController> controllers, List<String> controllerNames,
      [String type = "Client"]) async {
    var boxName = "${type}_$id";
    if (Hive.isBoxOpen(boxName)) {
      var box = Hive.box(boxName);
      for (var value in controllers) {
        _readTextFieldControllerFromHive(
            id, value, controllerNames[controllers.indexOf(value)], box, type);
      }
    } else {
      var box = await Hive.openBox(boxName);
      for (var value in controllers) {
        _readTextFieldControllerFromHive(
            id, value, controllerNames[controllers.indexOf(value)], box, type);
      }
    }
  }

  static Future<void> addListenner(
      String id, TextEditingController controller, String controllerName,
      [String type = "Client"]) async {
    var boxName = "${type}_$id";
    if (Hive.isBoxOpen(boxName)) {
      var box = Hive.box(boxName);
      _saveTextFieldControllerToHive(id, controller, controllerName, type, box);
    } else {
      var box = await Hive.openBox(boxName);
      _saveTextFieldControllerToHive(id, controller, controllerName, type, box);
    }
  }

  static Future<void> savePhotoItemToBox(
      String id, DocumentItem item, PhotoForm form, int index,
      [String type = "foto"]) async {
    var boxName = "${type}_$id";
    if (Hive.isBoxOpen(boxName)) {
      var box = Hive.box<DocumentItem>(boxName);
      box.put("${form.id}_${id}_${type}_$index", item);
    } else {
      var box = await Hive.openBox<DocumentItem>(boxName);
      box.put("${form.id}_${id}_${type}_$index", item);
    }
  }

  static Future<void> deletePhotoItemFromBox(
      String id, PhotoForm form, int index,
      [String type = "foto"]) async {
    var boxName = "${type}_$id";
    if (Hive.isBoxOpen(boxName)) {
      var box = Hive.box<DocumentItem>(boxName);
      box.delete("${form.id}_${id}_${type}_$index");
    } else {
      var box = await Hive.openBox<DocumentItem>(boxName);
      box.delete("${form.id}_${id}_${type}_$index");
    }
  }

  static DocumentItem readPhotoItemFromBox(String id, PhotoForm form, int index,
      [String type = "foto"]) {
    var boxName = "${type}_$id";
    if (Hive.isBoxOpen(boxName)) {
      var box = Hive.box<DocumentItem>(boxName);
      return (box.get("${form.id}_${id}_${type}_$index"));
    } else {
      Hive.openBox<DocumentItem>(boxName).then((value) {
        return value.get("${form.id}_${id}_${type}_$index");
      });
    }
  }

  static Future<void> saveChoiceToHive(String id, SearchModel model,
      {String type = "quisioner"}) async {
    var boxName = "choice_${type}_$id";
    if (Hive.isBoxOpen(boxName)) {
      var box = Hive.box<SearchModel>(boxName);
      box.put("${model.title}_${id}_$type", model);
    } else {
      var box = await Hive.openBox<SearchModel>(boxName);
      box.put("${model.title}_${id}_$type", model);
    }
  }

  static SearchModel readChoiceFromHive(String id, SearchModel model,
      {String type}) {
    var boxName = "choice_${type}_$id";
    if (Hive.isBoxOpen(boxName)) {
      var box = Hive.box<SearchModel>(boxName);
      return (box.get("${model.title}_${id}_$type"));
    } else {
      Hive.openBox<SearchModel>(boxName).then((value) {
        return value.get("${model.title}_${id}_$type");
      });
    }
  }

  static Future<void> readControllerFromHive(
      String id, TextEditingController controller, String controllerName,
      [String type = "Client"]) async {
    var boxName = "${type}_$id";
    if (Hive.isBoxOpen(boxName)) {
      var box = Hive.box(boxName);
      _readTextFieldControllerFromHive(
          id, controller, controllerName, box, type);
    } else {
      var box = await Hive.openBox(boxName);
      _readTextFieldControllerFromHive(
          id, controller, controllerName, box, type);
    }
  }
}
