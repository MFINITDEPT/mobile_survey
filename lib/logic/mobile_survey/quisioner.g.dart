// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quisioner.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$QuisionerBase on _QuisionerLogic, Store {
  Computed<List<QuisionerAnswerModel>> _$quisionerComputed;

  @override
  List<QuisionerAnswerModel> get quisioner => (_$quisionerComputed ??=
          Computed<List<QuisionerAnswerModel>>(() => super.quisioner,
              name: '_QuisionerLogic.quisioner'))
      .value;
  Computed<bool> _$quisionerIsEmptyComputed;

  @override
  bool get quisionerIsEmpty => (_$quisionerIsEmptyComputed ??= Computed<bool>(
          () => super.quisionerIsEmpty,
          name: '_QuisionerLogic.quisionerIsEmpty'))
      .value;

  final _$_quisionerAtom = Atom(name: '_QuisionerLogic._quisioner');

  @override
  ObservableList<QuisionerAnswerModel> get _quisioner {
    _$_quisionerAtom.reportRead();
    return super._quisioner;
  }

  @override
  set _quisioner(ObservableList<QuisionerAnswerModel> value) {
    _$_quisionerAtom.reportWrite(value, super._quisioner, () {
      super._quisioner = value;
    });
  }

  final _$_QuisionerLogicActionController =
      ActionController(name: '_QuisionerLogic');

  @override
  void setQuisioner(ObservableList<dynamic> list) {
    final _$actionInfo = _$_QuisionerLogicActionController.startAction(
        name: '_QuisionerLogic.setQuisioner');
    try {
      return super.setQuisioner(list);
    } finally {
      _$_QuisionerLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelectedValue(Function func, String s, SearchModel model) {
    final _$actionInfo = _$_QuisionerLogicActionController.startAction(
        name: '_QuisionerLogic.onSelectedValue');
    try {
      return super.onSelectedValue(func, s, model);
    } finally {
      _$_QuisionerLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
quisioner: ${quisioner},
quisionerIsEmpty: ${quisionerIsEmpty}
    ''';
  }
}
