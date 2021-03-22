import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/model/quisioner_answer.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/hive_utils.dart';
import 'package:mobx/mobx.dart';

part 'quisioner.g.dart';

class QuisionerBase = _QuisionerLogic with _$QuisionerBase;

abstract class _QuisionerLogic with Store {
  final NewState _state;

  _QuisionerLogic(this._state);

  var _dispose = autorun((_) {
    List<QuisionerAnswerModel> newQuisioner = List<QuisionerAnswerModel>();
    MasterRepositories.quisionerList.forEach((element) {
      QuisionerAnswerModel _quisioner = QuisionerAnswerModel();
      _quisioner.question = element.question;
      var newChoice;
      if (element.choice != null)
        newChoice = HiveUtils.readChoiceFromHive(
            kLastSavedClient, element.choice,
            type: "quisioner");
      _quisioner.choice = newChoice ?? element.choice;
      _quisioner.controller = element.controller;
      if (element.controller != null) {
        HiveUtils.readControllerFromHive(kLastSavedClient, element.controller,
            element.question, "quisioner");
      }
      newQuisioner.add(_quisioner);
    });

    MasterRepositories.saveQuisioner(newQuisioner);
  });

  @observable
  ObservableList<QuisionerAnswerModel> _quisioner =
      ObservableList<QuisionerAnswerModel>.of(MasterRepositories.quisionerList);

  @computed
  List<QuisionerAnswerModel> get quisioner => _quisioner;

  @action
  void onSelectedValue(String s, SearchModel model) => _state.setState(() {
        model.value = s;
        HiveUtils.saveChoiceToHive(kLastSavedClient, model);
      });

  @action
  void testSubmit() => _quisioner.forEach((element) {
        print(
            "${_quisioner.indexOf(element)} : ${element.question} : ${element.choice?.value}: ${element.controller?.text}");
      });
}
