import 'dart:io';

import 'package:adv_image_picker/adv_image_picker.dart';
import 'package:documents_picker/documents_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/model/photo_form.dart';
import 'package:mobilesurvey/model/photo_result.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobilesurvey/utilities/ui_utils.dart';
import 'package:mobx/mobx.dart';
import 'package:open_file/open_file.dart';
import 'package:pit_permission/pit_permission.dart';

part 'document.g.dart';

class DocumentBase = _DocumentLogic with _$DocumentBase;

abstract class _DocumentLogic with Store {
  NewState _state;

  _DocumentLogic(this._state);

  BuildContext get _context => _state.context;

  @observable
  ObservableList<PhotoResult> _results = ObservableList.of([]);

  @computed
  ObservableList<PhotoResult> get results {
    List<PhotoResult> _result = List<PhotoResult>();
    MasterRepositories.docPhoto.forEach((element) {
      PhotoResult _item = PhotoResult();
      _item.form =
          MasterRepositories.docPhoto.firstWhere((item) => element == item);
      _item.result = List<File>(element.count);

      _result.add(_item);
    });

    return _results = ObservableList.of(_result);
  }

  @action
  Future<void> browseFile(PhotoForm form, int index) async {
    if (_getFileFromResult(form) == null) {
      Fluttertoast.showToast(
          msg: "something error", toastLength: Toast.LENGTH_LONG);
      return;
    }

    List<File> _files = _getFileFromResult(form);

    if (form.type.toLowerCase() == "dokumen") {
      int result = await UIUtils.browseFile(_context);

      int _fileCount = _files.where((element) => element != null).length;

      if (_fileCount >= form.count) {
        Fluttertoast.showToast(
            msg: translation.getText('maximum_file_length_exceed'),
            toastLength: Toast.LENGTH_LONG);
        return;
      }

      var maxCount = form.count - _fileCount;

      await PitPermission.requestSinglePermission(PermissionName.storage);

      switch (result) {
        case 1:
          List<File> file = await AdvImagePicker.pickImagesToFile(_context,
              usingCamera: true, useCustomView: false, usingGallery: false);
          if (file.isNotEmpty) {
            if (file.first.lengthSync() < kMaxSizeUpload)
              _state.setState(() {
                _files[index] = file.first;
              });
            else if (file.first.lengthSync() > kMaxSizeUpload)
              Fluttertoast.showToast(
                  msg: translation.getText('maximum_file_length_exceed'),
                  toastLength: Toast.LENGTH_LONG);
          }
          break;
        case 2:
          List<String> docPaths =
              await DocumentsPicker.pickImages(maxCount: maxCount);
          for (var item in docPaths) {
            File file = File(item);
            if (file.lengthSync() < kMaxSizeUpload)
              _state.setState(() {
                _files[_files.indexOf(null)] = file;
              });
            else if (file.lengthSync() > kMaxSizeUpload)
              Fluttertoast.showToast(
                  msg: translation.getText('maximum_file_length_exceed'),
                  toastLength: Toast.LENGTH_LONG);
          }
          break;
        case 3:
          List<String> docPaths =
              await DocumentsPicker.pickDocuments(maxCount: maxCount);
          for (var item in docPaths) {
            File file = File(item);
            if (file.lengthSync() < kMaxSizeUpload)
              _state.setState(() {
                _files[_files.indexOf(null)] = file;
              });
            else if (file.lengthSync() > kMaxSizeUpload)
              Fluttertoast.showToast(
                  msg: translation.getText('maximum_file_length_exceed'),
                  toastLength: Toast.LENGTH_LONG);
          }
          break;
        default:
          return;
      }
    } else if (form.type.toLowerCase() == "foto") {
      List<File> files = await AdvImagePicker.pickImagesToFile(_context,
          usingGallery: false, useCustomView: false);
      _getFileFromResult(form)[index] = files.first;
    }
  }

  @action
  void removePhoto(PhotoResult photo, int index) {
    _state.setState(() {
      photo.result[index] = null;
    });
  }

  List<File> _getFileFromResult(PhotoForm form) {
    return _results
        ?.firstWhere((element) => form == element.form, orElse: null)
        ?.result;
  }

  File image(PhotoForm form, int index) {
    if (_getFileFromResult(form) == null) return null;
    return _getFileFromResult(form)[index];
  }

  @action
  void openFile(String fileAttach) {
    OpenFile.open(fileAttach);
  }
}
