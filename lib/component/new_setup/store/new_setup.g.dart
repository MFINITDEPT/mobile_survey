// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_setup.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewSetupBase on _NewSetupLogic, Store {
  final _$statusAtom = Atom(name: '_NewSetupLogic.status');

  @override
  Status get status {
    _$statusAtom.reportRead();
    return super.status;
  }

  @override
  set status(Status value) {
    _$statusAtom.reportWrite(value, super.status, () {
      super.status = value;
    });
  }

  final _$_NewSetupLogicActionController =
      ActionController(name: '_NewSetupLogic');

  @override
  Status changeStatus(Status newStatus) {
    final _$actionInfo = _$_NewSetupLogicActionController.startAction(
        name: '_NewSetupLogic.changeStatus');
    try {
      return super.changeStatus(newStatus);
    } finally {
      _$_NewSetupLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
status: ${status}
    ''';
  }
}
