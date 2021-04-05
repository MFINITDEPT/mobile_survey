import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) {
    return Material(
      child: Image(image: widget.assetImage, fit: BoxFit.fill),
    );
  }
}
