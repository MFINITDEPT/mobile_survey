import 'package:mobilesurvey/utilities/parse_utils.dart';
import 'package:hive/hive.dart';

part 'quisioner.g.dart';

@HiveType()
class QuisionerModel {
  @HiveField(0)
  final String question;
  @HiveField(1)
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

  Map<String, dynamic> toJson() {
    List<String> _choices = [];
    if (this.choice != null && this.choice is List) {
      for (var item in this.choice) {
        _choices.add(item);
      }
    }
    return {
      "Question": this.question,
      "Choice": _choices.length == 0 ? null : _choices
    };
  }
}
