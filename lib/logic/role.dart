import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/model/menu.dart';
import 'package:mobilesurvey/ui/interceptor.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/shared_preferences_utils.dart';
import 'package:mobx/mobx.dart';

part 'role.g.dart';

class RoleBase = _RoleLogic with _$RoleBase;

// ignore: avoid_classes_with_only_static_members
abstract class _RoleLogic with Store {
  var menu = <MenuModel>[
    MenuModel(
        title: "Survey",
        icons: Icons.menu,
        appType: AppType.survey,
        onSelectedMenu: _goToInterceptorPage),
    MenuModel(
        title: "Collection",
        icons: Icons.camera,
        appType: AppType.collection,
        onSelectedMenu: _goToInterceptorPage),
    MenuModel(
        title: "Dashboard",
        icons: Icons.cached,
        appType: AppType.dashboard,
        onSelectedMenu: _goToInterceptorPage),
    MenuModel(
        title: "IProve",
        icons: Icons.title,
        appType: AppType.approval,
        onSelectedMenu: _goToInterceptorPage),
  ];

  static void _goToInterceptorPage(BuildContext context, AppType appType) {
    PreferenceUtils.setString(kAppType, appType.toString());
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => InterceptorPageUI(appType: appType)));
  }
}
