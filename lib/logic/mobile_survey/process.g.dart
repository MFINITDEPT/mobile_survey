// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'process.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ProcessBase on _ProcessLogic, Store {
  Computed<bool> _$clientIsEmptyComputed;

  @override
  bool get clientIsEmpty =>
      (_$clientIsEmptyComputed ??= Computed<bool>(() => super.clientIsEmpty,
              name: '_ProcessLogic.clientIsEmpty'))
          .value;

  final _$assetResultsAtom = Atom(name: '_ProcessLogic.assetResults');

  @override
  ObservableList<PhotoResult> get assetResults {
    _$assetResultsAtom.reportRead();
    return super.assetResults;
  }

  @override
  set assetResults(ObservableList<PhotoResult> value) {
    _$assetResultsAtom.reportWrite(value, super.assetResults, () {
      super.assetResults = value;
    });
  }

  final _$documentResultsAtom = Atom(name: '_ProcessLogic.documentResults');

  @override
  ObservableList<PhotoResult> get documentResults {
    _$documentResultsAtom.reportRead();
    return super.documentResults;
  }

  @override
  set documentResults(ObservableList<PhotoResult> value) {
    _$documentResultsAtom.reportWrite(value, super.documentResults, () {
      super.documentResults = value;
    });
  }

  final _$clientAtom = Atom(name: '_ProcessLogic.client');

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

  final _$quisionerAtom = Atom(name: '_ProcessLogic.quisioner');

  @override
  ObservableList<QuisionerAnswerModel> get quisioner {
    _$quisionerAtom.reportRead();
    return super.quisioner;
  }

  @override
  set quisioner(ObservableList<QuisionerAnswerModel> value) {
    _$quisionerAtom.reportWrite(value, super.quisioner, () {
      super.quisioner = value;
    });
  }

  final _$_ProcessLogicActionController =
      ActionController(name: '_ProcessLogic');

  @override
  void setAssetResult(ObservableList<dynamic> list) {
    final _$actionInfo = _$_ProcessLogicActionController.startAction(
        name: '_ProcessLogic.setAssetResult');
    try {
      return super.setAssetResult(list);
    } finally {
      _$_ProcessLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDocumentResult(ObservableList<dynamic> list) {
    final _$actionInfo = _$_ProcessLogicActionController.startAction(
        name: '_ProcessLogic.setDocumentResult');
    try {
      return super.setDocumentResult(list);
    } finally {
      _$_ProcessLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setClient(ObservableList<dynamic> list) {
    final _$actionInfo = _$_ProcessLogicActionController.startAction(
        name: '_ProcessLogic.setClient');
    try {
      return super.setClient(list);
    } finally {
      _$_ProcessLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuisioner(ObservableList<dynamic> list) {
    final _$actionInfo = _$_ProcessLogicActionController.startAction(
        name: '_ProcessLogic.setQuisioner');
    try {
      return super.setQuisioner(list);
    } finally {
      _$_ProcessLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
assetResults: ${assetResults},
documentResults: ${documentResults},
client: ${client},
quisioner: ${quisioner},
clientIsEmpty: ${clientIsEmpty}
    ''';
  }
}
