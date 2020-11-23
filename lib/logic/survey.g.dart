// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SurveyBase on _SurveyLogic, Store {
  Computed<NikDataModel> _$modelComputed;

  @override
  NikDataModel get model => (_$modelComputed ??=
          Computed<NikDataModel>(() => super.model, name: '_SurveyLogic.model'))
      .value;
  Computed<String> _$nikComputed;

  @override
  String get nik => (_$nikComputed ??=
          Computed<String>(() => super.nik, name: '_SurveyLogic.nik'))
      .value;

  final _$pagesAtom = Atom(name: '_SurveyLogic.pages');

  @override
  String get pages {
    _$pagesAtom.reportRead();
    return super.pages;
  }

  @override
  set pages(String value) {
    _$pagesAtom.reportWrite(value, super.pages, () {
      super.pages = value;
    });
  }

  final _$_SurveyLogicActionController = ActionController(name: '_SurveyLogic');

  @override
  void onPageChange(int page) {
    final _$actionInfo = _$_SurveyLogicActionController.startAction(
        name: '_SurveyLogic.onPageChange');
    try {
      return super.onPageChange(page);
    } finally {
      _$_SurveyLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  void onImageTap(String title, int index) {
    final _$actionInfo = _$_SurveyLogicActionController.startAction(
        name: '_SurveyLogic.onImageTap');
    try {
      return super.onImageTap(title, index);
    } finally {
      _$_SurveyLogicActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pages: ${pages},
model: ${model},
nik: ${nik}
    ''';
  }
}
