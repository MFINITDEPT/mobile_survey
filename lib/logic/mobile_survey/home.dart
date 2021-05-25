import 'package:flutter/material.dart';
import 'package:mobilesurvey/model/master_configuration/split_question.dart';
import 'package:mobilesurvey/ui/mobile_survey/task.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/dropdown.dart';
import '../../model/mobile_survey/document_item.dart';
import '../../model/mobile_survey/photo_result.dart';
import '../../model/mobile_survey/quisioner_answer.dart';
import '../../repositories/master.dart';
import '../../utilities/constant.dart';
import '../../utilities/enum.dart';
import '../../utilities/hive_utils.dart';

part 'home.g.dart';

class HomeBase = _HomeLogic with _$HomeBase;

abstract class _HomeLogic with Store {
  @action
  void onSelectedItem(String customerNumber, BuildContext context) {
    kLastSavedClient = customerNumber;
    var _resultPhoto = [];
    var _resultDoc = [];
    var _quisioner = [];

    for (var element in MasterRepositories.photoForm
        .where((element) => element.kode.toLowerCase().contains('pic'))) {
      var _item = PhotoResult();
      _item.form =
          MasterRepositories.photoForm.firstWhere((item) => element == item);
      _item.result = List<DocumentItem>(element.count);

      _resultPhoto.add(_item);
    }

    for (var element in MasterRepositories.photoForm
        .where((element) => element.kode.toLowerCase().contains('dpk'))) {
      var _item = PhotoResult();
      _item.form =
          MasterRepositories.photoForm.firstWhere((item) => element == item);
      _item.result = List<DocumentItem>(element.count);

      _resultDoc.add(_item);
    }

    for (var element in MasterRepositories.quisioners) {
      var _questionModel = QuisionerAnswerModel();
      var split_question = SplitQuisionerModel.fromModel(element);
      _questionModel.question = split_question.pertanyaan;
      if (split_question.pilihan.isNotEmpty) {
        _questionModel.choice = SearchModel(
            title: split_question.pertanyaan,
            itemList: split_question.pilihan,
            value: split_question.pilihan.first);

        var newChoice = HiveUtils.readChoiceFromHive(
            kLastSavedClient, _questionModel.choice,
            type: "quisioner");
        if (newChoice != null) _questionModel.choice.value = newChoice.value;
        if (split_question.pilihan
            .where((element) => element.contains(','))
            .isNotEmpty) {
          _questionModel.controller = TextEditingController()
            ..addListener(() => HiveUtils.addListenner(
                kLastSavedClient,
                _questionModel.controller,
                split_question.pertanyaan,
                "quisioner"));
        }
      }
      if (split_question.pilihan.isEmpty) {
        _questionModel.controller = TextEditingController()
          ..addListener(() => HiveUtils.addListenner(
              kLastSavedClient,
              _questionModel.controller,
              split_question.pertanyaan,
              "quisioner"));
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
  Future<void> onMapPress() async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=-6.173110,106.829361';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
