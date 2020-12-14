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
  Computed<SearchModel> _$aoComputed;

  @override
  SearchModel get ao => (_$aoComputed ??=
          Computed<SearchModel>(() => super.ao, name: '_ClientLogic.ao'))
      .value;

  final _$_aoAtom = Atom(name: '_ClientLogic._ao');

  @override
  SearchModel get _ao {
    _$_aoAtom.reportRead();
    return super._ao;
  }

  @override
  set _ao(SearchModel value) {
    _$_aoAtom.reportWrite(value, super._ao, () {
      super._ao = value;
    });
  }

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
model: ${model},
nik: ${nik},
ao: ${ao}
    ''';
  }
}
