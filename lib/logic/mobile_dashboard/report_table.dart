import 'package:basic_components/components/adv_date_picker.dart';
import 'package:date_utils/date_utils.dart' as utils;
import 'package:flutter/material.dart';
import 'package:mobilesurvey/component/chooser.dart';
import 'package:mobilesurvey/component/custom_data_table.dart';
import 'package:mobilesurvey/model/mobile_dashboard/branch.dart';
import 'package:mobilesurvey/model/mobile_dashboard/collection.dart';
import 'package:mobilesurvey/model/mobile_dashboard/custom_table_atribute.dart';
import 'package:mobilesurvey/model/mobile_dashboard/flspot.dart';
import 'package:mobilesurvey/model/mobile_dashboard/report_chart.dart';
import 'package:mobilesurvey/utilities/api_request.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/date_utils.dart';
import 'package:mobilesurvey/utilities/enum.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/shared_preferences_utils.dart';
import 'package:mobilesurvey/utilities/string_utils.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobx/mobx.dart';

part 'report_table.g.dart';

class ReportTable = _ReportTable with _$ReportTable;

abstract class _ReportTable with Store {
  bool isKPR;
  BranchModel _currentBranch;
  ReportChartAttribute _reportChartData;
  DateTime _oneDayBefore = DateTime(DateUtilities.now().year,
      DateUtilities.now().month, DateUtilities.now().day - 1);
  var _dateCtrl = AdvDatePickerController(
      maxDate: DateUtilities.now(), date: DateUtilities.now());
  AdvDatePickerController _lastMonthCtrl = AdvDatePickerController(
      maxDate: DateTime(DateUtilities.now().year, DateUtilities.now().month,
          DateUtilities.now().day - 1),
      date: DateUtilities.getNowAndOneMonthBefore(DateUtilities.now())[1]);

  var filterOptions = {
    "Current": chooserFilter.current,
    "Portofolio": chooserFilter.portofolio,
    "Bucket 1-30": chooserFilter.bucket1_30,
    "Bucket 31-60": chooserFilter.bucket31_60,
    "Bucket 61-90": chooserFilter.bucket61_90,
    "Bucket 91-120": chooserFilter.bucket91_120,
    "Bucket 121-150": chooserFilter.bucket121_150,
    "Bucket 151-180": chooserFilter.bucket151_180,
    "Bucket 181-270": chooserFilter.bucket181_270,
    "Bucket Up 270": chooserFilter.bucketUp270,
  };

  @observable
  List<FlSpotModel> chartData = <FlSpotModel>[];

  @observable
  CustomTableAttribut tableAttribute;

  @observable
  chooserFilter chartFilter = chooserFilter.current;

  @observable
  DateTime date = DateUtilities.now();

  @observable
  DateTime lastDate =
      DateUtilities.getNowAndOneMonthBefore(DateUtilities.now())[1];

  @action
  Future<void> goToChooser(BuildContext context) async {
    var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => CollPlayChooserPage(
                kBranches, translation.getText('choose_branch'))));

    if (result == null) return;
    _currentBranch = result;
    _reset();
  }

  @action
  void changeFilterChart(chooserFilter pickedFilter) {
    chartFilter = pickedFilter;
    _filterChartData(_reportChartData, chartFilter);
  }

  @action
  String getMonth(double value) {
    switch (value.toInt()) {
      case 1:
        return 'JAN';
      case 2:
        return 'FEB';
      case 3:
        return 'MAR';
      case 4:
        return 'APR';
      case 5:
        return 'MAY';
      case 6:
        return 'JUN';
      case 7:
        return 'JUL';
      case 8:
        return 'AUG';
      case 9:
        return 'SEP';
      case 10:
        return 'OCT';
      case 11:
        return 'NOV';
      case 12:
        return 'DEC';
    }
    return '';
  }

  @action
  String getYAxis(double value, double reduceAxis) {
    //* get dynamic titles by value and dynamic maxAxis
    // return value.toInt() % 7 == 0 ? value.toInt().toString() : '';

    //* get fixed titles by value and maxAxis
    switch (value.toInt()) {
      case 0:
        return '0';
      case 1:
        return (reduceAxis * 0.25).toStringAsFixed(2);
      case 2:
        return (reduceAxis * 0.5).toStringAsFixed(2);
      case 3:
        return (reduceAxis * 0.75).toStringAsFixed(2);
      case 4:
        return (reduceAxis).toStringAsFixed(2);
      case 5:
        return (reduceAxis * 1.25).toStringAsFixed(2);
      default:
        return '';
    }
  }

  void _reset() {
    chartData = null;
    tableAttribute = null;
    getChartData();
    getTableData();
  }

  void onChangeDate(BuildContext context) async {
    var _now = <DateTime>[_dateCtrl.date];
    var _selectedDate = await AdvDatePicker.pickDate(context,
        title: translation.getText('pick_date'),
        dates: _now,
        maxDate: DateTime.now(),
        selectionType: SelectionType.single);
    if (_selectedDate == null) return;
    if (_selectedDate.isNotEmpty) {
      date = _selectedDate[0];
      _dateCtrl.date = date;
      lastDate = DateUtilities.getNowAndOneMonthBefore(date)[1];
      _oneDayBefore = DateTime(date.year, date.month, date.day - 1);
      _lastMonthCtrl.date = lastDate;
      _reset();
    }
  }

  void onChangeBeforeDate(BuildContext context) async {
    var _now = <DateTime>[_lastMonthCtrl.date];
    var _selectedDate = await AdvDatePicker.pickDate(context,
        title: translation.getText('pick_date'),
        dates: _now,
        maxDate: _oneDayBefore,
        selectionType: SelectionType.single);
    if (_selectedDate == null) return;
    if (_selectedDate.isNotEmpty) {
      lastDate = _selectedDate[0];
      _lastMonthCtrl.date = lastDate;
      _reset();
    }
  }

  void getChartData() async {
    if (kBranches.isEmpty) {
      var _branches = await APIRequest.getBranch(
          PreferenceUtils.getString(kMobileDashboardUserId));
      _branches.removeWhere((model) => model.cCode == "000");

      if (_branches != null) kBranches = _branches;
    }

    if (_currentBranch == null) _currentBranch = kBranches.first;

    var result = await APIRequest.getReportChartData(
        DateUtilities.now(),
        utils.DateUtils.isLastDayOfMonth(DateUtilities.now()),
        _currentBranch.cCode,
        isKPR);

    if (result == null) return;

    var currentData = <FlSpotModel>[];
    var portofolioData = <FlSpotModel>[];
    var bucket1_30Data = <FlSpotModel>[];
    var bucket31_60Data = <FlSpotModel>[];
    var bucket61_90Data = <FlSpotModel>[];
    var bucket91_120Data = <FlSpotModel>[];
    var bucket121_150Data = <FlSpotModel>[];
    var bucket151_180Data = <FlSpotModel>[];
    var bucket181_270Data = <FlSpotModel>[];
    var bucketUp270Data = <FlSpotModel>[];

    for (int i = 0; i < result.length; i++) {
      // process with fl_chart packages
      currentData.add(
          FlSpotModel(result[i].bulan.toDouble(), result[i].currentAmount));
      portofolioData.add(
          FlSpotModel(result[i].bulan.toDouble(), result[i].portofolioAmount));
      bucket1_30Data.add(
          FlSpotModel(result[i].bulan.toDouble(), result[i].bucket1_30Amount));
      bucket31_60Data.add(
          FlSpotModel(result[i].bulan.toDouble(), result[i].bucket31_60Amount));
      bucket61_90Data.add(
          FlSpotModel(result[i].bulan.toDouble(), result[i].bucket61_90Amount));
      bucket91_120Data.add(FlSpotModel(
          result[i].bulan.toDouble(), result[i].bucket91_120Amount));
      bucket121_150Data.add(FlSpotModel(
          result[i].bulan.toDouble(), result[i].bucket121_150Amount));
      bucket151_180Data.add(FlSpotModel(
          result[i].bulan.toDouble(), result[i].bucket151_180Amount));
      bucket181_270Data.add(FlSpotModel(
          result[i].bulan.toDouble(), result[i].bucket181_270Amount));
      bucketUp270Data.add(
          FlSpotModel(result[i].bulan.toDouble(), result[i].bucketUp270Amount));
    }

    _reportChartData = ReportChartAttribute(
      current: currentData,
      portofolio: portofolioData,
      bucket1_30: bucket1_30Data,
      bucket31_60: bucket31_60Data,
      bucket61_90: bucket61_90Data,
      bucket91_120: bucket91_120Data,
      bucket121_150: bucket121_150Data,
      bucket151_180: bucket151_180Data,
      bucket181_270: bucket181_270Data,
      bucketUp270: bucketUp270Data,
    );

    _filterChartData(_reportChartData, chartFilter);
  }

  void _filterChartData(ReportChartAttribute data, chooserFilter filter) {
    List<FlSpotModel> _filteredData = [];

    switch (filter) {
      case chooserFilter.portofolio:
        _filteredData = data.portofolio;
        break;
      case chooserFilter.bucket1_30:
        _filteredData = data.bucket1_30;
        break;
      case chooserFilter.bucket31_60:
        _filteredData = data.bucket31_60;
        break;
      case chooserFilter.bucket61_90:
        _filteredData = data.bucket61_90;
        break;
      case chooserFilter.bucket91_120:
        _filteredData = data.bucket91_120;
        break;
      case chooserFilter.bucket121_150:
        _filteredData = data.bucket121_150;
        break;
      case chooserFilter.bucket151_180:
        _filteredData = data.bucket151_180;
        break;
      case chooserFilter.bucket181_270:
        _filteredData = data.bucket181_270;
        break;
      case chooserFilter.bucketUp270:
        _filteredData = data.bucketUp270;
        break;
      default:
        _filteredData = data.current;
    }

    chartData = _filteredData;
  }

  void getTableData() async {
    if (kBranches.isEmpty) {
      var _branches = await APIRequest.getBranch(
          PreferenceUtils.getString(kMobileDashboardUserId));
      _branches.removeWhere((model) => model.cCode == "000");

      if (_branches != null) kBranches = _branches;
    }

    if (_currentBranch == null) _currentBranch = kBranches.first;
    var result = await APIRequest.getDataCollection(
        date, lastDate, _currentBranch.cCode, isKPR);

    _setData(result);
  }

  void _setData(CollectionModel data) {
    var _leftContent = <CellProperty>[];
    var _mainContent = <List<CellProperty>>[];
    CellProperty _headerLeftContent;
    var _header = <CustomTableChildren>[];

    if (data != null) {
      _leftContent = [
        CellProperty("00. Current", color: Palette.yellow),
        CellProperty("01. 1-30"),
        CellProperty("02. 31-60"),
        CellProperty("03. 61-90"),
        CellProperty("04. 91-120"),
        CellProperty("05. 121-150"),
        CellProperty("06. 151-180"),
        CellProperty("07. 181-270"),
        CellProperty("08. > 270"),
        CellProperty("TOD"),
        CellProperty("Portofolio", color: Palette.portofolio),
        CellProperty("BAL 30 UP"),
        CellProperty("BAL 60 UP"),
        CellProperty("NPL 90 UP"),
        /*  CellProperty("FLOW TO 1-30"),
      CellProperty("FLOW TO 31-60"),
      CellProperty("FLOW TO 61-90"),
      CellProperty("FLOW TO 91-120"),
      CellProperty("FLOW TO 121-150"),
      CellProperty("FLOW TO 150 UP"),*/
        CellProperty("ACCOUNT WO")
      ];

      _headerLeftContent = CellProperty("Bucket");

      _header = [
        ColumnTable(children: [
          CellProperty(DateUtilities.convertDateTimeToString(lastDate,
              format: 'dd-MMM-yyyy')),
          RowTable(children: [
            CellProperty("Unit"),
            CellProperty("OS Pokok"),
            CellProperty("%"),
          ]),
        ]),
        ColumnTable(children: [
          CellProperty(DateUtilities.convertDateTimeToString(date,
              format: 'dd-MMM-yyyy')),
          RowTable(children: [
            CellProperty("Unit"),
            CellProperty("OS Pokok"),
            CellProperty("%"),
          ]),
        ]),
        ColumnTable(children: [
          CellProperty(
              "${DateUtilities.convertDateTimeToString(lastDate, format: 'dd-MMM-yyyy')}"
              " vs "
              "${DateUtilities.convertDateTimeToString(date, format: 'dd-MMM-yyyy')}"),
          RowTable(children: [
            CellProperty("Unit"),
            CellProperty("OS Pokok"),
            CellProperty("%"),
          ]),
        ]),
      ];

      _mainContent = [
        [
          CellProperty(
              StringUtils.parseString(data.lastCurrentCount, isUnit: true),
              color: Palette.yellow),
          CellProperty(StringUtils.parseString(data.lastCurrentAmount),
              color: Palette.yellow),
          CellProperty("${StringUtils.parseString(data.lastCurrentPerc)} %",
              color: Palette.yellow),
          CellProperty(StringUtils.parseString(data.currentCount, isUnit: true),
              color: Palette.yellow),
          CellProperty(StringUtils.parseString(data.currentAmount),
              color: Palette.yellow),
          CellProperty("${StringUtils.parseString(data.currentPerc)} %",
              color: Palette.yellow),
          CellProperty(
              StringUtils.parseString(data.currentDiffCount, isUnit: true),
              color: data.currentDiffCount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(StringUtils.parseString(data.currentDiffAmount),
              color: data.currentDiffAmount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty("${StringUtils.parseString(data.currentDiffPerc)} %",
              color: data.currentDiffPerc.isNegative
                  ? Palette.red
                  : Palette.green),
        ],
        [
          CellProperty(
              StringUtils.parseString(data.lastBucket1_30Count, isUnit: true)),
          CellProperty(StringUtils.parseString(data.lastBucket1_30Amount)),
          CellProperty("${StringUtils.parseString(data.lastBucket1_30Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket1_30Count, isUnit: true)),
          CellProperty(StringUtils.parseString(data.bucket1_30Amount)),
          CellProperty("${StringUtils.parseString(data.bucket1_30Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket1_30DiffCount, isUnit: true),
              color: !data.bucket1_30DiffCount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(StringUtils.parseString(data.bucket1_30DiffAmount),
              color: !data.bucket1_30DiffAmount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty("${StringUtils.parseString(data.bucket1_30DiffPerc)} %",
              color: !data.bucket1_30DiffPerc.isNegative
                  ? Palette.red
                  : Palette.green),
        ],
        [
          CellProperty(
              StringUtils.parseString(data.lastBucket31_60Count, isUnit: true)),
          CellProperty(StringUtils.parseString(data.lastBucket31_60Amount)),
          CellProperty(
              "${StringUtils.parseString(data.lastBucket31_60Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket31_60Count, isUnit: true)),
          CellProperty(StringUtils.parseString(data.bucket31_60Amount)),
          CellProperty("${StringUtils.parseString(data.bucket31_60Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket31_60DiffCount, isUnit: true),
              color: !data.bucket31_60DiffCount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(StringUtils.parseString(data.bucket31_60DiffAmount),
              color: !data.bucket31_60DiffAmount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty("${StringUtils.parseString(data.bucket31_60DiffPerc)} %",
              color: !data.bucket31_60DiffPerc.isNegative
                  ? Palette.red
                  : Palette.green),
        ],
        [
          CellProperty(
              StringUtils.parseString(data.lastBucket61_90Count, isUnit: true)),
          CellProperty(StringUtils.parseString(data.lastBucket61_90Amount)),
          CellProperty(
              "${StringUtils.parseString(data.lastBucket61_90Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket61_90Count, isUnit: true)),
          CellProperty(StringUtils.parseString(data.bucket61_90Amount)),
          CellProperty("${StringUtils.parseString(data.bucket61_90Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket61_90DiffCount, isUnit: true),
              color: !data.bucket61_90DiffCount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(StringUtils.parseString(data.bucket61_90DiffAmount),
              color: !data.bucket61_90DiffAmount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty("${StringUtils.parseString(data.bucket61_90DiffPerc)} %",
              color: !data.bucket61_90DiffPerc.isNegative
                  ? Palette.red
                  : Palette.green),
        ],
        [
          CellProperty(StringUtils.parseString(data.lastBucket91_120Count,
              isUnit: true)),
          CellProperty(StringUtils.parseString(data.lastBucket91_120Amount)),
          CellProperty(
              "${StringUtils.parseString(data.lastBucket91_120Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket91_120Count, isUnit: true)),
          CellProperty(StringUtils.parseString(data.bucket91_120Amount)),
          CellProperty("${StringUtils.parseString(data.bucket91_120Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket91_120DiffCount, isUnit: true),
              color: !data.bucket91_120DiffCount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(StringUtils.parseString(data.bucket91_120DiffAmount),
              color: !data.bucket91_120DiffAmount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(
              "${StringUtils.parseString(data.bucket91_120DiffPerc)} %",
              color: !data.bucket91_120DiffPerc.isNegative
                  ? Palette.red
                  : Palette.green),
        ],
        [
          CellProperty(StringUtils.parseString(data.lastBucket121_150Count,
              isUnit: true)),
          CellProperty(StringUtils.parseString(data.lastBucket121_150Amount)),
          CellProperty(
              "${StringUtils.parseString(data.lastBucket121_150Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket121_150Count, isUnit: true)),
          CellProperty(StringUtils.parseString(data.bucket121_150Amount)),
          CellProperty("${StringUtils.parseString(data.bucket121_150Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket121_150DiffCount,
                  isUnit: true),
              color: !data.bucket121_150DiffCount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(StringUtils.parseString(data.bucket121_150DiffAmount),
              color: !data.bucket121_150DiffAmount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(
              "${StringUtils.parseString(data.bucket121_150DiffPerc)} %",
              color: !data.bucket121_150DiffPerc.isNegative
                  ? Palette.red
                  : Palette.green),
        ],
        [
          CellProperty(StringUtils.parseString(data.lastBucket151_180Count,
              isUnit: true)),
          CellProperty(StringUtils.parseString(data.lastBucket151_180Amount)),
          CellProperty(
              "${StringUtils.parseString(data.lastBucket151_180Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket151_180Count, isUnit: true)),
          CellProperty(StringUtils.parseString(data.bucket151_180Amount)),
          CellProperty("${StringUtils.parseString(data.bucket151_180Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket151_180DiffCount,
                  isUnit: true),
              color: !data.bucket151_180DiffCount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(StringUtils.parseString(data.bucket151_180DiffAmount),
              color: !data.bucket151_180DiffAmount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(
              "${StringUtils.parseString(data.bucket151_180DiffPerc)} %",
              color: !data.bucket151_180DiffPerc.isNegative
                  ? Palette.red
                  : Palette.green),
        ],
        [
          CellProperty(StringUtils.parseString(data.lastBucket181_270Count,
              isUnit: true)),
          CellProperty(StringUtils.parseString(data.lastBucket181_270Amount)),
          CellProperty(
              "${StringUtils.parseString(data.lastBucket181_270Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket181_270Count, isUnit: true)),
          CellProperty(StringUtils.parseString(data.bucket181_270Amount)),
          CellProperty("${StringUtils.parseString(data.bucket181_270Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucket181_270DiffCount,
                  isUnit: true),
              color: !data.bucket181_270DiffCount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(StringUtils.parseString(data.bucket181_270DiffAmount),
              color: !data.bucket181_270DiffAmount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(
              "${StringUtils.parseString(data.bucket181_270DiffPerc)} %",
              color: !data.bucket181_270DiffPerc.isNegative
                  ? Palette.red
                  : Palette.green),
        ],
        [
          CellProperty(StringUtils.parseString(data.lastBucketUpTo270Count,
              isUnit: true)),
          CellProperty(StringUtils.parseString(data.lastBucketUpTo270Amount)),
          CellProperty(
              "${StringUtils.parseString(data.lastBucketUpTo270Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucketUpTo270Count, isUnit: true)),
          CellProperty(StringUtils.parseString(data.bucketUpTo270Amount)),
          CellProperty("${StringUtils.parseString(data.bucketUpTo270Perc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucketUpTo270DiffCount,
                  isUnit: true),
              color: !data.bucketUpTo270DiffCount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(StringUtils.parseString(data.bucketUpTo270DiffAmount),
              color: !data.bucketUpTo270DiffAmount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(
              "${StringUtils.parseString(data.bucketUpTo270DiffPerc)} %",
              color: !data.bucketUpTo270DiffPerc.isNegative
                  ? Palette.red
                  : Palette.green),
        ],
        [
          CellProperty(
              StringUtils.parseString(data.todLastBucketCount, isUnit: true)),
          CellProperty(StringUtils.parseString(data.todLastBucketAmount)),
          CellProperty("${StringUtils.parseString(data.todLastBucketPerc)} %"),
          CellProperty(StringUtils.parseString(data.todCount, isUnit: true)),
          CellProperty(StringUtils.parseString(data.todAmount)),
          CellProperty("${StringUtils.parseString(data.todPerc)} %"),
          CellProperty(StringUtils.parseString(data.todDiffCount, isUnit: true),
              color:
                  !data.todDiffCount.isNegative ? Palette.red : Palette.green),
          CellProperty(StringUtils.parseString(data.todDiffAmount),
              color:
                  !data.todDiffAmount.isNegative ? Palette.red : Palette.green),
          CellProperty("${StringUtils.parseString(data.todDiffPerc)} %",
              color:
                  !data.todDiffPerc.isNegative ? Palette.red : Palette.green),
        ],
        [
          CellProperty(
              StringUtils.parseString(data.lastPortofolioCount, isUnit: true),
              color: Palette.portofolio),
          CellProperty(StringUtils.parseString(data.lastPortofolioAmount),
              color: Palette.portofolio),
          CellProperty(
              "${StringUtils.parseString(data.lastBucketPortofolioPerc)} %",
              color: Palette.portofolio),
          CellProperty(
              StringUtils.parseString(data.portofolioCount, isUnit: true),
              color: Palette.portofolio),
          CellProperty(StringUtils.parseString(data.portofolioAmount),
              color: Palette.portofolio),
          CellProperty(
              "${StringUtils.parseString(data.bucketPortofolioPerc)} %",
              color: Palette.portofolio),
          CellProperty(
              StringUtils.parseString(data.portofolioCountLastDiff,
                  isUnit: true),
              color: Palette.portofolio),
          CellProperty(StringUtils.parseString(data.portofolioAmountDiff),
              color: Palette.portofolio),
          CellProperty(
              "${StringUtils.parseString(data.bucketPortofolioDiffPerc)} %",
              color: Palette.portofolio),
        ],
        [
          CellProperty(StringUtils.parseString(data.bal30upLastBucketCount,
              isUnit: true)),
          CellProperty(StringUtils.parseString(data.bal30upLastBucketAmount)),
          CellProperty(
              "${StringUtils.parseString(data.bal30upLastBucketPerc)} %"),
          CellProperty(
              StringUtils.parseString(data.bal30upBucketCount, isUnit: true)),
          CellProperty(StringUtils.parseString(data.bal30upBucketAmount)),
          CellProperty("${StringUtils.parseString(data.bal30upBucketPerc)} %"),
          CellProperty(
              StringUtils.parseString(data.bal30upBucketDiffCount,
                  isUnit: true),
              color: !data.bal30upBucketDiffCount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(StringUtils.parseString(data.bal30upBucketDiffAmount),
              color: !data.bal30upBucketDiffAmount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(
              "${StringUtils.parseString(data.bal30upBucketDiffPerc)} %",
              color: !data.bal30upBucketDiffPerc.isNegative
                  ? Palette.red
                  : Palette.green),
        ],
        [
          CellProperty(StringUtils.parseString(data.bal60upLastBucketCount,
              isUnit: true)),
          CellProperty(StringUtils.parseString(data.bal60upLastBucketAmount)),
          CellProperty(
              "${StringUtils.parseString(data.bal60upLastBucketPerc)} %"),
          CellProperty(
              StringUtils.parseString(data.bal60upBucketCount, isUnit: true)),
          CellProperty(StringUtils.parseString(data.bal60upBucketAmount)),
          CellProperty("${StringUtils.parseString(data.bal60upBucketPerc)} %"),
          CellProperty(
              StringUtils.parseString(data.bal60upBucketDiffCount,
                  isUnit: true),
              color: !data.bal60upBucketDiffCount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(StringUtils.parseString(data.bal60upBucketDiffAmount),
              color: !data.bal60upBucketDiffAmount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(
              "${StringUtils.parseString(data.bal60upBucketDiffPerc)} %",
              color: !data.bal60upBucketDiffPerc.isNegative
                  ? Palette.red
                  : Palette.green),
        ],
        [
          CellProperty(StringUtils.parseString(data.npl90upLastBucketCount,
              isUnit: true)),
          CellProperty(StringUtils.parseString(data.npl90upLastBucketAmount)),
          CellProperty(
              "${StringUtils.parseString(data.npl90upLastBucketPerc)} %"),
          CellProperty(
              StringUtils.parseString(data.npl90upBucketCount, isUnit: true)),
          CellProperty(StringUtils.parseString(data.npl90upBucketAmount)),
          CellProperty("${StringUtils.parseString(data.npl90upBucketPerc)} %"),
          CellProperty(
              StringUtils.parseString(data.npl90upBucketDiffCount,
                  isUnit: true),
              color: !data.npl90upBucketDiffCount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(StringUtils.parseString(data.npl90upBucketDiffAmount),
              color: !data.npl90upBucketDiffAmount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(
              "${StringUtils.parseString(data.npl90upBucketDiffPerc)} %",
              color: !data.npl90upBucketDiffPerc.isNegative
                  ? Palette.red
                  : Palette.green),
        ],
        [
          CellProperty(
              StringUtils.parseString(data.lastBucketWOCount, isUnit: true)),
          CellProperty(StringUtils.parseString(data.lastBucketWOAmount)),
          CellProperty("${StringUtils.parseString(data.lastBucketWOPerc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucketWOCount, isUnit: true)),
          CellProperty(StringUtils.parseString(data.bucketWOAmount)),
          CellProperty("${StringUtils.parseString(data.bucketWOPerc)} %"),
          CellProperty(
              StringUtils.parseString(data.bucketWODiffCount, isUnit: true),
              color: !data.bucketWODiffCount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty(StringUtils.parseString(data.bucketWODiffAmount),
              color: !data.bucketWODiffAmount.isNegative
                  ? Palette.red
                  : Palette.green),
          CellProperty("${StringUtils.parseString(data.bucketWODiffPerc)} %",
              color: !data.bucketWODiffPerc.isNegative
                  ? Palette.red
                  : Palette.green),
        ],
      ];
    }

    var branch = data?.branchName;

    if (branch == null) {
      branch = _currentBranch.cName.toLowerCase() == 'all'
          ? "NASIONAL"
          : _currentBranch.cName;
    }

    tableAttribute = CustomTableAttribut(
        cells: _mainContent,
        leftContent: _leftContent,
        headerColoumn: _header,
        branchName: branch,
        headerLeftContent: _headerLeftContent);
  }
}
