import 'package:basic_components/components/adv_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:mobilesurvey/component/custom_data_table.dart';
import 'package:mobilesurvey/model/mobile_dashboard/sales.dart';
import 'package:mobilesurvey/logic/mobile_dashboard/sales_report.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/translation.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:sliver_fill_remaining_box_adapter/sliver_fill_remaining_box_adapter.dart';

class SalesReportUI extends StatefulWidget {
  @override
  _SalesReportUIState createState() => _SalesReportUIState();
}

class _SalesReportUIState extends State<SalesReportUI> {
  final SalesReport _report = SalesReport();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      _report.getData();
    });

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).orientation);
    return Scaffold(
      appBar: AppBar(
          title: Observer(
              builder: (_) => _report.salesReportAtribut == null
                  ? Text(
                      translation.getText('loading'),
                      style: TextStyle(color: Palette.mnc),
                    )
                  : InkWell(
                      onTap: () => _report.goToChooser(context),
                      child: AdvRow(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 4.0),
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              _report
                                  .salesReportAtribut.tableAtribut.branchName,
                              style: TextStyle(color: Palette.mnc),
                            ),
                            Icon(Icons.arrow_drop_down)
                          ]),
                    ))),
      body: Observer(
          builder: (_) => _report.salesReportAtribut == null
              ? Center(child: SpinKitDualRing(color: Palette.mncSecondary))
              : _report.salesReportAtribut.tableAtribut.cells.length == 0
                  ? Center(child: Text(translation.getText('no_data')))
                  : _salesReportChart(_report.salesReportAtribut)),
    );
  }

  Widget _salesReportChart(SalesReportAtribut _data) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _createChartWidget(_report.createChartData(
                  _data.kprList, _data.regList, _data.expList))
            ]),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(16.0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _createPieWidget(_report.salesData(
                  _data.kprList, _data.regList, _data.expList))
            ]),
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 16.0),
          sliver: _data.tableAtribut.leftContent.length >= 4
              ? SliverFillRemainingBoxAdapter(child: _createTable(_data))
              : SliverList(
                  delegate: SliverChildListDelegate([_createTable(_data)]),
                ),
        ),
      ],
    );
  }

  ConstrainedBox _createTable(SalesReportAtribut data) {
    var table = CustomTable(
        textSize: 12,
        leftContent: data.tableAtribut.leftContent,
        headerLeftContent: data.tableAtribut.headerLeftContent,
        cells: data.tableAtribut.cells,
        headerColoumn: data.tableAtribut.headerColoumn,
        leftHeaderAndLeftContentScale: 1.25,
        cellWidth: 120,
        cellHeight: 40,
        headerColor: Colors.blue,
        isParentSliver: true,
        centerHeader: true);

    var result = ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: data.tableAtribut.leftContent.length > 4
              ? kDeviceHeight(context) - 116
              : 40 * (data.tableAtribut.leftContent.length + 1).toDouble(),
        ),
        child: table);

    return result;
  }

  Widget _createChartWidget(ChartDataAttribut data) {
    Widget _chart = Container(
        child: charts.OrdinalComboChart(_createChart(data),
            animate: true,
            primaryMeasureAxis: charts.NumericAxisSpec(
                tickProviderSpec: charts.BasicNumericTickProviderSpec(
              desiredTickCount: 5,
            )),
            defaultRenderer: charts.BarRendererConfig(
                groupingType: charts.BarGroupingType.grouped),
            customSeriesRenderers: [
              charts.LineRendererConfig(customRendererId: 'customLine')
            ]),
        height: kDeviceHeight(context) / 4);

    return _chart;
  }

  Widget _createPieWidget(List<OrdinalSales> data) {
    Widget _pieChart = Container(
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: charts.PieChart(_createPie(data),
                  animate: true,
                  defaultRenderer: charts.ArcRendererConfig(
                      arcWidth: 90,
                      arcRendererDecorators: [charts.ArcLabelDecorator()])),
            ),
            Expanded(
              flex: 2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                      data.length, (index) => _pieDetail(data[index]))),
            ),
          ],
        ),
        height: kDeviceHeight(context) / 2);

    return _pieChart;
  }

  Widget _pieDetail(OrdinalSales sales) {
    var nf = NumberFormat('#,###.##');
    var colors = sales.title == "KMG"
        ? Palette.blue
        : sales.title == "EXP"
            ? Palette.green
            : Palette.red;
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
      Container(height: 12, width: 12, color: colors),
      Column(
        children: <Widget>[
          Text(
            '${sales.title} [Qty : ${nf.format(sales.sales)},'
            ' Amount : ${nf.format(sales.amount)}]',
            style: TextStyle(fontSize: 16),
          )
        ],
      )
    ]);
  }

  List<charts.Series<OrdinalSales, String>> _createChart(
      ChartDataAttribut data) {
    return [
      charts.Series<OrdinalSales, String>(
          id: 'kpr',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Palette.blue),
          domainFn: (sales, _) => sales.title,
          measureFn: (sales, _) => sales.sales,
          data: data.kprChart),
      charts.Series<OrdinalSales, String>(
          id: 'reg',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.red),
          domainFn: (sales, _) => sales.title,
          measureFn: (sales, _) => sales.sales,
          data: data.regChart),
      charts.Series<OrdinalSales, String>(
          id: 'exp',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.green),
          domainFn: (sales, _) => sales.title,
          measureFn: (sales, _) => sales.sales,
          data: data.expChart),
      charts.Series<OrdinalSales, String>(
          id: 'total ',
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(Colors.black),
          domainFn: (sales, _) => sales.title,
          measureFn: (sales, _) => sales.sales,
          data: data.totalChart)
        ..setAttribute(charts.rendererIdKey, 'customLine'),
    ];
  }

  List<charts.Series<OrdinalSales, int>> _createPie(List<OrdinalSales> data) {
    return [
      charts.Series<OrdinalSales, int>(
          id: 'Sales',
          colorFn: (sales, __) {
            var result;
            switch (sales.title) {
              case "KMG":
                result = charts.ColorUtil.fromDartColor(Colors.blue);
                break;
              case "REG":
                result = charts.ColorUtil.fromDartColor(Colors.red);
                break;
              case "EXP":
                result = charts.ColorUtil.fromDartColor(Colors.green);
                break;
            }
            return result;
          },
          domainFn: (sales, s) => s,
          measureFn: (sales, _) => sales.sales,
          data: data,
          labelAccessorFn: (row, _) => row.title)
    ];
  }
}
