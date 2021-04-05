
import 'package:flutter/material.dart';

import '../boilerplate/new_state.dart';
import '../component/custom_circular_tab_indicator.dart';
import '../ui/history.dart';
import '../ui/home.dart';
import '../utilities/assets.dart';
import '../utilities/palette.dart';
import '../utilities/translation.dart';

// ignore: public_member_api_docs
class HomeContainerUI extends StatefulWidget {
  @override
  _NewHomeContainerUiState createState() => _NewHomeContainerUiState();
}

class _NewHomeContainerUiState extends NewState<HomeContainerUI>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return _buildTabSegment();
  }

  Widget _buildTabSegment() {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        bottom: TabBar(
          controller: _controller,
          labelColor: Palette.gold,
          labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
          unselectedLabelColor: Palette.navy,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          indicator: CircleTabIndicator(color: Palette.gold, radius: 3),
          tabs: [
            Tab(
                child: Text(translation.getText('home'),
                    maxLines: 1, style: TextStyle(fontSize: 14.0))),
            Tab(
                child: Text(translation.getText('history'),
                    maxLines: 1, style: TextStyle(fontSize: 14.0))),
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
                  child: Image.asset(Assets.camera,
                      height: 50, width: 50, fit: BoxFit.cover),
                ),
              )),
        ],
      ),
      body: TabBarView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: [HomeUI(), HistoryUI()],
      ),
    );
  }
}
