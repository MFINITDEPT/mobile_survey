import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:mobilesurvey/model/client_controllers.dart';
import 'package:mobx/mobx.dart';
import '../../model/master_configuration/zipcode_item.dart';
import '../../utilities/string_utils.dart';

part 'client.g.dart';

class ClientBase = _ClientLogic with _$ClientBase;

abstract class _ClientLogic with Store {
  @observable
  ObservableList<ClientControllerModel> client = ObservableList.of([]);

  @computed
  bool get clientIsEmpty => client.isEmpty;

  @action
  void setClient(ObservableList list) => client = ObservableList.of([...list]);

  List<ReactionDisposer> _disposer = [];

  void setupReaction(ObservableList list) {
    _disposer.add(autorun((_) {
      setClient(list);
    }));
  }

  void dispose() => _disposer = [];

  @action
  Future<void> datePicker(BuildContext context) async {
    FocusScope.of(context).unfocus();
    var finalResult = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );

    if (client.isNotEmpty) {
      var _birthDateCtrl = client
          .firstWhere((element) => element.controllerName == 'birth_date')
          .controller;

      _birthDateCtrl.text = finalResult != null
          ? StringUtils.formatDate(finalResult)
          : _birthDateCtrl.text;
    }
  }

  @action
  Future<void> yearPicker(
      BuildContext context, TextEditingController controller) async {
    FocusScope.of(context).unfocus();
    var finalResult = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );

    controller.text = finalResult != null
        ? StringUtils.formatDate(finalResult)
        : controller.text;
  }

  @action
  void autoFill(ZipCodeItem item) {
    if (client.isNotEmpty) {
      var _zipCodeCtrl = client
          .firstWhere((element) => element.controllerName == 'zipcode')
          .controller;
      var _districtCtrl = client
          .firstWhere((element) => element.controllerName == 'district')
          .controller;
      var _villageCtrl = client
          .firstWhere((element) => element.controllerName == 'village')
          .controller;

      _zipCodeCtrl.text = item.kodePos;
      _districtCtrl.text = item.kelurahan;
      _villageCtrl.text = item.kecamatan;
    }
  }

  @action
  bool actionFilter(ZipCodeItem item, String query) {
    var _districtCtrl = client
        .firstWhere((element) => element.controllerName == 'district')
        .controller;
    var _villageCtrl = client
        .firstWhere((element) => element.controllerName == 'village')
        .controller;

    _districtCtrl.text = '';
    _villageCtrl.text = '';
    return item.kodePos.startsWith(query);
  }
}
