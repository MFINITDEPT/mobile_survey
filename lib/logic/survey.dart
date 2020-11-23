import 'dart:io';

import 'package:adv_image_picker/adv_image_picker.dart';
import 'package:adv_image_picker/components/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/model/nik_data.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobx/mobx.dart';

part 'survey.g.dart';

class SurveyBase = _SurveyLogic with _$SurveyBase;

abstract class _SurveyLogic with Store {
  final NewState _state;
  final NikDataModel _model;
  final String _nik;

  _SurveyLogic(this._state, this._model, this._nik);

  BuildContext get _context => _state.context;

  @computed
  NikDataModel get model => _model;

  @computed
  String get nik => _nik;

  @observable
  String pages = "1/4";

  List<File> _debiturPhotos = List<File>();
  List<File> _unitPhotos = List<File>();
  List<File> _domisiliPhotos = List<File>();
  List<File> _documentPhotos = List<File>();

  TextEditingController _nameCtrl = TextEditingController();
  TextEditingController _birthLocationCtrl = TextEditingController();
  TextEditingController _birthDateCtrl = TextEditingController();
  TextEditingController _addressCtrl = TextEditingController();
  PageController _pageController = PageController();

  TextEditingController get name => _nameCtrl;

  TextEditingController get birthLocation => _birthLocationCtrl;

  TextEditingController get birthDate => _birthDateCtrl;

  TextEditingController get address => _addressCtrl;

  PageController get page => _pageController;

  void checkData() {
    if (_nik != null && _model != null) {
      _nameCtrl.text = _model.namaLengkap;
      _birthLocationCtrl.text = _model.tempatLahir;
      _birthDateCtrl.text = _model.tanggalLahir;
      _addressCtrl.text = _model.alamat;

      Toast.showToast(_context, translation.getText('verified_by_dukcapil'));
    }
  }

  @action
  void onPageChange(int page) {
    pages = '${(page + 1)}/4';
  }

  @action
  void onImageTap(String title, int index) {
    print("ini title $title:$index");
    switch (title) {
      case 'foto_debitur':
        _openCamera(_debiturPhotos, index);
        break;
      case 'foto_unit':
        _openCamera(_unitPhotos, index);
        break;
      case 'foto_domisili':
        _openCamera(_domisiliPhotos, index);
        break;
      case 'foto_document':
        _openCamera(_documentPhotos, index);
        break;
    }
  }

  void _openCamera(List<File> _files, int index) async {
    List<File> files = await AdvImagePicker.pickImagesToFile(_context,
        usingCamera: true,
        usingGallery: false,
        useFlash: true,
        useCustomView: false,
        allowMultiple: false);

    _files.insert(index, files[0]);

    print("ini debitur ${_debiturPhotos.length}");
    print("ini unit ${_debiturPhotos.length}");
    print("ini domisili ${_debiturPhotos.length}");
    print("ini dokumen ${_debiturPhotos.length}");
  }
}
