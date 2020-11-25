import 'package:flutter/cupertino.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/model/quisioner.dart';
import 'package:mobilesurvey/utilities/api_request.dart';
import 'package:mobx/mobx.dart';

part 'quisioner.g.dart';

class QuisionerBase = _QuisionerLogic with _$QuisionerBase;

abstract class _QuisionerLogic with Store {
  final NewState _state;

  _QuisionerLogic(this._state);

  BuildContext get _context => _state.context;

  @observable
  List<QuisionerModel> model = [];

  @action
  void getData() {
    _state.process(() async {
      model = await APIRequest.masterQuisioner();
    });
  }
}