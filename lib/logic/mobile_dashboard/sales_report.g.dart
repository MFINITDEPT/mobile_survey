// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_report.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SalesReport on _SalesReport, Store {
  final _$salesReportAtributAtom =
      Atom(name: '_SalesReport.salesReportAtribut');

  @override
  SalesReportAtribut get salesReportAtribut {
    _$salesReportAtributAtom.reportRead();
    return super.salesReportAtribut;
  }

  @override
  set salesReportAtribut(SalesReportAtribut value) {
    _$salesReportAtributAtom.reportWrite(value, super.salesReportAtribut, () {
      super.salesReportAtribut = value;
    });
  }

  final _$goToChooserAsyncAction = AsyncAction('_SalesReport.goToChooser');

  @override
  Future<void> goToChooser(BuildContext context) {
    return _$goToChooserAsyncAction.run(() => super.goToChooser(context));
  }

  @override
  String toString() {
    return '''
salesReportAtribut: ${salesReportAtribut}
    ''';
  }
}
