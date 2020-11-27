// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ClientBase on _ClientLogic, Store {
  Computed<NikDataModel> _$modelComputed;

  @override
  NikDataModel get model => (_$modelComputed ??=
          Computed<NikDataModel>(() => super.model, name: '_ClientLogic.model'))
      .value;
  Computed<String> _$nikComputed;

  @override
  String get nik => (_$nikComputed ??=
          Computed<String>(() => super.nik, name: '_ClientLogic.nik'))
      .value;

  final _$datePickerAsyncAction = AsyncAction('_ClientLogic.datePicker');

  @override
  Future<void> datePicker() {
    return _$datePickerAsyncAction.run(() => super.datePicker());
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
  String toString() {
    return '''
model: ${model},
nik: ${nik}
    ''';
  }
}
