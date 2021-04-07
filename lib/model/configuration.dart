import 'package:mobilesurvey/utilities/parse_utils.dart';

// ignore: public_member_api_docs
class ConfigurationModel {
  final String lastUpdateQuestion;
  final String lastUpdateZipCode;
  final String lastUpdateAo;
  final String lastUpdateForm;

  // ignore: public_member_api_docs
  ConfigurationModel(
      {this.lastUpdateQuestion,
      this.lastUpdateZipCode,
      this.lastUpdateAo,
      this.lastUpdateForm});

  // ignore: public_member_api_docs
  factory ConfigurationModel.fromJson(Map<String, dynamic> json) {
    return ConfigurationModel(
        lastUpdateQuestion: json.containsKey('lastModDateQuestion')
            ? ParseUtils.castString(json['lastModDateQuestion'])
            : null,
        lastUpdateZipCode: json.containsKey('lastModDateZipCode')
            ? ParseUtils.castString(json['lastModDateZipCode'])
            : null,
        lastUpdateAo: json.containsKey('lastModDateAO')
            ? ParseUtils.castString(json['lastModDateAO'])
            : null,
        lastUpdateForm: json.containsKey('lastModDateFotoForm')
            ? ParseUtils.castString(json['lastModDateFotoForm'])
            : null);
  }
}
