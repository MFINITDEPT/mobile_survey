import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/boilerplate/new_state.dart';
import 'package:mobilesurvey/ui/home.dart';
import 'package:mobx/mobx.dart';

part 'login.g.dart';

class LoginBase = _LoginLogic with _$LoginBase;

abstract class _LoginLogic with Store {
  final NewState _state;

  _LoginLogic(this._state);

  BuildContext get _context => _state.context;

  @action
  void signIn() {
    FirebaseMessaging().getToken().then((value) {
      print("ini token: $value");
      Navigator.of(_context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => HomeUI()), (route) => false);
    });
  }
}
