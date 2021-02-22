
import 'package:flutter/material.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/utilities/palette.dart';

class AssetsUI extends StatefulWidget {
  @override
  _AssetsUIState createState() => _AssetsUIState();
}

class _AssetsUIState extends NewState<AssetsUI> {
  @override
  Widget buildView(BuildContext context) {
    return Container(color: Palette.prime);
  }
}
