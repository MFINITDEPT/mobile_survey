import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:mobilesurvey/logic/role.dart';
import 'package:mobilesurvey/model/menu.dart';
import '../boilerplate/new_state.dart';
import '../component/custom_shape.dart';
import '../utilities/constant.dart';
import '../utilities/palette.dart';
import '../utilities/translation.dart';

class RoleUI extends StatefulWidget {
  @override
  _RoleUIState createState() => _RoleUIState();
}

class _RoleUIState extends NewState<RoleUI> {
  final RoleBase _logic = RoleBase();

  @override
  Widget buildView(BuildContext context) {
    var size = MediaQuery.of(context).size.width / 1.5;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: kDeviceTopPadding(context)),
        child: LayoutBuilder(builder: (context, viewportConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight:
                    kDeviceHeight(context) - (kDeviceTopPadding(context)),
              ),
              child: Stack(
                children: <Widget>[
                  RotatedBox(quarterTurns: 6, child: BottomShape()),
                  Positioned.fill(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(translation.getText('select_role'),
                              style: TextStyle(
                                  color: Palette.navy, fontSize: 24.0)),
                          Transform.rotate(
                              angle: math.pi / 4,
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: RadialGradient(
                                  colors: [
                                    Palette.white,
                                    Palette.gold,
                                  ],
                                )),
                                width: size,
                                height: size,
                                child: _roleMenu(context),
                              )),
                        ]),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _roleMenu(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisSpacing: 16.0,
        children:
            List.generate(4, (index) => _gridItem(context, _logic.menu[index])),
      ),
    );
  }

  Widget _gridItem(BuildContext context, MenuModel item) {
    return Material(
      color: Palette.navy.withOpacity(0.7),
      borderRadius: BorderRadius.circular(20.0),
      child: Ink(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: InkWell(
            splashColor: Palette.black,
            borderRadius: BorderRadius.circular(20.0),
            child: Container(
                child: Center(
              child: Transform.rotate(
                angle: -(math.pi / 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Flexible(
                      child: Icon(
                        item.icons,
                        color: Palette.white,
                        size: 44.0,
                      ),
                    ),
                    Text(
                      item.title,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700,
                          color: Palette.white),
                    )
                  ],
                ),
              ),
            )),
            onTap: () => item.onSelectedMenu(context)),
      ),
    );
  }
}
