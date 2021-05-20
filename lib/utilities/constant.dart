import 'package:flutter/material.dart';
import 'package:mobilesurvey/logic/loading.dart';
import 'package:mobilesurvey/model/mobile_dashboard/branch.dart';
import 'package:mobilesurvey/model/mobile_dashboard/marketing.dart';
import 'package:mobilesurvey/utilities/date_utils.dart';
import 'package:mobilesurvey/utilities/palette.dart';

//String Constant
String kRijndaelKey = "mncbangkredit";
String kRijndaelIV = "mncsecurity";
String kHiveKey = "MobileMNCFlutter";
String kAppType = "AppType";
String kLang = "language";

//SharePreferences Key Mobile Survey
String kMobileSurveyUserId = "MobileSurveyUserId";
String kMobileSurveyUsername = "MobileSurveyUsername";
String kLastUpdateZipCode = "lastUpdateZipcode";
String kLastUpdateQuestion = "lastUpdateQuestion";
String kLastUpdateAO = "lastUpdateAO";
String kLastUpdateForm = "lastUpdateForm";
String kHiveKeys_1 = "AO";
String kHiveKeys_2 = "Quisioner";
String kHiveKeys_3 = "Zipcode";
String kHiveKeys_4 = "Pic";
String kHiveKeys_5 = "Doc";
String kLastSavedClient;

//SharePreferences Key Mobile Dashboard
String kMobileDashboardUserId = 'MobileDashboardUserId';

//int constant
int kCaptchaLength = 6;
int kMaxSizeUpload = 1003102 * 100;
int kMaxData = 100;

//array kosong
var kBranches = <BranchModel>[];

// array constant
List<String> kSupportedLanguages = ['id', 'en'];
List<int> kKPRCode = [23, 25, 33, 45, 53, 54, 59];
List<int> kEXPCode = [28, 30, 56, 58, 55, 47, 49, 48, 57, 46];
List<int> kREGCode = [
  51,
  52,
  32,
  21,
  24,
  50,
  26,
  22,
  60,
  41,
  44,
  42,
  31,
  27,
  11
];
//
Loading kLoading;

// MediaQuery
double kDeviceHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

double kDeviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

double kDeviceTopPadding(BuildContext context) =>
    MediaQuery.of(context).padding.top;

double kRatioDevice(BuildContext context) =>
    MediaQuery.of(context).devicePixelRatio;

double kPhysicalPixelWidth(BuildContext context) =>
    kDeviceWidth(context) * kRatioDevice(context);

double kPhysicalPixelHeight(BuildContext context) =>
    kDeviceHeight(context) * kRatioDevice(context);

double kBaseFont(BuildContext context) => (kPhysicalPixelWidth(context) * 0.25);

//constant
ThemeData kTheme = ThemeData(
    cursorColor: Palette.black,
    primaryTextTheme: TextTheme(title: TextStyle(color: Palette.white)),
    primaryIconTheme: IconThemeData(color: Palette.gold),
    brightness: Brightness.light,
    primarySwatch: Palette.blue,
    primaryColor: Palette.white,
    primaryColorBrightness: Brightness.light,
    accentColor: Palette.blue,
    scaffoldBackgroundColor: Palette.white,
    fontFamily: "Roboto",
    accentColorBrightness: Brightness.light);

AppBar kITrackAppbar(String title, BuildContext context) {
  return AppBar(
      title: Text(title, style: TextStyle(fontSize: 14.0)),
      centerTitle: true,
      leading: IconButton(
          iconSize: 14.0,
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context, rootNavigator: true).maybePop();
          },
          icon: Icon(Icons.arrow_back_ios)));
}

List<MarketingData> kgetMarketingUnit(
    MarketingReportModel res, MarketingReportModel res2, DateTime date) {
  var month =
      int.tryParse(DateUtilities.convertDateTimeToString(date, format: "MM"));

  var current = res.current;
  var _rawbefore = res2.before;
  var before = res.before;
  var combine = current;
  var ress = <MarketingData>[];

  if (before.isNotEmpty) {
    for (var item in current) {
      before.removeWhere((bfore) {
        return bfore.productFacility == item.productFacility;
      });
    }

    for (var item in before) {
      combine.add(item);
    }
  }

  for (var item in combine) {
    var data = <MarketingUnit>[];

    for (var i = 0; i < (month); i++) {
      var s = (month - i) % 12;
      var _unitPokokPercent = kgetMarketingData(
          s,
          current.firstWhere(
              (crnt) => item.productFacility == crnt.productFacility,
              orElse: () => null),
          date.year);
      data.add(_unitPokokPercent);
    }

    for (var i = 12; i > (month); i--) {
      var s = (i) % 12;
      var _unitPokokPercent = kgetMarketingData(
          s,
          _rawbefore.firstWhere(
              (crnt) => item.productFacility == crnt.productFacility,
              orElse: () => null),
          date.year - 1);
      data.add(_unitPokokPercent);
    }

    ress.add(MarketingData(
        code: item.code,
        module: item.module,
        assetType: item.assetType,
        productFacility: item.productFacility,
        data: data));
  }

  return ress;
}

MarketingUnit kgetMarketingData(int s, MarketingDataObject object, int year) {
  if (object != null) {
    switch (s) {
      case 1:
        return MarketingUnit(
            unit: object.unitJan,
            amount: object.pokokJan,
            percent: object.persenJan,
            year: year);
      case 2:
        return MarketingUnit(
            unit: object.unitFeb,
            amount: object.pokokFeb,
            percent: object.persenFeb,
            year: year);
      case 3:
        return MarketingUnit(
            unit: object.unitMar,
            amount: object.pokokMar,
            percent: object.persenMar,
            year: year);
      case 4:
        return MarketingUnit(
            unit: object.unitApr,
            amount: object.pokokApr,
            percent: object.persenApr,
            year: year);
      case 5:
        return MarketingUnit(
            unit: object.unitMei,
            amount: object.pokokMei,
            percent: object.persenMei,
            year: year);
      case 6:
        return MarketingUnit(
            unit: object.unitJul,
            amount: object.pokokJun,
            percent: object.persenJun,
            year: year);
      case 7:
        return MarketingUnit(
            unit: object.unitJul,
            amount: object.pokokJul,
            percent: object.persenJul,
            year: year);
      case 8:
        return MarketingUnit(
            unit: object.unitAug,
            amount: object.pokokAug,
            percent: object.persenAug,
            year: year);
      case 9:
        return MarketingUnit(
            unit: object.unitSep,
            amount: object.pokokSep,
            percent: object.persenSep,
            year: year);
      case 10:
        return MarketingUnit(
            unit: object.unitOct,
            amount: object.pokokOct,
            percent: object.persenOct,
            year: year);
      case 11:
        return MarketingUnit(
            unit: object.unitNov,
            amount: object.pokokNov,
            percent: object.persenNov,
            year: year);
      case 0:
        return MarketingUnit(
            unit: object.unitDec,
            amount: object.pokokDec,
            percent: object.persenDec,
            year: year);
    }
  } else {
    return MarketingUnit(unit: 0, amount: 0, percent: 0, year: year);
  }
}
