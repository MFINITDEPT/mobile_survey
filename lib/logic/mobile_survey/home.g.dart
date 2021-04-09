// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeBase on _HomeLogic, Store {
  final _$onMapPressAsyncAction = AsyncAction('_HomeLogic.onMapPress');

  @override
  Future<void> onMapPress() {
    return _$onMapPressAsyncAction.run(() => super.onMapPress());
  }

  final _$_HomeLogicActionController = ActionController(name: '_HomeLogic');

  @override
  void onSelectedItem(String customerNumber, BuildContext context) {
    final _$actionInfo = _$_HomeLogicActionController.startAction(
        name: '_HomeLogic.onSelectedItem');
    try {
      return super.onSelectedItem(customerNumber, context);
    } finally {
      _$_HomeLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
