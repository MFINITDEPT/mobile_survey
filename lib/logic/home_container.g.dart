// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_container.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeContainerBase on _HomeContainerLogic, Store {
  Computed<NikDataModel> _$modelComputed;

  @override
  NikDataModel get model =>
      (_$modelComputed ??= Computed<NikDataModel>(() => super.model,
              name: '_HomeContainerLogic.model'))
          .value;
  Computed<String> _$nikComputed;

  @override
  String get nik => (_$nikComputed ??=
          Computed<String>(() => super.nik, name: '_HomeContainerLogic.nik'))
      .value;

  @override
  String toString() {
    return '''
model: ${model},
nik: ${nik}
    ''';
  }
}