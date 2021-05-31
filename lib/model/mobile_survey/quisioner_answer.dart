import 'package:flutter/cupertino.dart';
import 'package:mobilesurvey/model/dropdown.dart';

class QuisionerAnswerModel {
  String id;
  String question;
  SearchModel choice;
  TextEditingController controller;

  QuisionerAnswerModel({this.question, this.choice, this.controller});
}
