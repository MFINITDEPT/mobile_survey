import 'package:flutter/cupertino.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/model/quisioner.dart';
import 'package:mobx/mobx.dart';

part 'quisioner.g.dart';

class QuisionerBase = _QuisionerLogic with _$QuisionerBase;

abstract class _QuisionerLogic with Store {
  final NewState _state;
  final List<QuisionerModel> _model;

  _QuisionerLogic(this._state, this._model);

  BuildContext get _context => _state.context;

  @observable
  List<QuisionerModel> _newmodel = [];

  @computed
  List<QuisionerModel> get model => _newmodel = _model;

  void getData() {
    ///ini kepanggil mulu setiap pindah tab
  }
}
