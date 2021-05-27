// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TaskBase on _TaskLogic, Store {
  Computed<bool> _$clientIsEmptyComputed;

  @override
  bool get clientIsEmpty =>
      (_$clientIsEmptyComputed ??= Computed<bool>(() => super.clientIsEmpty,
              name: '_TaskLogic.clientIsEmpty'))
          .value;

  final _$clientAtom = Atom(name: '_TaskLogic.client');

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

  final _$_TaskLogicActionController = ActionController(name: '_TaskLogic');

  @override
  void setClient(List<ClientControllerModel> model) {
    final _$actionInfo =
        _$_TaskLogicActionController.startAction(name: '_TaskLogic.setClient');
    try {
      return super.setClient(model);
    } finally {
      _$_TaskLogicActionController.endAction(_$actionInfo);
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
