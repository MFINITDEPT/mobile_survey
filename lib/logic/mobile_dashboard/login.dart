import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/model/mobile_dashboard/error_response.dart';
import 'package:mobilesurvey/ui/mobile_dashboard/home.dart';
import 'package:mobilesurvey/utilities/api_request.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/shared_preferences_utils.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobx/mobx.dart';

part 'login.g.dart';

class Login = _Login with _$Login;

abstract class _Login with Store {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @observable
  ErrorResponse errorResponse;

  @action
  void submit(BuildContext context, Function fc) {
    if (username.text == null || username.text.isEmpty) {
      errorResponse = ErrorResponse(
          error: 'error', message: translation.getText('empty_username'));
    }

    if (password.text == null || password.text.isEmpty) {
      errorResponse = ErrorResponse(
          error: 'error', message: translation.getText('empty_password'));
    }

    if ((username.text == null || username.text.isEmpty) &&
        (password.text == null || password.text.isEmpty)) {
      errorResponse = ErrorResponse(
          error: 'error',
          message: translation.getText('empty_usernamepassword'));
    }

    if ((username.text == null || username.text.isEmpty) ||
        (password.text == null || password.text.isEmpty)) return;

    fc(() async {
      var _response = await APIRequest.login(username.text, password.text);
      if (_response == null || _response.flag != "1") {
        errorResponse = ErrorResponse(
            error: 'error',
            message: _response.message ?? translation.getText('try_again'));
      }

      if (_response.flag == '1') {
        PreferenceUtils.setString(kMobileDashboardFlag, _response.flag);
        PreferenceUtils.setString(kMobileDashboardUserId, username.text);
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (_) => HomePageUI()), (route) => false);
      }
    });
  }
}
