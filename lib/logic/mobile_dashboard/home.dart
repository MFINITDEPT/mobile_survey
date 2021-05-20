import 'package:flutter/material.dart';
import 'package:mobilesurvey/model/mobile_dashboard/collplay_menu.dart';
import 'package:mobilesurvey/ui/mobile_dashboard/report_table.dart';
import 'package:mobilesurvey/ui/mobile_dashboard/sales_report.dart';
import 'package:mobilesurvey/ui/role.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/shared_preferences_utils.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobx/mobx.dart';

part 'home.g.dart';

// ignore: public_member_api_docs
class HomeBase = _HomeLogic with _$HomeBase;

abstract class _HomeLogic with Store {
  var menu = <CollplayMenuModel>[
    CollplayMenuModel(Icons.directions_car,
        translation.getText('collection_report_oto'), _gotoCollectionReportOto),
    CollplayMenuModel(Icons.home, translation.getText('collection_report_kpr'),
        _gotoCollectionReportKPR),
    CollplayMenuModel(Icons.multiline_chart,
        translation.getText('sales_report'), _gotoSalesReport),
    CollplayMenuModel(
        Icons.account_circle, translation.getText('signout'), signOut),
  ];

  static void _gotoCollectionReportOto(BuildContext context, {Function fc}) {
    Navigator.push(context,
        MaterialPageRoute(builder: (_) => ReportTableUI(isKPR: false)));
  }

  static void _gotoCollectionReportKPR(BuildContext context, {Function fc}) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => ReportTableUI(isKPR: true)));
  }

  static void _gotoSalesReport(BuildContext context, {Function fc}) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => SalesReportUI()));
  }

  static void signOut(BuildContext context, {Function fc}) {
    fc(() async {
      PreferenceUtils.remove(kMobileDashboardUserId);
      PreferenceUtils.remove(kAppType);

      await Future.delayed(Duration(seconds: 2));
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (_) => RoleUI()), (route) => false);
    });
  }
}
