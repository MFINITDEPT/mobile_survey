import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/logic/home.dart';
import 'package:mobilesurvey/utilities/assets.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/component/adv_column.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends NewState<HomeUI> {
  HomeBase _logic;

  @override
  void initState() {
    _logic = HomeBase(this);
    if (Hive.isBoxOpen(kHiveKeys_1) ||
        Hive.isBoxOpen(kHiveKeys_2) ||
        Hive.isBoxOpen(kHiveKeys_3)) Hive.close();
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Palette.white,
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
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
      body: AdvColumn(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              shadowColor: Palette.black,
              elevation: 8.0,
              child: InkWell(
                onTap: _logic.takePicture,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: SizedBox(
                    width: kDeviceWidth(context) * 0.20,
                    height: kDeviceWidth(context) * 0.20,
                    child: AdvColumn(
                      divider: ColumnDivider(8.0),
                      children: [
                        Expanded(child: Image.asset(Assets.camera)),
                        Text("Generate data dari KTP",
                            style: TextStyle(fontSize: 10.0),
                            textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              shadowColor: Palette.black,
              elevation: 8.0,
              child: InkWell(
                onTap: _logic.navigateToSurvey,
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: SizedBox(
                    width: kDeviceWidth(context) * 0.20,
                    height: kDeviceWidth(context) * 0.20,
                    child: AdvColumn(
                      divider: ColumnDivider(8.0),
                      children: [
                        Expanded(child: Image.asset(Assets.edit)),
                        Text("Isi data manual",
                            style: TextStyle(fontSize: 10.0),
                            textAlign: TextAlign.center)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
