// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Login on _Login, Store {
  final _$errorResponseAtom = Atom(name: '_Login.errorResponse');

  @override
  ErrorResponse get errorResponse {
    _$errorResponseAtom.reportRead();
    return super.errorResponse;
  }

  @override
  set errorResponse(ErrorResponse value) {
    _$errorResponseAtom.reportWrite(value, super.errorResponse, () {
      super.errorResponse = value;
    });
  }

  final _$_LoginActionController = ActionController(name: '_Login');

  @override
  void submit(BuildContext context, Function fc) {
    final _$actionInfo =
        _$_LoginActionController.startAction(name: '_Login.submit');
    try {
      return super.submit(context, fc);
    } finally {
      _$_LoginActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
errorResponse: ${errorResponse}
    ''';
  }
}
