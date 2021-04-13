import 'package:flutter/material.dart';
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
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => RoleUI()));
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
}
