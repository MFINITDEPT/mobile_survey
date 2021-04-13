// ignore: public_member_api_docs
import 'package:flutter/material.dart';
import 'package:mobilesurvey/ui/interceptor.dart';

typedef onSelectedMenu = void Function(BuildContext context);

// ignore: public_member_api_docs
class MenuModel {
  final String title;
  final IconData icons;
  final AppType appType;
  Function onSelectedMenu;

  // ignore: public_member_api_docs
  MenuModel({this.title, this.icons, this.appType, this.onSelectedMenu});
}
