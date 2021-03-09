import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';

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
}
