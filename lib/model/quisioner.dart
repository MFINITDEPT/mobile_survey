import 'package:mobilesurvey/utilities/parse_utils.dart';

class QuisionerModel {
  final String question;
  final List<String> choice;

  QuisionerModel({this.question, this.choice});

  factory QuisionerModel.fromJson(Map<String, dynamic> json) {
    List<String> _choices = [];
    if (json.containsKey('Choice') != null && json['Choice'] is List) {
      for (var item in json['Choice']) {
        _choices.add(item);
      }
    }

    return QuisionerModel(
        question: json.containsKey('Question')
            ? ParseUtils.castString(json['Question'])
            : null,
        choice: _choices);
  }
}
