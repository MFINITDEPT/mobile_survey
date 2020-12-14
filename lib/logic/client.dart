import 'package:adv_image_picker/components/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:mobilesurvey/model/dropdown.dart';
import 'package:mobilesurvey/model/zipcode.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/string_utils.dart';
import 'package:mobx/mobx.dart';

import '../boilerplate/new_state.dart';
import '../model/nik_data.dart';
import '../utilities/translation.dart';

part 'client.g.dart';

class ClientBase = _ClientLogic with _$ClientBase;

abstract class _ClientLogic with Store {
  final NewState _state;
  final String _nik;
  final NikDataModel _model;

  _ClientLogic(this._state, this._nik, this._model);

  @computed
  NikDataModel get model => _model;

  @computed
  String get nik => _nik;

  BuildContext get _context => _state.context;

  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _birthLocationCtrl = TextEditingController();
  TextEditingController _nikCtrl = TextEditingController();
  TextEditingController _birthDateCtrl = TextEditingController();
  TextEditingController _addressCtrl = TextEditingController();
  TextEditingController _effectiveOfCtrl = TextEditingController();
  TextEditingController _toCtrl = TextEditingController();
  TextEditingController _identityCityCtrl = TextEditingController();
  TextEditingController _motherNameCtrl = TextEditingController();
  TextEditingController _rtCtrl = TextEditingController();
  TextEditingController _rwCtrl = TextEditingController();
  TextEditingController _zipCodeCtrl = TextEditingController();
  TextEditingController _villageCtrl = TextEditingController();
  TextEditingController _districtCtrl = TextEditingController();
  TextEditingController _handphoneNoCtrl = TextEditingController();
  TextEditingController _phoneNoCtrl = TextEditingController();
  TextEditingController _faxCtrl = TextEditingController();

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

  List<String> _aoList = MasterRepositories.ao.map((e) => e.descs).toList();

  @observable
  SearchModel _ao;

  @computed
  SearchModel get ao => _ao;

  void checkData() {
    if (_nik != null && _model != null) {
      _nameCtrl.text = _model.namaLengkap;
      _birthLocationCtrl.text = _model.tempatLahir;
      _birthDateCtrl.text = _model.tanggalLahir;
      _addressCtrl.text = _model.alamat;
      _nikCtrl.text = _nik;

      Toast.showToast(_context, translation.getText('verified_by_dukcapil'));
    }

    _ao = SearchModel(
        title: translation.getText('ao'),
        itemList: _aoList,
        value: _aoList.first);
  }

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
