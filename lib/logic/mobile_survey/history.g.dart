// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HistoryBase on _HistoryLogic, Store {
  final _$onMapPressAsyncAction = AsyncAction('_HistoryLogic.onMapPress');

  @override
  Future<void> onMapPress() {
    return _$onMapPressAsyncAction.run(() => super.onMapPress());
  }

  final _$_HistoryLogicActionController =
      ActionController(name: '_HistoryLogic');

  @override
  void onSelectedItem() {
    final _$actionInfo = _$_HistoryLogicActionController.startAction(
        name: '_HistoryLogic.onSelectedItem');
    try {
      return super.onSelectedItem();
    } finally {
      _$_HistoryLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
