import 'package:mobilesurvey/utilities/parse_utils.dart';

class ConfigurationModel {
  final String lastUpdateQuestion;
  final String lastUpdateZipCode;

  ConfigurationModel({this.lastUpdateQuestion, this.lastUpdateZipCode});

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) {
    return ConfigurationModel(
        lastUpdateQuestion: json.containsKey('LastModDateQuestion')
            ? ParseUtils.castString(json['LastModDateQuestion'])
            : null,
        lastUpdateZipCode: json.containsKey('LastModDateZipCode')
            ? ParseUtils.castString(json['LastModDateZipCode'])
            : null);
  }
}
