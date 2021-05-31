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
  Computed<bool> _$assetResultIsEmptyComputed;

  @override
  bool get assetResultIsEmpty => (_$assetResultIsEmptyComputed ??=
          Computed<bool>(() => super.assetResultIsEmpty,
              name: '_TaskLogic.assetResultIsEmpty'))
      .value;
  Computed<bool> _$documentResultIsEmptyComputed;

  @override
  bool get documentResultIsEmpty => (_$documentResultIsEmptyComputed ??=
          Computed<bool>(() => super.documentResultIsEmpty,
              name: '_TaskLogic.documentResultIsEmpty'))
      .value;
  Computed<bool> _$quisionerIsEmptyComputed;

  @override
  bool get quisionerIsEmpty => (_$quisionerIsEmptyComputed ??= Computed<bool>(
          () => super.quisionerIsEmpty,
          name: '_TaskLogic.quisionerIsEmpty'))
      .value;
  Computed<bool> _$checkAllEmptyComputed;

  @override
  bool get checkAllEmpty =>
      (_$checkAllEmptyComputed ??= Computed<bool>(() => super.checkAllEmpty,
              name: '_TaskLogic.checkAllEmpty'))
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

  final _$assetResultAtom = Atom(name: '_TaskLogic.assetResult');

  @override
  ObservableList<PhotoResult> get assetResult {
    _$assetResultAtom.reportRead();
    return super.assetResult;
  }

  @override
  set assetResult(ObservableList<PhotoResult> value) {
    _$assetResultAtom.reportWrite(value, super.assetResult, () {
      super.assetResult = value;
    });
  }

  final _$documentResultAtom = Atom(name: '_TaskLogic.documentResult');

  @override
  ObservableList<PhotoResult> get documentResult {
    _$documentResultAtom.reportRead();
    return super.documentResult;
  }

  @override
  set documentResult(ObservableList<PhotoResult> value) {
    _$documentResultAtom.reportWrite(value, super.documentResult, () {
      super.documentResult = value;
    });
  }

  final _$quisionerAtom = Atom(name: '_TaskLogic.quisioner');

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
  void setAssetResult(List<PhotoResult> model) {
    final _$actionInfo = _$_TaskLogicActionController.startAction(
        name: '_TaskLogic.setAssetResult');
    try {
      return super.setAssetResult(model);
    } finally {
      _$_TaskLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDocumentResult(List<PhotoResult> model) {
    final _$actionInfo = _$_TaskLogicActionController.startAction(
        name: '_TaskLogic.setDocumentResult');
    try {
      return super.setDocumentResult(model);
    } finally {
      _$_TaskLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setQuisioner(List<QuisionerAnswerModel> model) {
    final _$actionInfo = _$_TaskLogicActionController.startAction(
        name: '_TaskLogic.setQuisioner');
    try {
      return super.setQuisioner(model);
    } finally {
      _$_TaskLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
client: ${client},
assetResult: ${assetResult},
documentResult: ${documentResult},
quisioner: ${quisioner},
clientIsEmpty: ${clientIsEmpty},
assetResultIsEmpty: ${assetResultIsEmpty},
documentResultIsEmpty: ${documentResultIsEmpty},
quisionerIsEmpty: ${quisionerIsEmpty},
checkAllEmpty: ${checkAllEmpty}
    ''';
  }
}
