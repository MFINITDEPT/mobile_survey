import 'package:adv_image_picker/components/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/model/zipcode.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/hive_utils.dart';
import 'package:mobilesurvey/utilities/string_utils.dart';
import 'package:mobx/mobx.dart';

import '../boilerplate/new_state.dart';
import '../model/nik_data.dart';
import '../utilities/translation.dart';

part 'client.g.dart';

class ClientBase = _ClientLogic with _$ClientBase;

abstract class _ClientLogic with Store {
  final NewState _state;
  final String _id;

  _ClientLogic(this._state, this._id);

  BuildContext get _context => _state.context;

  static TextEditingController _nameCtrl = TextEditingController();
  static TextEditingController _birthLocationCtrl = TextEditingController();
  static TextEditingController _nikCtrl = TextEditingController();
  static TextEditingController _birthDateCtrl = TextEditingController();
  static TextEditingController _addressCtrl = TextEditingController();
  static TextEditingController _effectiveOfCtrl = TextEditingController();
  static TextEditingController _toCtrl = TextEditingController();
  static TextEditingController _identityCityCtrl = TextEditingController();
  static TextEditingController _motherNameCtrl = TextEditingController();
  static TextEditingController _rtCtrl = TextEditingController();
  static TextEditingController _rwCtrl = TextEditingController();
  static TextEditingController _zipCodeCtrl = TextEditingController();
  static TextEditingController _villageCtrl = TextEditingController();
  static TextEditingController _districtCtrl = TextEditingController();
  static TextEditingController _handphoneNoCtrl = TextEditingController();
  static TextEditingController _phoneNoCtrl = TextEditingController();
  static TextEditingController _faxCtrl = TextEditingController();

  TextEditingController get name => _nameCtrl;

  TextEditingController get birthLocation => _birthLocationCtrl;

  TextEditingController get birthDate => _birthDateCtrl;

  TextEditingController get address => _addressCtrl;

  TextEditingController get identityNo => _nikCtrl;

  TextEditingController get effectiveOf => _effectiveOfCtrl;

  TextEditingController get to => _toCtrl;

  TextEditingController get identityCity => _identityCityCtrl;

  TextEditingController get motherName => _motherNameCtrl;

  TextEditingController get rt => _rtCtrl;

  TextEditingController get rw => _rwCtrl;

  TextEditingController get zipcode => _zipCodeCtrl;

  TextEditingController get village => _villageCtrl;

  TextEditingController get district => _districtCtrl;

  TextEditingController get handphoneNo => _handphoneNoCtrl;

  TextEditingController get phoneNo => _phoneNoCtrl;

  TextEditingController get fax => _faxCtrl;

  var dispose = autorun((_) {
    List<TextEditingController> controllers = [
      _nameCtrl,
      _birthLocationCtrl,
      _birthDateCtrl,
      _addressCtrl,
      _nikCtrl,
      _effectiveOfCtrl,
      _toCtrl,
      _identityCityCtrl,
      _motherNameCtrl,
      _rtCtrl,
      _rwCtrl,
      _zipCodeCtrl,
      _villageCtrl,
      _districtCtrl,
      _handphoneNoCtrl,
      _phoneNoCtrl,
      _faxCtrl
    ];
    List<String> controllerNames = [
      "nama",
      "tempatLahir",
      "tglLahir",
      "alamat",
      "nik",
      "efektif",
      "to",
      "identityCity",
      "motherName",
      "rt",
      "rw",
      "zipcode",
      "village",
      "district",
      "handphoneNo",
      "phoneNo",
      "fax"
    ];

    HiveUtils.readFromBox(
        kLastSavedClient, controllers, controllerNames, "Client");

    controllers.forEach((element) => element.addListener(() =>
        HiveUtils.addListenner(kLastSavedClient, element,
            controllerNames[controllers.indexOf(element)], "Client")));
  });

  @observable
  SearchModel _ao = SearchModel(
      title: translation.getText('ao'),
      itemList: MasterRepositories.aoList.take(10).toList(),
      value: MasterRepositories.aoList.take(10).toList().first);

  @computed
  SearchModel get ao => _ao;

  @action
  Future<void> datePicker() async {
    FocusScope.of(_context).unfocus();
    var finalResult = await DatePicker.showSimpleDatePicker(
      _context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
      dateFormat: "dd-MMMM-yyyy",
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );

    _birthDateCtrl.text = finalResult != null
        ? StringUtils.formatDate(finalResult)
        : _birthDateCtrl.text;
  }

  @action
  void autoFill(ZipCodeModel item) {
    _zipCodeCtrl.text = item.kodePos;
    _districtCtrl.text = item.kelurahan;
    _villageCtrl.text = item.kecamatan;
  }

  @action
  bool actionFilter(ZipCodeModel item, String query) {
    _districtCtrl.text = '';
    _villageCtrl.text = '';
    return item.kodePos.startsWith(query);
  }
}
