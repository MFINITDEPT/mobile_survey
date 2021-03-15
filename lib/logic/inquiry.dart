import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/model/photo_result.dart';
import 'package:mobilesurvey/model/quisioner_answer.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/ui/home_container.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/enum.dart';
import 'package:mobilesurvey/utilities/hive_utils.dart';
import 'package:mobx/mobx.dart';

part 'inquiry.g.dart';

class InquiryBase = _InquiryLogic with _$InquiryBase;

abstract class _InquiryLogic with Store {
  NewState _state;

  _InquiryLogic(this._state);

  BuildContext get _context => _state.context;

  @action
  void navigateToSurvey(int index) {
    kLastSavedClient = index.toString();

    List<PhotoResult> _resultPhoto = List<PhotoResult>();
    List<PhotoResult> _resultDoc = List<PhotoResult>();
    List<QuisionerAnswerModel> _quisioner = List<QuisionerAnswerModel>();

    MasterRepositories.photoForm.forEach((element) {
      PhotoResult _item = PhotoResult();
      _item.form =
          MasterRepositories.photoForm.firstWhere((item) => element == item);
      _item.result = List<File>(element.count);

      _resultPhoto.add(_item);
    });

    MasterRepositories.docPhoto.forEach((element) {
      PhotoResult _item = PhotoResult();
      _item.form =
          MasterRepositories.docPhoto.firstWhere((item) => element == item);
      _item.result = List<File>(element.count);

      _resultDoc.add(_item);
    });

    MasterRepositories.quisioners.forEach((element) {
      QuisionerAnswerModel _questionModel = QuisionerAnswerModel();
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
        if (element.choice.where((element) => element.contains(',')).length >
            0) {
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
    });

    MasterRepositories.savePhotoFormResult(_resultPhoto, master.pic);
    MasterRepositories.savePhotoFormResult(_resultDoc, master.doc);
    MasterRepositories.saveQuisioner(_quisioner);

    Navigator.push(
        _context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                HomeContainerUI(id: index.toString())));
  }
}
