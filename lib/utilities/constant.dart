import 'package:flutter/material.dart';
import 'package:mobilesurvey/logic/loading.dart';
import 'package:mobilesurvey/model/mobile_dashboard/branch.dart';
import 'package:mobilesurvey/utilities/palette.dart';


//String Constant
String kRijndaelKey = "mncbangkredit";
String kRijndaelIV = "mncsecurity";
String kHiveKey = "MobileMNCFlutter";
String kAppType;

//SharePreferences Key Mobile Survey
String kLang = "language";
String kUserId = "userid";
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
String kMobileDashboardFlag = 'MobileDashboardFlag';
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
