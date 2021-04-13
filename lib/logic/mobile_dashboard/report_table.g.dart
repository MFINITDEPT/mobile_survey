// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_table.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReportTable on _ReportTable, Store {
  final _$chartDataAtom = Atom(name: '_ReportTable.chartData');

  @override
  List<FlSpotModel> get chartData {
    _$chartDataAtom.reportRead();
    return super.chartData;
  }

  @override
  set chartData(List<FlSpotModel> value) {
    _$chartDataAtom.reportWrite(value, super.chartData, () {
      super.chartData = value;
    });
  }

  final _$tableAttributeAtom = Atom(name: '_ReportTable.tableAttribute');

  @override
  CustomTableAttribut get tableAttribute {
    _$tableAttributeAtom.reportRead();
    return super.tableAttribute;
  }

  @override
  set tableAttribute(CustomTableAttribut value) {
    _$tableAttributeAtom.reportWrite(value, super.tableAttribute, () {
      super.tableAttribute = value;
    });
  }

  final _$chartFilterAtom = Atom(name: '_ReportTable.chartFilter');

  @override
  chooserFilter get chartFilter {
    _$chartFilterAtom.reportRead();
    return super.chartFilter;
  }

  @override
  set chartFilter(chooserFilter value) {
    _$chartFilterAtom.reportWrite(value, super.chartFilter, () {
      super.chartFilter = value;
    });
  }

  final _$dateAtom = Atom(name: '_ReportTable.date');

  @override
  DateTime get date {
    _$dateAtom.reportRead();
    return super.date;
  }

  @override
  set date(DateTime value) {
    _$dateAtom.reportWrite(value, super.date, () {
      super.date = value;
    });
  }

  final _$lastDateAtom = Atom(name: '_ReportTable.lastDate');

  @override
  DateTime get lastDate {
    _$lastDateAtom.reportRead();
    return super.lastDate;
  }

  @override
  set lastDate(DateTime value) {
    _$lastDateAtom.reportWrite(value, super.lastDate, () {
      super.lastDate = value;
    });
  }

  final _$goToChooserAsyncAction = AsyncAction('_ReportTable.goToChooser');

  @override
  Future<void> goToChooser(BuildContext context) {
    return _$goToChooserAsyncAction.run(() => super.goToChooser(context));
  }

  final _$_ReportTableActionController = ActionController(name: '_ReportTable');

  @override
  void changeFilterChart(chooserFilter pickedFilter) {
    final _$actionInfo = _$_ReportTableActionController.startAction(
        name: '_ReportTable.changeFilterChart');
    try {
      return super.changeFilterChart(pickedFilter);
    } finally {
      _$_ReportTableActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getMonth(double value) {
    final _$actionInfo = _$_ReportTableActionController.startAction(
        name: '_ReportTable.getMonth');
    try {
      return super.getMonth(value);
    } finally {
      _$_ReportTableActionController.endAction(_$actionInfo);
    }
  }

  @override
  String getYAxis(double value, double reduceAxis) {
    final _$actionInfo = _$_ReportTableActionController.startAction(
        name: '_ReportTable.getYAxis');
    try {
      return super.getYAxis(value, reduceAxis);
    } finally {
      _$_ReportTableActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
chartData: ${chartData},
tableAttribute: ${tableAttribute},
chartFilter: ${chartFilter},
date: ${date},
lastDate: ${lastDate}
    ''';
  }
}
