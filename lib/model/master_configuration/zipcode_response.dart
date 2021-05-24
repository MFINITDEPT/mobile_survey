// ignore: public_member_api_docs
import 'package:mobilesurvey/model/master_configuration/zipcode_item.dart';

import 'zipcode_item.dart';

// ignore: public_member_api_docs
class ZipCodeResponse {
  final int status;
  final String message;
  final List<ZipCodeItem> data;

  // ignore: public_member_api_docs
  ZipCodeResponse({this.status, this.message, this.data});

  factory ZipCodeResponse.fromJson(Map<String, dynamic> json) {
    var list = [];
    if (json.containsKey('data')) {
      for (var item in json['data']) {
        list.add(ZipCodeItem.fromJson(item));
      }
    }

    return ZipCodeResponse(
        status: json.containsKey('status') ? json['status'] : null,
        message: json.containsKey('message') ? json['message'] : null,
        data: List<ZipCodeItem>.from(list));
  }
}
