import 'dart:io';

import 'package:adv_image_picker/adv_image_picker.dart';
import 'package:documents_picker/documents_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/model/photo_form.dart';
import 'package:mobilesurvey/model/photo_result.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/enum.dart';
import 'package:mobilesurvey/utilities/hive_utils.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobilesurvey/utilities/ui_utils.dart';
import 'package:mobx/mobx.dart';
import 'package:open_file/open_file.dart';
import 'package:pit_permission/pit_permission.dart';

part 'assets.g.dart';

class AssetsBase = _AssetsLogic with _$AssetsBase;

abstract class _AssetsLogic with Store {
  NewState _state;

  _AssetsLogic(this._state);

  BuildContext get _context => _state.context;

  var _dispose = autorun((_) {
    List<PhotoResult> newPhotoResult = List<PhotoResult>();
    MasterRepositories.photoFormResult.forEach((element) {
      PhotoResult _photoResult = PhotoResult();
      _photoResult.form = element.form;
      List<File> files = List<File>(element.result.length);
      for (int i = 0; i < element.result.length; i++) {
        var result = HiveUtils.readFilePathFromBox(
            kLastSavedClient, _photoResult.form, i, "foto");
        if (result != null) {
          files[i] = File(result);
        }
      }
      _photoResult.result = files;
      newPhotoResult.add(_photoResult);
    });
    MasterRepositories.clearSavedPhotoFormResult(master.pic);
    MasterRepositories.savePhotoFormResult(newPhotoResult, master.pic);
  });

  @observable
  ObservableList<PhotoResult> _results =
      ObservableList.of(MasterRepositories.photoFormResult);

  @computed
  ObservableList<PhotoResult> get results => _results;

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
                HiveUtils.saveFilePathToBox(
                    kLastSavedClient, file.first.path, form, index);
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
                HiveUtils.saveFilePathToBox(
                    kLastSavedClient, file.path, form, docPaths.indexOf(item));
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
                HiveUtils.saveFilePathToBox(
                    kLastSavedClient, file.path, form, docPaths.indexOf(item));
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
     if(files.isNotEmpty) {
       _state.setState(() {
         _getFileFromResult(form)[index] = files.first;
         HiveUtils.saveFilePathToBox(
             kLastSavedClient, files.first.path, form, index);
       });
     }
    }
  }

  @action
  void removePhoto(PhotoResult photo, int index) {
    _state.setState(() {
      photo.result[index] = null;
      HiveUtils.deleteFilePathFromBox(kLastSavedClient, photo.form, index);
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
