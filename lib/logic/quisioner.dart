import '../boilerplate/new_state.dart';
import '../model/dropdown.dart';
import '../model/quisioner_answer.dart';
import '../repositories/master.dart';
import '../utilities/constant.dart';
import '../utilities/hive_utils.dart';
import 'package:mobx/mobx.dart';

part 'quisioner.g.dart';

// ignore: public_member_api_docs
class QuisionerBase = _QuisionerLogic with _$QuisionerBase;

abstract class _QuisionerLogic with Store {
  final NewState _state;

  _QuisionerLogic(this._state);

  final _dispose = autorun((_) {
    var newQuisioner = [];
    for (var element in MasterRepositories.quisionerList) {
      var _quisioner = QuisionerAnswerModel();
      _quisioner.question = element.question;
      var newChoice;
      if (element.choice != null) {
        newChoice = HiveUtils.readChoiceFromHive(
            kLastSavedClient, element.choice,
            type: "quisioner");
      }

      _quisioner.choice = newChoice ?? element.choice;
      _quisioner.controller = element.controller;
      if (element.controller != null) {
        HiveUtils.readControllerFromHive(kLastSavedClient, element.controller,
            element.question, "quisioner");
      }
      newQuisioner.add(_quisioner);
    }

    MasterRepositories.saveQuisioner = newQuisioner;
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
        print("${_quisioner.indexOf(element)} : "
            "${element.question} : ${element.choice?.value}: "
            "${element.controller?.text}");
      });
}
