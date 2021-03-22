import 'dart:io';

import 'package:adv_image_picker/adv_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/ui/quisioner.dart';
import 'package:mobx/mobx.dart';

part 'survey.g.dart';

class SurveyBase = _SurveyLogic with _$SurveyBase;

abstract class _SurveyLogic with Store {
  final NewState _state;
  _SurveyLogic(this._state);

  BuildContext get _context => _state.context;

  @observable
  String pages = "1/4";

  List<File> _debiturPhotos = List<File>();
  List<File> _unitPhotos = List<File>();
  List<File> _domisiliPhotos = List<File>();
  List<File> _documentPhotos = List<File>();

  PageController _pageController = PageController();

  PageController get page => _pageController;

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
  }

  @action
  void navigateToQuisioner() {
    Navigator.of(_context)
        .push(MaterialPageRoute(builder: (_) => QuisionerUI()));
  }
}
