// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'client.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ClientBase on _ClientLogic, Store {
  Computed<bool> _$clientIsEmptyComputed;

  @override
  bool get clientIsEmpty =>
      (_$clientIsEmptyComputed ??= Computed<bool>(() => super.clientIsEmpty,
              name: '_ClientLogic.clientIsEmpty'))
          .value;

  final _$clientAtom = Atom(name: '_ClientLogic.client');

  @override
  ObservableList<ClientControllerModel> get client {
    _$clientAtom.reportRead();
    return super.client;
  }

  @override
  set client(ObservableList<ClientControllerModel> value) {
    _$clientAtom.reportWrite(value, super.client, () {
      super.client = value;
    });
  }

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
  void setClient(ObservableList<dynamic> list) {
    final _$actionInfo = _$_ClientLogicActionController.startAction(
        name: '_ClientLogic.setClient');
    try {
      return super.setClient(list);
    } finally {
      _$_ClientLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  void autoFill(ZipCodeItem item) {
    final _$actionInfo = _$_ClientLogicActionController.startAction(
        name: '_ClientLogic.autoFill');
    try {
      return super.autoFill(item);
    } finally {
      _$_ClientLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool actionFilter(ZipCodeItem item, String query) {
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
client: ${client},
clientIsEmpty: ${clientIsEmpty}
    ''';
  }
}
