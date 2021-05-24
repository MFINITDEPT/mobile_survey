import 'package:mobilesurvey/model/master_configuration/quisioner_item.dart';

import 'quisioner_item.dart';

// ignore: public_member_api_docs
class QuisionerResponse {
  final int status;
  final String message;
  final List<QuisionerItem> data;

  // ignore: public_member_api_docs
  QuisionerResponse({this.status, this.message, this.data});

  factory QuisionerResponse.fromJson(Map<String, dynamic> json) {
    var list = [];
    if (json.containsKey('data')) {
      for (var item in json['data']) {
        list.add(QuisionerItem.fromJson(item));
      }
    }
    return QuisionerResponse(
        status: json.containsKey('status') ? json['status'] : null,
        message: json.containsKey('message') ? json['message'] : null,
        data: List<QuisionerItem>.from(list));
  }
}
