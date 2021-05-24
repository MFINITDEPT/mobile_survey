// ignore: public_member_api_docs
import 'package:mobilesurvey/model/master_configuration/form_upload_item.dart';

import 'form_upload_item.dart';

// ignore: public_member_api_docs
class FormUploadResponse {
  final int status;
  final String message;
  final List<FormUploadItem> data;

  // ignore: public_member_api_docs
  FormUploadResponse({this.status, this.message, this.data});

  factory FormUploadResponse.fromJson(Map<String, dynamic> json) {
    var list = [];
    if (json.containsKey('data')) {
      for (var item in json['data']) {
        list.add(FormUploadItem.fromJson(item));
      }
    }
    return FormUploadResponse(
        status: json.containsKey('status') ? json['status'] : null,
        message: json.containsKey('message') ? json['message'] : null,
        data: List<FormUploadItem>.from(list));
  }
}
