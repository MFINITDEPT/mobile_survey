import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobilesurvey/component/chooser.dart';
import 'package:mobilesurvey/component/custom_data_table.dart';
import 'package:mobilesurvey/model/mobile_dashboard/branch.dart';
import 'package:mobilesurvey/model/mobile_dashboard/custom_table_atribute.dart';
import 'package:mobilesurvey/model/mobile_dashboard/marketing.dart';
import 'package:mobilesurvey/model/mobile_dashboard/sales.dart';
import 'package:mobilesurvey/utilities/api_request.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/date_utils.dart';
import 'package:mobilesurvey/utilities/shared_preferences_utils.dart';
import 'package:mobilesurvey/utilities/string_utils.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobx/mobx.dart';

part 'sales_report.g.dart';

// ignore: public_member_api_docs
class SalesReport = _SalesReport with _$SalesReport;

abstract class _SalesReport with Store {
  BranchModel _currentBranch;

  @observable
  SalesReportAtribut salesReportAtribut;

  @action
  Future<void> goToChooser(BuildContext context) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CollPlayChooserPage(
                kBranches, translation.getText('choose_branch'))));

    if (result == null) return;
    _currentBranch = result;
    salesReportAtribut = null;
    getData();
  }

  void getData() async {
    if (kBranches.isEmpty) {
      var result =
          await APIRequest.getBranch(PreferenceUtils.getString(kMobileDashboardUserId));
      result.removeWhere((model) => model.cCode == "000");
      if (result != null) kBranches = result;
    }

    if (_currentBranch == null) _currentBranch = kBranches.first;

    var result = await APIRequest.getMarketingData(
        DateUtilities.now(), _currentBranch.cCode);
    if (result == null) return;
    var _marketingReportModel =
        kgetMarketingUnit(result[0], result[1], DateUtilities.now());
    _setData(_marketingReportModel, DateUtilities.now());
  }

  ChartDataAttribut createChartData(List<MarketingData> kpr,
      List<MarketingData> reg, List<MarketingData> exp) {
    var _month = DateUtilities.now().month;

    var _kprData = <MarketingUnit>[];
    var _regData = <MarketingUnit>[];
    var _expData = <MarketingUnit>[];

    var _kprChart = <OrdinalSales>[];
    var _regChart = <OrdinalSales>[];
    var _expChart = <OrdinalSales>[];
    var _totalChart = <OrdinalSales>[];

    if (kpr.isNotEmpty) _kprData = _getChartData(kpr);
    if (reg.isNotEmpty) _regData = _getChartData(reg);
    if (exp.isNotEmpty) _expData = _getChartData(exp);

    for (var i = 11; i >= 0; i--) {
      var title = DateUtilities.convertDateTimeToString(
          DateUtilities.getMonth((_month - i) % 12), format: "MMM");

      _kprChart.add(OrdinalSales(
          title, _kprData.isNotEmpty ? (_kprData[i].unit ?? 0) : 0));

      _regChart.add(OrdinalSales(
          title, _regData.isNotEmpty ? (_regData[i].unit ?? 0) : 0));

      _expChart.add(OrdinalSales(
          title, _expData.isNotEmpty ? (_expData[i].unit ?? 0) : 0));

      _totalChart.add(OrdinalSales(
          title,
          (_kprData.isNotEmpty ? (_kprData[i].unit ?? 0) : 0) +
              (_regData.isNotEmpty ? (_regData[i].unit ?? 0) : 0) +
              (_expData.isNotEmpty ? (_expData[i].unit ?? 0) : 0)));
    }

    var result = ChartDataAttribut(
        expChart: _expChart,
        regChart: _regChart,
        totalChart: _totalChart,
        kprChart: _kprChart);

    return result;
  }

  List<MarketingUnit> _getChartData(List<MarketingData> marketingDatas) {
    var chartData = <MarketingUnit>[];
    for (var i = 0; i < 12; i++) {
      var unit = 0;
      var amount = 0.0;
      var percent = 0.0;

      for (var value in marketingDatas) {
        unit = unit + value.data[i].unit;
        amount = amount + value.data[i].amount;
        percent = percent + value.data[i].percent;
      }

      chartData
          .add(MarketingUnit(unit: unit, amount: amount, percent: percent));
    }

    return chartData;
  }

  List<OrdinalSales> salesData(List<MarketingData> kpr, List<MarketingData> reg,
      List<MarketingData> exp) {
    var _kprData = <MarketingUnit>[];
    var _regData = <MarketingUnit>[];
    var _expData = <MarketingUnit>[];
    var data = <OrdinalSales>[];

    if (kpr.isNotEmpty) _kprData = _getChartData(kpr);
    if (reg.isNotEmpty) _regData = _getChartData(reg);
    if (exp.isNotEmpty) _expData = _getChartData(exp);

    var kprSales = 0;
    var regSales = 0;
    var expSales = 0;

    var kprAmount = 0.0;
    var regAmount = 0.0;
    var expAmount = 0.0;

    for (var value in _kprData) {
      kprSales = kprSales + value.unit;
      kprAmount = kprAmount + value.amount;
    }
    data.add(OrdinalSales('KMG', kprSales, amount: kprAmount));

    for (var value in _regData) {
      regSales = regSales + value.unit;
      regAmount = regAmount + value.amount;
    }
    data.add(OrdinalSales('REG', regSales, amount: regAmount));

    for (var value in _expData) {
      expSales = expSales + value.unit;
      expAmount = expAmount + value.amount;
    }
    data.add(OrdinalSales('EXP', expSales, amount: expAmount));

    return data;
  }

  void _setData(List<MarketingData> data, DateTime date) {
    var month = date.month;

    var _leftContent = <CellProperty>[];
    var _mainContent = <List<CellProperty>>[];
    CellProperty _headerLeftContent;
    var _header = <CustomTableChildren>[];

    var _kprList = <MarketingData>[];
    var _expList = <MarketingData>[];
    var _regList = <MarketingData>[];

    _headerLeftContent = CellProperty("Product Facility");

    for (var i = 0; i < (month); i++) {
      var title = DateUtilities.convertDateTimeToString(
          DateUtilities.getMonth((month - i) % 12), format: "MMM");

      _header.add(CellProperty(
          "Unt ${title} (${date.year})"));
      _header.add(CellProperty(
          "Amnt ${title} (${date.year})"));
    }

    for (var i = 12; i > (month); i--) {
      var title = DateUtilities.convertDateTimeToString(
          DateUtilities.getMonth(i% 12), format: "MMM");

      _header.add(CellProperty(
          "Unt ${title} (${date.year - 1})"));
      _header.add(CellProperty(
          "Amnt ${title} (${date.year - 1})"));
    }

    if (data.isNotEmpty) {
      _mainContent = [];
      var _total = <CellProperty>[];
      var _totalUnit = List<int>(12);
      var _totalAmount = List<double>(12);

      for (var item in data) {
        var a = kEXPCode.firstWhere((e) => e == int.tryParse(item.code),
            orElse: () => null);
        var b = kKPRCode.firstWhere((e) => e == int.tryParse(item.code),
            orElse: () => null);
        var c = kREGCode.firstWhere((e) => e == int.tryParse(item.code),
            orElse: () => null);

        if (a != null) {
          _expList.add(item);
        } else if (b != null) {
          _kprList.add(item);
        } else if (c != null) {
          _regList.add(item);
        }

        _leftContent.add(CellProperty(item.productFacility.toLowerCase()));
        var _amount = <CellProperty>[];
        for (var i = 0; i < item.data.length; i++) {
          _totalUnit[i] = (_totalUnit[i] ?? 0) + item.data[i].unit;
          _totalAmount[i] = (_totalAmount[i] ?? 0) + item.data[i].amount;

          _amount
              // ignore: lines_longer_than_80_chars
              .add(CellProperty(
                  StringUtils.parseString(item.data[i].unit, isUnit: true)));
          // ignore: lines_longer_than_80_chars
          _amount
              .add(CellProperty(StringUtils.parseString(item.data[i].amount)));
        }

        _mainContent.add(_amount);
      }

      _leftContent.add(CellProperty(translation.getText('total'),
          color: Colors.white, isBold: true));
      for (var i = 0; i < _totalUnit.length; i++) {
        // ignore: lines_longer_than_80_chars
        _total.add(CellProperty(
            StringUtils.parseString(_totalUnit[i], isUnit: true),
            color: Colors.white,
            isBold: true));
        _total.add(CellProperty(StringUtils.parseString(_totalAmount[i]),
            color: Colors.white, isBold: true));
      }
      _mainContent.add(_total);
    }

    salesReportAtribut = SalesReportAtribut(
        tableAtribut: CustomTableAttribut(
            cells: _mainContent,
            headerLeftContent: _headerLeftContent,
            leftContent: _leftContent,
            headerColoumn: _header,
            branchName: _currentBranch.cName.toLowerCase() == "all"
                ? "NASIONAL"
                : _currentBranch.cName.toUpperCase()),
        expList: _expList,
        kprList: _kprList,
        regList: _regList);
  }
}
