import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/model/menu.dart';
import 'package:mobilesurvey/ui/interceptor.dart';
import 'package:mobx/mobx.dart';

part 'role.g.dart';

class RoleBase = _RoleLogic with _$RoleBase;

// ignore: avoid_classes_with_only_static_members
abstract class _RoleLogic with Store {
  var menu = <MenuModel>[
    MenuModel(
        title: "Survey", icons: Icons.menu, onSelectedMenu: _goToMobileSurvey),
    MenuModel(
        title: "Collection",
        icons: Icons.camera,
        onSelectedMenu: _goToMobileCollection),
    MenuModel(
        title: "Dashboard",
        icons: Icons.cached,
        onSelectedMenu: _goToMobileDashboard),
    MenuModel(
        title: "IProve", icons: Icons.title, onSelectedMenu: _goToMobileSurvey),
  ];

  static void _goToMobileSurvey(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => InterceptorPageUI(appType: AppType.survey)));
  }

  static void _goToMobileCollection(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => InterceptorPageUI(appType: AppType.collection)));
  }

  static void _goToMobileDashboard(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => InterceptorPageUI(appType: AppType.dashboard)));
  }
}
