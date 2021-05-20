import 'dart:io';

import 'package:adv_image_picker/adv_image_picker.dart';
import 'package:documents_picker/documents_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobilesurvey/model/document_item.dart';
import 'package:mobilesurvey/model/photo_form.dart';
import 'package:mobilesurvey/model/photo_result.dart';
import 'package:mobilesurvey/repositories/master.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/file_utils.dart';
import 'package:mobilesurvey/utilities/hive_utils.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobilesurvey/utilities/ui_utils.dart';
import 'package:mobx/mobx.dart';
import 'package:open_file/open_file.dart';
import 'package:pit_permission/pit_permission.dart';


part 'document.g.dart';

// ignore: public_member_api_docs
class DocumentBase = _DocumentLogic with _$DocumentBase;

abstract class _DocumentLogic with Store {
  final _dispose = autorun((_){
    MasterRepositories.getDocumentPhoto();
  });

  @observable
  ObservableList<PhotoResult> _results =
      ObservableList.of(MasterRepositories.docFormResult);

  @computed
  ObservableList<PhotoResult> get results => _results;

  @action
  Future<void> browseFile(
      PhotoForm form, int index, Function fc, BuildContext context) async {
    var tampungan = _getPhotoItemFromResult(form);

    if (tampungan == null) {
      Fluttertoast.showToast(
          msg: "something error", toastLength: Toast.LENGTH_LONG);
      return;
    }

    if (form.type.toLowerCase() == "foto") {
      var files = await AdvImagePicker.pickImagesToFile(context,
              usingGallery: false, useCustomView: false) ??
          <File>[];
      if (files.isNotEmpty) {
        fc(() {
          tampungan[index] = DocumentItem();
          tampungan[index].path = files.first.path;
          tampungan[index].dateTime = DateTime.now();

          HiveUtils.savePhotoItemToBox(
              kLastSavedClient, tampungan[index], form, index, 'dokumen');
        });
      }
    } else if (form.type.toLowerCase() == "dokumen") {
      var result = await UIUtils.popupMenu(context);

      var _fileCount = tampungan.where((element) => element != null).length;

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
          var file = await AdvImagePicker.pickImagesToFile(context,
                  usingCamera: true,
                  useCustomView: false,
                  usingGallery: false, maxSize: 1080) ??
              <File>[];
          if (file.isNotEmpty) {
            var newFiles = await FileUtils.compressFile(file.first.absolute,
                form.kelengkapan.toLowerCase().replaceAll(" ", ""));
            if (newFiles.lengthSync() < kMaxSizeUpload) {
              fc(() {
                tampungan[index] = DocumentItem();
                tampungan[index].path = newFiles.path;
                tampungan[index].dateTime = DateTime.now();

                HiveUtils.savePhotoItemToBox(
                    kLastSavedClient, tampungan[index], form, index, 'dokumen');
              });
            } else if (newFiles.lengthSync() > kMaxSizeUpload) {
              Fluttertoast.showToast(
                  msg: translation.getText('maximum_file_length_exceed'),
                  toastLength: Toast.LENGTH_LONG);
            }
          }
          break;
        case 2:
          var docPaths = await DocumentsPicker.pickImages(maxCount: maxCount);
          for (var item in docPaths) {
            var file = File(item);
            var newFiles = await FileUtils.compressFile(file.absolute,
                form.kelengkapan.toLowerCase().replaceAll(" ", ""));
            if (newFiles.lengthSync() < kMaxSizeUpload) {
              fc(() {
                var result = DocumentItem();
                result.path = file.path;
                result.dateTime = DateTime.now();

                var newIndex = tampungan.indexOf(null);
                tampungan[newIndex] = result;

                HiveUtils.savePhotoItemToBox(
                    kLastSavedClient, result, form, newIndex, 'dokumen');
              });
            } else if (newFiles.lengthSync() > kMaxSizeUpload) {
              Fluttertoast.showToast(
                  msg: translation.getText('maximum_file_length_exceed'),
                  toastLength: Toast.LENGTH_LONG);
            }
          }
          break;
        case 3:
          var docPaths =
              await DocumentsPicker.pickDocuments(maxCount: maxCount);
          for (var item in docPaths) {
            var file = File(item);
            if (file.lengthSync() < kMaxSizeUpload) {
              fc(() {
                var result = DocumentItem();
                result.path = file.path;
                result.dateTime = DateTime.now();

                var newIndex = tampungan.indexOf(null);
                tampungan[newIndex] = result;

                HiveUtils.savePhotoItemToBox(
                    kLastSavedClient, result, form, newIndex, 'dokumen');
              });
            } else if (file.lengthSync() > kMaxSizeUpload) {
              Fluttertoast.showToast(
                  msg: translation.getText('maximum_file_length_exceed'),
                  toastLength: Toast.LENGTH_LONG);
            }
          }
          break;
        default:
          return;
      }
    }
  }

  @action
  void removePhoto(PhotoResult photo, int index, Function fc) {
    fc(() {
      photo.result[index] = null;
      HiveUtils.deletePhotoItemFromBox(
          kLastSavedClient, photo.form, index, 'dokumen');
    });
  }

  List<DocumentItem> _getPhotoItemFromResult(PhotoForm form) {
    return _results
        ?.firstWhere((element) => form == element.form, orElse: null)
        ?.result;
  }

  DocumentItem document(PhotoForm form, int index) {
    if (_getPhotoItemFromResult(form) == null) return null;
    return _getPhotoItemFromResult(form)[index];
  }

  @action
  void openFile(String fileAttach) {
    OpenFile.open(fileAttach);
  }
}
