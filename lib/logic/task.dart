import 'package:mobx/mobx.dart';

part 'task.g.dart';

// ignore: public_member_api_docs
class TaskBase = _TaskLogic with _$TaskBase;

abstract class _TaskLogic with Store {
//  final NewState _state;
//  final NikDataModel _model;
//  final String _nik;
//
//  _HomeContainerLogic(this._state, this._model, this._nik);
//
//  @computed
//  NikDataModel get model => _model;
//
//  @computed
//  String get nik => _nik;
}
