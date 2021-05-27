import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/component/custom_circular_tab_indicator.dart';
import 'package:mobilesurvey/logic/mobile_survey/task.dart';
import 'package:mobilesurvey/utilities/assets.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/translation.dart';

import 'assets.dart';
import 'client.dart';
import 'document.dart';
import 'process.dart';
import 'quisioner.dart';

class TaskUI extends StatefulWidget {
  final String id;

  const TaskUI({Key key, this.id}) : super(key: key);

  @override
  _TaskUIState createState() => _TaskUIState();
}

class _TaskUIState extends NewState<TaskUI> {
  final TaskBase _logic = TaskBase();

  @override
  void initState() {
    _logic.setupReaction();
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return _buildTabSegment();
  }

  Widget _buildTabSegment() {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text(translation.getText('task'),
              style: TextStyle(
                  color: Palette.navy,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0)),
          centerTitle: true,
          elevation: 0.0,
          bottom: TabBar(
            labelColor: Palette.gold,
            labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
            unselectedLabelColor: Palette.navy,
            labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            indicator: CircleTabIndicator(color: Palette.gold, radius: 3),
            tabs: [
              Tab(
                  child: Text(translation.getText('client'),
                      maxLines: 1, style: TextStyle(fontSize: 14.0))),
              Tab(
                  child: Text(translation.getText('quisioner'),
                      maxLines: 1, style: TextStyle(fontSize: 14.0))),
              Tab(
                  child: Text(translation.getText('assets'),
                      maxLines: 1, style: TextStyle(fontSize: 14.0))),
              Tab(
                  child: Text(translation.getText('document'),
                      maxLines: 1, style: TextStyle(fontSize: 14.0))),
              Tab(
                  child: Text(translation.getText('process'),
                      maxLines: 1, style: TextStyle(fontSize: 14.0))),
            ],
          ),
          //backgroundColor: Palette.white,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    color: Palette.gold,
                    child: Image.asset(Assets.camera,
                        height: 50, width: 50, fit: BoxFit.cover),
                  ),
                )),
          ],
        ),
        body: TabBarView(
          children: [
            Observer(builder: (_) {
              if (_logic.clientIsEmpty) {
                return Container();
              } else {
                return ClientUI(list: _logic.client);
              }
            }),
            QuisionerUI(),
            AssetsUI(),
            DocumentUI(),
            ProcessUI(),
          ],
        ),
      ),
    );
  }
}
