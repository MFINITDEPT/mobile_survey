import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/model/mobile_dashboard/error_response.dart';
import 'package:mobilesurvey/ui/mobile_survey/home_container.dart';
import 'package:mobilesurvey/utilities/api_request.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/shared_preferences_utils.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobx/mobx.dart';

part 'login.g.dart';

class LoginBase = _LoginLogic with _$LoginBase;

abstract class _LoginLogic with Store {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @observable
  ErrorResponse errorResponse;

  @action
  void signIn(Function fn, BuildContext context) {
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

    fn(() async {
      var token = await FirebaseMessaging().getToken();
      var _response =
          await APIRequest.loginSurvey(username.text, password.text, token);
      if (_response == null) {
        errorResponse = ErrorResponse(
            error: 'error', message: translation.getText('try_again'));
      }

      if (_response != null) {
        PreferenceUtils.setString(kMobileSurveyUserId, username.text);
        PreferenceUtils.setString(kMobileSurveyUsername, _response.nama);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => HomeContainerUI()),
            (route) => false);
      }
    });
  }
}
