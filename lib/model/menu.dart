// ignore: public_member_api_docs
import 'package:flutter/material.dart';

typedef onSelectedMenu = void Function(BuildContext context);

// ignore: public_member_api_docs
class MenuModel {
  final String title;
  final IconData icons;
  Function onSelectedMenu;

  // ignore: public_member_api_docs
  MenuModel({this.title, this.icons, this.onSelectedMenu});
}
