import 'package:adv_image_picker/components/toast.dart';
import 'package:flutter/material.dart';
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

  TextEditingController get handphoneNo => _handphoneNoCtrl;

  TextEditingController get phoneNo => _phoneNoCtrl;

  TextEditingController get fax => _faxCtrl;

  void checkData() {
    if (_nik != null && _model != null) {
      _nameCtrl.text = _model.namaLengkap;
      _birthLocationCtrl.text = _model.tempatLahir;
      _birthDateCtrl.text = _model.tanggalLahir;
      _addressCtrl.text = _model.alamat;
      _nikCtrl.text = _nik;

      Toast.showToast(_context, translation.getText('verified_by_dukcapil'));
    }
  }
}
