import 'package:flutter/cupertino.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/model/quisioner_answer.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobx/mobx.dart';

part 'quisioner.g.dart';

class QuisionerBase = _QuisionerLogic with _$QuisionerBase;

abstract class _QuisionerLogic with Store {
  final NewState _state;

  _QuisionerLogic(this._state);

  ObservableList<QuisionerAnswerModel> _quisioner =
      ObservableList<QuisionerAnswerModel>.of([]);

  @computed
  List<QuisionerAnswerModel> get quisioner {
    MasterRepositories.quisioners.forEach((element) {
      QuisionerAnswerModel _questionModel = QuisionerAnswerModel();
      _questionModel.question = element.question;
      if (element.choice.isNotEmpty) {
        _questionModel.choice = SearchModel(
            title: "", itemList: element.choice, value: element.choice.first);
       if( element.choice.where((element) => element.contains(',')).length > 0) _questionModel.controller = TextEditingController();
      }
      if (element.choice.isEmpty)
        _questionModel.controller = TextEditingController();
      _quisioner.add(_questionModel);
    });

    return _quisioner;
  }

  @action
  void onSelectedValue(String s, SearchModel model) {
   _state.setState(() {
     model.value = s;
   });
  }

  @action
  void testSubmit(){
    _quisioner.forEach((element) {
      print("${_quisioner.indexOf(element)} : ${element.question} : ${element.choice?.value}: ${element.controller?.text}");
    });
  }
}
