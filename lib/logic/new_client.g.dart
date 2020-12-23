// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_client.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewClient on _NewClientBase, Store {
  final _$_modelAtom = Atom(name: '_NewClientBase._model');

  @override
  NikDataModel get _model {
    _$_modelAtom.reportRead();
    return super._model;
  }

  @override
  set _model(NikDataModel value) {
    _$_modelAtom.reportWrite(value, super._model, () {
      super._model = value;
    });
  }

  final _$aoAtom = Atom(name: '_NewClientBase.ao');

  @override
  SearchModel get ao {
    _$aoAtom.reportRead();
    return super.ao;
  }

  @override
  set ao(SearchModel value) {
    _$aoAtom.reportWrite(value, super.ao, () {
      super.ao = value;
    });
  }

  final _$datePickerAsyncAction = AsyncAction('_NewClientBase.datePicker');

  @override
  Future<void> datePicker(TextEditingController controller) {
    return _$datePickerAsyncAction.run(() => super.datePicker(controller));
  }

  final _$_NewClientBaseActionController =
      ActionController(name: '_NewClientBase');

  @override
  void autoFill(ZipCodeModel item) {
    final _$actionInfo = _$_NewClientBaseActionController.startAction(
        name: '_NewClientBase.autoFill');
    try {
      return super.autoFill(item);
    } finally {
      _$_NewClientBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  bool actionFilter(ZipCodeModel item, String query) {
    final _$actionInfo = _$_NewClientBaseActionController.startAction(
        name: '_NewClientBase.actionFilter');
    try {
      return super.actionFilter(item, query);
    } finally {
      _$_NewClientBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onSelected(String selected) {
    final _$actionInfo = _$_NewClientBaseActionController.startAction(
        name: '_NewClientBase.onSelected');
    try {
      return super.onSelected(selected);
    } finally {
      _$_NewClientBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
ao: ${ao}
    ''';
  }
}
