import 'package:flutter/material.dart';
import 'package:mobilesurvey/ui/interceptor.dart';

typedef onSelectedMenu = void Function(BuildContext context);

class MenuModel {
  final String title;
  final IconData icons;
  final AppType appType;
  Function onSelectedMenu;

  MenuModel({this.title, this.icons, this.appType, this.onSelectedMenu});
}
