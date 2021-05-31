// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AssetsBase on _AssetsLogic, Store {
  Computed<ObservableList<PhotoResult>> _$resultsComputed;

  @override
  ObservableList<PhotoResult> get results => (_$resultsComputed ??=
          Computed<ObservableList<PhotoResult>>(() => super.results,
              name: '_AssetsLogic.results'))
      .value;

  final _$_resultsAtom = Atom(name: '_AssetsLogic._results');

  @override
  ObservableList<PhotoResult> get _results {
    _$_resultsAtom.reportRead();
    return super._results;
  }

  @override
  set _results(ObservableList<PhotoResult> value) {
    _$_resultsAtom.reportWrite(value, super._results, () {
      super._results = value;
    });
  }

  final _$browseFileAsyncAction = AsyncAction('_AssetsLogic.browseFile');

  @override
  Future<void> browseFile(
      FormUploadItem form, int index, Function fc, BuildContext context) {
    return _$browseFileAsyncAction
        .run(() => super.browseFile(form, index, fc, context));
  }

  final _$_AssetsLogicActionController = ActionController(name: '_AssetsLogic');

  @override
  void setAssetResult(ObservableList<dynamic> list) {
    final _$actionInfo = _$_AssetsLogicActionController.startAction(
        name: '_AssetsLogic.setAssetResult');
    try {
      return super.setAssetResult(list);
    } finally {
      _$_AssetsLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePhoto(PhotoResult photo, int index, Function fc) {
    final _$actionInfo = _$_AssetsLogicActionController.startAction(
        name: '_AssetsLogic.removePhoto');
    try {
      return super.removePhoto(photo, index, fc);
    } finally {
      _$_AssetsLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  void openFile(String fileAttach) {
    final _$actionInfo = _$_AssetsLogicActionController.startAction(
        name: '_AssetsLogic.openFile');
    try {
      return super.openFile(fileAttach);
    } finally {
      _$_AssetsLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
results: ${results}
    ''';
  }
}
