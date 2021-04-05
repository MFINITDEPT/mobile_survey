import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/ui/home_container.dart';
import 'package:mobx/mobx.dart';

part 'login.g.dart';

/// A LoginBase logic.
class LoginBase = _LoginLogic with _$LoginBase;

abstract class _LoginLogic with Store {
  @action
  void signIn(Function fn, BuildContext context) {
    fn(() async {
      var token = await FirebaseMessaging().getToken();
      print(token);
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) =>
            HomeContainerUI()), (route) => false);
  }
}
