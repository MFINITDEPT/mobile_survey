// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_container.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SurveyContainerBase on _SurveyContainerLogic, Store {
  Computed<NikDataModel> _$nikModelComputed;

  @override
  NikDataModel get nikModel =>
      (_$nikModelComputed ??= Computed<NikDataModel>(() => super.nikModel,
              name: '_SurveyContainerLogic.nikModel'))
          .value;
  Computed<String> _$nikComputed;

  @override
  String get nik => (_$nikComputed ??=
          Computed<String>(() => super.nik, name: '_SurveyContainerLogic.nik'))
      .value;

  final _$modelAtom = Atom(name: '_SurveyContainerLogic.model');

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

  @override
  String toString() {
    return '''
model: ${model},
nikModel: ${nikModel},
nik: ${nik}
    ''';
  }
}
