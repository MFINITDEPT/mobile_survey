// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ClientBase on _ClientLogic, Store {
  final _$datePickerAsyncAction = AsyncAction('_ClientLogic.datePicker');

  @override
  Future<void> datePicker(BuildContext context) {
    return _$datePickerAsyncAction.run(() => super.datePicker(context));
  }

  final _$yearPickerAsyncAction = AsyncAction('_ClientLogic.yearPicker');

  @override
  Future<void> yearPicker(
      BuildContext context, TextEditingController controller) {
    return _$yearPickerAsyncAction
        .run(() => super.yearPicker(context, controller));
  }

  final _$_ClientLogicActionController = ActionController(name: '_ClientLogic');

  @override
  void autoFill(ZipCodeModel item) {
    final _$actionInfo = _$_ClientLogicActionController.startAction(
        name: '_ClientLogic.autoFill');
    try {
      return super.autoFill(item);
    } finally {
      _$_ClientLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool actionFilter(ZipCodeModel item, String query) {
    final _$actionInfo = _$_ClientLogicActionController.startAction(
        name: '_ClientLogic.actionFilter');
    try {
      return super.actionFilter(item, query);
    } finally {
      _$_ClientLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
