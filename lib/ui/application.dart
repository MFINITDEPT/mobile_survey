import 'package:flutter/material.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/enum.dart';
import 'package:mobilesurvey/utilities/translation.dart';

class ApplicationUI extends StatefulWidget {
  @override
  _ApplicationUIState createState() => _ApplicationUIState();
}

class _ApplicationUIState extends NewState<ApplicationUI> {
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translation.getText('application')),
      ),
      body: ListView(
        children: [_buildRadioButton(facilityType.Consumer, 'Facility Type')],
      ),
    );
  }

  Widget _buildRadioButton(facilityType values, String title) {
    return Column(
      children: [
        Text(title),
        Radio(
            value: values,
            groupValue: facilityType,
            onChanged: (value) => print(value))
      ],
    );
  }
}
