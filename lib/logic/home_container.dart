import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/model/nik_data.dart';
import 'package:mobx/mobx.dart';

part 'home_container.g.dart';

class HomeContainerBase = _HomeContainerLogic with _$HomeContainerBase;

abstract class _HomeContainerLogic with Store {
  final NewState _state;
  final NikDataModel _model;
  final String _nik;

  _HomeContainerLogic(this._state, this._model, this._nik);

  @computed
  NikDataModel get model => _model;

  @computed
  String get nik => _nik;
}
