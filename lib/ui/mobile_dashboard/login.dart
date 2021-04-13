import 'package:basic_components/components/adv_column.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/component/custom_button.dart';
import 'package:mobilesurvey/component/mobile_dashboard_textfield.dart';
import 'package:mobilesurvey/logic/mobile_dashboard/login.dart';
import 'package:mobilesurvey/utilities/assets.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/translation.dart';

class LoginDashboardUI extends StatefulWidget {
  @override
  _LoginDashboardUIState createState() => _LoginDashboardUIState();
}

class _LoginDashboardUIState extends NewState<LoginDashboardUI> {
  final _login = Login();

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mnc,
      body: Container(
        padding: EdgeInsets.only(top: kDeviceTopPadding(context)),
        height: kPhysicalPixelHeight(context),
        width: kPhysicalPixelWidth(context),
        child: Center(
          child: SingleChildScrollView(
            child: AdvColumn(
              padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
              divider: Container(height: 4.0),
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: AdvColumn(
                    children: <Widget>[
                      Image(image: AssetImage(Assets.mncLogo)),
                      Text(translation.getText('app_name_1'),
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24.0,
                              color: Palette.white)),
                    ],
                  ),
                ),
                MobileDashboardTextField(
                    color: Palette.white,
                    ctrl: _login.username,
                    inputType: TextInputType.number,
                    label: translation.getText('username')),
                MobileDashboardTextField(
                    color: Palette.white,
                    ctrl: _login.password,
                    isPassword: true,
                    label: translation.getText('password')),
                Observer(
                    builder: (_) => _login.errorResponse?.error == "error"
                        ? Align(
                            child: Text(_login.errorResponse.message,
                                style: TextStyle(color: Palette.red)),
                            alignment: Alignment.centerRight)
                        : Visibility(child: Container(), visible: false)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0, top: 16.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomButton(
                      "sign_in",
                      onPress: () => _login.submit(context, process),
                      buttonWidth: double.infinity,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
