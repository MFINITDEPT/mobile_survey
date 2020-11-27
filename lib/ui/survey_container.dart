import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/component/custom_circular_tab_indicator.dart';
import 'package:mobilesurvey/logic/survey_container.dart';
import 'package:mobilesurvey/model/nik_data.dart';
import 'package:mobilesurvey/ui/client.dart';
import 'package:mobilesurvey/ui/quisioner.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/translation.dart';

class SurveyContainerUI extends StatefulWidget {
  final String nik;
  final NikDataModel model;

  const SurveyContainerUI({Key key, this.nik, this.model}) : super(key: key);

  @override
  _SurveyContainerUIState createState() => _SurveyContainerUIState();
}

class _SurveyContainerUIState extends NewState<SurveyContainerUI> {
  SurveyContainerBase _logic;

  @override
  void initState() {
    _logic = SurveyContainerBase(this, widget.nik, widget.model);
    _logic.getData();
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            labelColor: Palette.gold,
            labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
            unselectedLabelColor: Palette.prime,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            indicator: CircleTabIndicator(color: Palette.gold, radius: 3),
            tabs: [
              Tab(
                  child: Text(translation.getText('client'),
                      maxLines: 1, style: TextStyle(fontSize: 12.0))),
              Tab(
                  child: Text(translation.getText('quisioner'),
                      maxLines: 1, style: TextStyle(fontSize: 12.0))),
              Tab(
                  child: Text(translation.getText('asset'),
                      maxLines: 1, style: TextStyle(fontSize: 12.0))),
            ],
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Palette.white,
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            Observer(
                builder: (_) =>
                    ClientUI(nik: _logic.nik, nikDataModel: _logic.nikModel)),
            Observer(builder: (_) => QuisionerUI(model: _logic.model)),
            Container(
                color: Palette.gold,
                child: Center(child: Text("Under Development")))
          ],
        ),
      ),
    );
  }
}
