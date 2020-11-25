import 'package:adv_image_picker/components/toast.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/model/nik_data.dart';
import 'package:mobilesurvey/model/quisioner.dart';
import 'package:mobilesurvey/utilities/api_request.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobx/mobx.dart';

part 'survey_container.g.dart';

class SurveyContainerBase = _SurveyContainerLogic with _$SurveyContainerBase;

abstract class _SurveyContainerLogic with Store {
  final NewState _state;
  final String _nik;
  final NikDataModel _model;

  _SurveyContainerLogic(this._state, this._nik, this._model);

  BuildContext get _context => _state.context;

  @observable
  List<QuisionerModel> model = [];

  @computed
  NikDataModel get nikModel => _model;

  @computed
  String get nik => _nik;

  void getData() {
    _state.process(() async {
      if (_nik != null && _model != null) {
        Toast.showToast(_context, translation.getText('verified_by_dukcapil'));
      }
      model = await APIRequest.masterQuisioner();
    });
  }
}
