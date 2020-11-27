// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quisioner.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuisionerBase on _QuisionerLogic, Store {
  Computed<List<QuisionerModel>> _$modelComputed;

  @override
  List<QuisionerModel> get model =>
      (_$modelComputed ??= Computed<List<QuisionerModel>>(() => super.model,
              name: '_QuisionerLogic.model'))
          .value;

  final _$_newmodelAtom = Atom(name: '_QuisionerLogic._newmodel');

  @override
  List<QuisionerModel> get _newmodel {
    _$_newmodelAtom.reportRead();
    return super._newmodel;
  }

  @override
  set _newmodel(List<QuisionerModel> value) {
    _$_newmodelAtom.reportWrite(value, super._newmodel, () {
      super._newmodel = value;
    });
  }

  @override
  String toString() {
    return '''
model: ${model}
    ''';
  }
}
