// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quisioner.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuisionerBase on _QuisionerLogic, Store {
  final _$modelAtom = Atom(name: '_QuisionerLogic.model');

  @override
  List<QuisionerModel> get model {
    _$modelAtom.reportRead();
    return super.model;
  }

  @override
  set model(List<QuisionerModel> value) {
    _$modelAtom.reportWrite(value, super.model, () {
      super.model = value;
    });
  }

  final _$_QuisionerLogicActionController =
      ActionController(name: '_QuisionerLogic');

  @override
  void getData() {
    final _$actionInfo = _$_QuisionerLogicActionController.startAction(
        name: '_QuisionerLogic.getData');
    try {
      return super.getData();
    } finally {
      _$_QuisionerLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
model: ${model}
    ''';
  }
}
