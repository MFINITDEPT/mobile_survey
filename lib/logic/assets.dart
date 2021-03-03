import 'dart:io';

import 'package:adv_image_picker/adv_image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobx/mobx.dart';

part 'assets.g.dart';

class AssetsBase = _AssetsLogic with _$AssetsBase;

abstract class _AssetsLogic with Store {
  NewState _state;

  _AssetsLogic(this._state);

  BuildContext get _context => _state.context;

  @observable
  File file;

  @action
  void takePhoto() {
    AdvImagePicker.pickImagesToFile(_context, usingGallery: false, useCustomView: false)
        .then((value) => _state.setState(() {
              file = value.first;
            }));
  }

  @action
  void removePhoto(){
    file = null;
  }
}
