import 'dart:io';

import 'package:mobilesurvey/model/photo_form.dart';

class PhotoResult {
  PhotoForm form;
  List<File> result;

  PhotoResult({this.form, this.result});
}
