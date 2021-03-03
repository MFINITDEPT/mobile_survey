// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AssetsBase on _AssetsLogic, Store {
  final _$fileAtom = Atom(name: '_AssetsLogic.file');

  @override
  File get file {
    _$fileAtom.reportRead();
    return super.file;
  }

  @override
  set file(File value) {
    _$fileAtom.reportWrite(value, super.file, () {
      super.file = value;
    });
  }

  final _$_AssetsLogicActionController = ActionController(name: '_AssetsLogic');

  @override
  void takePhoto() {
    final _$actionInfo = _$_AssetsLogicActionController.startAction(
        name: '_AssetsLogic.takePhoto');
    try {
      return super.takePhoto();
    } finally {
      _$_AssetsLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePhoto() {
    final _$actionInfo = _$_AssetsLogicActionController.startAction(
        name: '_AssetsLogic.removePhoto');
    try {
      return super.removePhoto();
    } finally {
      _$_AssetsLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
file: ${file}
    ''';
  }
}
