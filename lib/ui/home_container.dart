import 'package:flutter/material.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/logic/home_container.dart';
import 'package:mobilesurvey/model/nik_data.dart';
import 'package:mobilesurvey/ui/client.dart';
import 'package:mobilesurvey/ui/quisioner.dart';
import 'package:mobilesurvey/ui/survey.dart';
import 'package:mobilesurvey/utilities/assets.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/component/custom_circular_tab_indicator.dart';
import 'package:mobilesurvey/utilities/translation.dart';

class HomeContainerUI extends StatefulWidget {
  final NikDataModel model;
  final String nik;
  final int index;

  const HomeContainerUI({Key key, this.model, this.nik, this.index})
      : super(key: key);

  @override
  _HomeContainerUIState createState() => _HomeContainerUIState();
}

class _HomeContainerUIState extends NewState<HomeContainerUI> {
  HomeContainerBase _logic;

  @override
  void initState() {
    _logic = HomeContainerBase(this, widget.model, widget.nik);
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return _buildTabSegment();
  }

  Widget _buildTabSegment() {
    return DefaultTabController(
      length: 4,
      initialIndex: widget.index ?? 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          bottom: TabBar(
            labelColor: Palette.gold,
            labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
            unselectedLabelColor: Palette.prime,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            indicator: CircleTabIndicator(color: Palette.gold, radius: 3),
            tabs: [
              Tab(
                  child: Text(translation.getText('home'),
                      maxLines: 1, style: TextStyle(fontSize: 12.0))),
              Tab(
                  child: Text(translation.getText('survey'),
                      maxLines: 1, style: TextStyle(fontSize: 12.0))),
              Tab(
                  child: Text(translation.getText('history'),
                      maxLines: 1, style: TextStyle(fontSize: 12.0))),
              Tab(
                  child: Text(translation.getText('performance'),
                      maxLines: 1, style: TextStyle(fontSize: 12.0))),
            ],
          ),
          backgroundColor: Palette.white,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    color: Palette.gold,
                    child: Image.asset(Assets.logo,
                        height: 50, width: 50, fit: BoxFit.cover),
                  ),
                )),
          ],
        ),
        body: TabBarView(
          children: [
            Container(color: Palette.gold),
            ClientUI(),
            QuisionerUI(),
            Container(color: Palette.black26),
          ],
        ),
      ),
    );
  }
}
