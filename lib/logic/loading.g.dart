// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loading.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Loading on _Loading, Store {
  final _$isLoadingAtom = Atom(name: '_Loading.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$canPopLoadingAsyncAction = AsyncAction('_Loading.canPopLoading');

  @override
  Future<bool> canPopLoading() {
    return _$canPopLoadingAsyncAction.run(() => super.canPopLoading());
  }

  final _$processAsyncAction = AsyncAction('_Loading.process');

  @override
  Future<void> process(Function f) {
    return _$processAsyncAction.run(() => super.process(f));
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading}
    ''';
  }
}
