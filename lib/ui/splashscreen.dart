import 'package:flutter/material.dart';
import 'package:mobilesurvey/ui/interceptor.dart';
import 'package:mobilesurvey/ui/mobile_dashboard/home.dart';
import 'package:mobilesurvey/ui/mobile_survey/home_container.dart';
import 'package:mobilesurvey/ui/role.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/shared_preferences_utils.dart';

/// Class UI for Splash screen
class SplashScreenUI extends StatefulWidget {
  final AssetImage assetImage;

  /// const constructor for Splash screen UI
  const SplashScreenUI({Key key, this.assetImage}) : super(key: key);

  @override
  _SplashScreenUIState createState() => _SplashScreenUIState();
}

class _SplashScreenUIState extends State<SplashScreenUI> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 3)).then((value) {
        checkPreferences();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Image(image: widget.assetImage, fit: BoxFit.fill),
    );
  }

  void checkPreferences() {
    var appType = PreferenceUtils.getString(kAppType);
    print("masuk $appType");
    if (appType != null) {
      switch (appType) {
        case 'AppType.dashboard':
          if (PreferenceUtils.getString(kMobileDashboardUserId) != null) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomePageUI()));
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => RoleUI()));
          }
          break;
        case 'AppType.survey':
          if (PreferenceUtils.getString(kMobileSurveyUserId) != null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (_) =>
                        InterceptorPageUI(appType: AppType.survey)));
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => RoleUI()));
          }
          break;
        default:
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (_) => RoleUI()));
          break;
      }
    } else {
      print("null bro");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => RoleUI()));
    }
  }
}
