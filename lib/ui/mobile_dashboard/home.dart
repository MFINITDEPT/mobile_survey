import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/logic/mobile_dashboard/home.dart';
import 'package:mobilesurvey/model/mobile_dashboard/collplay_menu.dart';
import 'package:mobilesurvey/utilities/assets.dart';
import 'package:mobilesurvey/utilities/palette.dart';

class HomePageUI extends StatefulWidget {
  @override
  _HomePageUIState createState() => _HomePageUIState();
}

class _HomePageUIState extends NewState<HomePageUI> {
  final _homepage = HomeBase();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Container(
                constraints: BoxConstraints(maxHeight: kToolbarHeight),
                child: Image(image: AssetImage(Assets.mncLogo))),
            centerTitle: true),
        backgroundColor: Palette.white,
        body: Column(
          children: [
            Expanded(
                child: Center(
                    child: GridView.count(
              padding: EdgeInsets.all(16.0),
              crossAxisCount: 2,
              mainAxisSpacing: 16.0,
              crossAxisSpacing: 16.0,
              children: List.generate(_homepage.menu.length ?? 0,
                  (index) => _gridItem(context, _homepage.menu[index])),
            ))),
            /*    Padding(
                padding: EdgeInsets.only(bottom: 16.0),
                child: Observer(builder: (_) => Text(_homepage.version)),
              )*/
          ],
        ));
  }

  Widget _gridItem(BuildContext context, CollplayMenuModel menu) {
    return InkWell(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), color: Palette.mnc),
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Icon(menu.icon, color: Palette.white, size: 80.0),
                  Text(menu.title,
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Palette.white))
                ],
              ),
            )),
        onTap: () => menu.onTap(context, fc: process));
  }
}
