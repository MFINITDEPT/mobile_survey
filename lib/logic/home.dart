import 'dart:io';

import 'package:adv_image_picker/adv_image_picker.dart';
import 'package:adv_image_picker/components/toast.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/model/nik_data.dart';
import 'package:mobilesurvey/ui/application.dart';
import 'package:mobilesurvey/ui/new_client.dart';
import 'package:mobilesurvey/ui/survey.dart';
import 'package:mobilesurvey/ui/survey_container.dart';
import 'package:mobilesurvey/utilities/api_request.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobx/mobx.dart';

part 'home.g.dart';

class HomeBase = _HomeLogic with _$HomeBase;

abstract class _HomeLogic with Store {
  final NewState _state;

  _HomeLogic(this._state);

  BuildContext get _context => _state.context;

  @action
  Future<void> takePicture() async {
    List<File> file = await AdvImagePicker.pickImagesToFile(_context,
        usingCamera: true,
        usingGallery: false,
        useFlash: false,
        allowMultiple: false);

    TextRecognizer textRecognizer = FirebaseVision.instance.textRecognizer();
    if (file.isNotEmpty) {
      FirebaseVisionImage visionImage =
          FirebaseVisionImage.fromFile(file.first);
      VisionText visionText = await textRecognizer.processImage(visionImage);
      String nik = _retrieveTextFromVisionText(visionText);
      if (nik != null) {
        _processNIK(nik);
      } else {
        Toast.showToast(
            _context, translation.getText('please_scan_again_or_manual'));
      }
    }
    textRecognizer.close();
  }

  void navigateToSurvey() {
    Navigator.of(_context)
        .push(MaterialPageRoute(builder: (_) => NewClientUI()));
//    Navigator.of(_context)
//        .push(MaterialPageRoute(builder: (_) => ApplicationUI()));
  }

  void _processNIK(String nik) {
    _state.process(() async {
      NikDataModel result = await APIRequest.getNikEncrypt(nik);
      if (result.namaLengkap == null && result.tanggalLahir == null) {
        Toast.showToast(_context, translation.getText('data_not_found'));
        return;
      }
      Navigator.of(_context).push(MaterialPageRoute(
          builder: (_) => NewClientUI(nikDataModel: result, nik: nik)));
    });
  }

  String _retrieveTextFromVisionText(VisionText visionText) {
    String text;
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          if (element.text.length == 16 && _isNumeric(element.text)) {
            text = element.text;
            return text;
          }
        }
      }
    }
    return text;
  }

  bool _isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return int.tryParse(s) != null;
  }
}
