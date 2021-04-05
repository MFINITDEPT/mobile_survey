import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../model/dropdown.dart';
import '../model/photo_result.dart';
import '../model/quisioner_answer.dart';
import '../repositories/master.dart';
import '../ui/task.dart';
import '../utilities/constant.dart';
import '../utilities/enum.dart';
import '../utilities/hive_utils.dart';

part 'home.g.dart';

// ignore: public_member_api_docs
class HomeBase = _HomeLogic with _$HomeBase;

abstract class _HomeLogic with Store {
  @action
  void onSelectedItem(String customerNumber, BuildContext context) {
    kLastSavedClient = customerNumber;
    var _resultPhoto = [];
    var _resultDoc = [];
    var _quisioner = [];

    for (var element in MasterRepositories.photoForm) {
      var _item = PhotoResult();
      _item.form =
          MasterRepositories.photoForm.firstWhere((item) => element == item);
      _item.result = List<File>(element.count);

      _resultPhoto.add(_item);
    }

    for (var element in MasterRepositories.docPhoto) {
      var _item = PhotoResult();
      _item.form =
          MasterRepositories.docPhoto.firstWhere((item) => element == item);
      _item.result = List<File>(element.count);

      _resultDoc.add(_item);
    }

    for (var element in MasterRepositories.quisioners) {
      var _questionModel = QuisionerAnswerModel();
      _questionModel.question = element.question;
      if (element.choice.isNotEmpty) {
        _questionModel.choice = SearchModel(
            title: element.question,
            itemList: element.choice,
            value: element.choice.first);
        var newChoice = HiveUtils.readChoiceFromHive(
            kLastSavedClient, _questionModel.choice,
            type: "quisioner");
        if (newChoice != null) _questionModel.choice.value = newChoice.value;
        if (element.choice
            .where((element) => element.contains(','))
            .isNotEmpty) {
          _questionModel.controller = TextEditingController()
            ..addListener(() => HiveUtils.addListenner(kLastSavedClient,
                _questionModel.controller, element.question, "quisioner"));
        }
      }
      if (element.choice.isEmpty) {
        _questionModel.controller = TextEditingController()
          ..addListener(() => HiveUtils.addListenner(kLastSavedClient,
              _questionModel.controller, element.question, "quisioner"));
      }
      _quisioner.add(_questionModel);
    }

    MasterRepositories.savePhotoFormResult(
        List<PhotoResult>.from(_resultPhoto), master.pic);
    MasterRepositories.savePhotoFormResult(
        List<PhotoResult>.from(_resultDoc), master.doc);
    MasterRepositories.saveQuisioner =
        List<QuisionerAnswerModel>.from(_quisioner);

    Navigator.push(context,
        MaterialPageRoute(builder: (context) => TaskUI(id: kLastSavedClient)));
  }

  @action
  void onMapPress() {
    print("hello");
  }
}
