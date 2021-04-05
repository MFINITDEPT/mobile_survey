import 'package:flutter/material.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/component/custom_shape.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/palette.dart';

class RoleUI extends StatefulWidget {
  @override
  _RoleUIState createState() => _RoleUIState();
}

class _RoleUIState extends NewState<RoleUI> {
  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: kDeviceTopPadding(context)),
        child: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
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
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Pilih Role",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                  color: Palette.navy)),

                          //kamuflase biar rada atasan
                          Container(height: kDeviceHeight(context) * 0.20),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
