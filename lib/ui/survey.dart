import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/logic/survey.dart';
import 'package:mobilesurvey/model/nik_data.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobilesurvey/component/adv_row.dart';
import 'package:mobilesurvey/component/adv_column.dart';

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
    _logic = SurveyBase(this, widget.model, widget.nik);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _logic.checkData();
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(translation.getText('survey')),
            centerTitle: true,
            actions: [
              Observer(
                  builder: (_) => Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            _logic.pages,
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ),
                      ))
            ]),
        body: PageView(
          controller: _logic.page,
          onPageChanged: _logic.onPageChange,
          children: [
            _buildFirstPage(),
            _buildSecondPage(),
            _buildFirstPage(),
            _buildFirstPage(),
          ],
        ));
  }

  Widget _buildFirstPage() {
    return ListView(
      children: [
        _buildTextField('name', _logic.name),
        _buildTextField('birth_location', _logic.birthLocation),
        _buildTextField('birth_date', _logic.birthDate),
        _buildTextField('address', _logic.address),
      ],
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

  Widget _buildTextField(String title, TextEditingController controller) {
    return AdvRow(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      children: [
        Expanded(
            child: TextField(
                style: TextStyle(fontSize: 14.0),
                decoration: InputDecoration(
                    enabled: false,
                    hintText: translation.getText(title),
                    hintStyle: TextStyle(color: Palette.blue),
                    disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Palette.prime))))),
        Expanded(
            flex: 2,
            child: TextField(
              controller: controller,
              style: TextStyle(color: Palette.prime, fontSize: 14.0),
              decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.prime)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Palette.prime))),
            ))
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
