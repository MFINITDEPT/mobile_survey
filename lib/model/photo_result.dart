import 'dart:io';

import 'package:mobilesurvey/model/document_item.dart';

import '../model/photo_form.dart';

// ignore: public_member_api_docs
class PhotoResult {
  PhotoForm form;
  List<DocumentItem> result;

  // ignore: public_member_api_docs
  PhotoResult({this.form, this.result});
}
