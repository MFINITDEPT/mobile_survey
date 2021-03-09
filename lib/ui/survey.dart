/*
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/component/adv_column.dart';
import 'package:mobilesurvey/component/custom_button.dart';
import 'package:mobilesurvey/logic/survey.dart';
import 'package:mobilesurvey/model/nik_data.dart';
import 'package:mobilesurvey/ui/client.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/translation.dart';

class SurveyUI extends StatefulWidget {
  final NikDataModel model;
  final String nik;

  const SurveyUI({Key key, this.model, this.nik}) : super(key: key);

  @override
  _SurveyUIState createState() => _SurveyUIState();
}

class _SurveyUIState extends NewState<SurveyUI> {
  SurveyBase _logic;

  @override
  void initState() {
    _logic = SurveyBase(this);

    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _logic.page,
          onPageChanged: _logic.onPageChange,
          children: [
            ClientUI(nik: widget.nik, nikDataModel: widget.model),
            _buildButton(),
          ],
        ));
  }

  Widget _buildButton() {
    return Center(
      child: Container(
        margin: EdgeInsets.all(32.0),
        constraints: BoxConstraints(maxHeight: 100.0),
        child: CustomButton('navigate to survey',
            onpress: _logic.navigateToQuisioner, buttonWidth: double.infinity),
      ),
    );
  }

  Widget _buildSecondPage() {
    return ListView(
      children: [
        _buildFotoItems('foto_debitur'),
        _buildFotoItems('foto_unit'),
        _buildFotoItems('foto_domisili'),
        _buildFotoItems('foto_document'),
      ],
    );
  }

  Widget _buildFotoItems(String title) {
    return AdvColumn(
      divider: ColumnDivider(4.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      children: [
        Align(
            child: Text(
              translation.getText(title),
              style: TextStyle(fontSize: 14.0, color: Palette.blue),
            ),
            alignment: Alignment.topLeft),
        Wrap(
            spacing: 4.0,
            runSpacing: 4.0,
            children: List.generate(4, (index) => _buildImage(title, index)))
      ],
    );
  }

  Widget _buildImage(String title, int index) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Palette.prime),
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          height: kDeviceWidth(context) * 0.20,
          width: kDeviceWidth(context) * 0.20,
          child: Center(child: Icon(Icons.add, color: Palette.prime))),
      onTap: () => _logic.onImageTap(title, index),
    );
  }
}
*/
