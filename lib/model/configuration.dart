import 'package:mobilesurvey/utilities/parse_utils.dart';

class ConfigurationModel {
  final String lastUpdateQuestion;
  final String lastUpdateZipCode;
  final String lastUpdateAo;

  ConfigurationModel(
      {this.lastUpdateQuestion, this.lastUpdateZipCode, this.lastUpdateAo});

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) {
    return ConfigurationModel(
        lastUpdateQuestion: json.containsKey('LastModDateQuestion')
            ? ParseUtils.castString(json['LastModDateQuestion'])
            : null,
        lastUpdateZipCode: json.containsKey('LastModDateZipCode')
            ? ParseUtils.castString(json['LastModDateZipCode'])
            : null,
        lastUpdateAo: json.containsKey('LastModDateAO')
            ? ParseUtils.castString(json['LastModDateAO'])
            : null);
  }
}
