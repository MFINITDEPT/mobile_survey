import 'package:flutter/material.dart';
import 'package:mobilesurvey/logic/loading.dart';
import 'package:mobilesurvey/utilities/palette.dart';

//String Constant
String kRijndaelKey = "mncbangkredit";
String kRijndaelIV = "mncsecurity";
String kHiveKey = "MobileMNCFlutter";

//SharePreferences Key
String kLang = "language";
String kUserId = "userid";
String kLastUpdateZipCode = "lastUpdateZipcode";
String kLastUpdateQuestion = "lastUpdateQuestion";
String kLastUpdateAO = "lastUpdateAO";
String kHiveKeys_1 = "AO";
String kHiveKeys_2 = "Quisioner";
String kHiveKeys_3 = "Zipcode";

//int constant
int kCaptchaLength = 6;
int kMaxSizeUpload = 1003102 * 2;
int kMaxData = 100;

// array constant
List<String> kSupportedLanguages = ['id', 'en'];

//
Loading kLoading;

// MediaQuery
double kDeviceTopPadding(BuildContext context) =>
    MediaQuery.of(context).padding.top;

double kDeviceHeight(BuildContext context) =>
    MediaQuery.of(context).size.height;

double kDeviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

//constant
ThemeData kTheme = ThemeData(
    cursorColor: Palette.gold,
    primaryTextTheme: TextTheme(title: TextStyle(color: Palette.white)),
    primaryIconTheme: IconThemeData(color: Palette.white),
    brightness: Brightness.light,
    primarySwatch: Palette.blue,
    primaryColor: Palette.gold,
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
