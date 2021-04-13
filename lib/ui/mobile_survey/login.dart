import 'package:flutter/material.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/logic/mobile_survey/login.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/component/custom_shape.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobilesurvey/component/custom_textfield.dart';
import 'package:mobilesurvey/component/custom_button.dart';

/// UI class for Login
class LoginSurveyUI extends StatefulWidget {
  @override
  _LoginSurveyUIState createState() => _LoginSurveyUIState();
}

class _LoginSurveyUIState extends NewState<LoginSurveyUI> {
  LoginBase _logic;

  @override
  void initState() {
    _logic = LoginBase();
    super.initState();
  }

  @override
  Widget buildView(BuildContext context) {
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
                  _buildGreeting(),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          //kamuflase biar form di tengah
                          Container(height: kDeviceHeight(context) * 0.15),
                          _loginSegment(),
                          InkWell(
                              onTap: null,
                              child: Text(
                                translation.getText("forgot_password_mark"),
                                style: TextStyle(
                                    fontSize: 14.0, color: Palette.gold),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 32.0),
                            child: Align(
                              alignment: Alignment.center,
                              child: CustomButton(
                                "sign_in",
                                onPress: () => _logic.signIn(process, context),
                                buttonWidth: kDeviceWidth(context) * 0.6,
                              ),
                            ),
                          ),
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

  Widget _buildGreeting() {
    return Stack(
      children: <Widget>[
        BottomShape(),
        Positioned(
          top: 30,
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(translation.getText('login_greeting1'),
                      style: TextStyle(color: Palette.white, fontSize: 22.0)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(translation.getText('login_greeting2'),
                        style: TextStyle(color: Palette.white, fontSize: 14.0)),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _loginSegment() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
      child: Column(children: <Widget>[
        CustomTextField(
            padding: 16.0, controller: null, title: translation.getText("nik")),
        CustomTextField(
          padding: 16.0,
          title: translation.getText("password"),
          obsecureText: true,
          controller: null,
        ),
      ]),
    );
  }
}
