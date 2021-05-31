import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/hive_utils.dart';
import 'package:mobx/mobx.dart';

import '../../model/mobile_survey/quisioner_answer.dart';

part 'quisioner.g.dart';

class QuisionerBase = _QuisionerLogic with _$QuisionerBase;

abstract class _QuisionerLogic with Store {
  @observable
  ObservableList<QuisionerAnswerModel> _quisioner =
      ObservableList<QuisionerAnswerModel>.of([]);

  @computed
  List<QuisionerAnswerModel> get quisioner => _quisioner;

  @computed
  bool get quisionerIsEmpty => _quisioner.isEmpty;

  @action
  void setQuisioner(ObservableList list) =>
      _quisioner = ObservableList.of([...list]);

  List<ReactionDisposer> _disposer = [];

  void setupReaction(ObservableList list) {
    _disposer.add(autorun((_) {
      setQuisioner(list);
    }));
  }

  void dispose() => _disposer = [];

  @action
  void onSelectedValue(Function func, String s, SearchModel model) {
    func(() {
      model.value = s;
      HiveUtils.saveChoiceToHive(kLastSavedClient, model);
    });
  }
}
