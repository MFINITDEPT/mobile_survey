import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobilesurvey/component/adv_row.dart';
import 'package:mobilesurvey/component/custom_data_table.dart';
import 'package:mobilesurvey/logic/mobile_dashboard/report_table.dart';
import 'package:mobilesurvey/model/mobile_dashboard/custom_table_atribute.dart';
import 'package:mobilesurvey/model/mobile_dashboard/flspot.dart';
import 'package:mobilesurvey/utilities/constant.dart';
import 'package:mobilesurvey/utilities/date_utils.dart';
import 'package:mobilesurvey/utilities/enum.dart';
import 'package:mobilesurvey/utilities/palette.dart';
import 'package:mobilesurvey/utilities/translation.dart';

// ignore: public_member_api_docs
class ReportTableUI extends StatefulWidget {
  final bool isKPR;

  // ignore: public_member_api_docs
  const ReportTableUI({Key key, this.isKPR}) : super(key: key);

  @override
  _ReportTableUIState createState() => _ReportTableUIState();
}

class _ReportTableUIState extends State<ReportTableUI> {
  final ReportTable _reportTable = ReportTable();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    _reportTable.isKPR = widget.isKPR ?? false;
    _reportTable.getTableData();
    _reportTable.getChartData();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Observer(
              builder: (_) => _reportTable.tableAttribute == null
                  ? Text(translation.getText('loading'))
                  : InkWell(
                      onTap: () => _reportTable.goToChooser(context),
                      child: AdvRow(
                          padding: EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 4.0),
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(_reportTable.tableAttribute.branchName,
                                style: TextStyle(color: Palette.mnc)),
                            Icon(Icons.arrow_drop_down)
                          ]),
                    )),
          actions: [
            Center(
                child: AdvRow(
              children: <Widget>[
                InkWell(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: AdvRow(
                        children: <Widget>[
                          Observer(
                              builder: (_) => Text(
                                  DateUtils.convertDateTimeToString(
                                      _reportTable.date,
                                      format: 'dd-MMM-yyyy'),
                                  style: TextStyle(color: Palette.mnc))),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                    onTap: () => _reportTable.onChangeDate(context)),
                Text('vs', style: TextStyle(color: Palette.mnc)),
                InkWell(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: AdvRow(
                        children: <Widget>[
                          Observer(
                              builder: (_) => Text(
                                  DateUtils.convertDateTimeToString(
                                      _reportTable.lastDate,
                                      format: 'dd-MMM-yyyy'),
                                  style: TextStyle(color: Palette.mnc))),
                          Icon(Icons.arrow_drop_down)
                        ],
                      ),
                    ),
                    onTap: () => _reportTable.onChangeBeforeDate(context)),
              ],
            ))
          ],
        ),
        body: Observer(
            builder: (_) => _reportTable.tableAttribute == null
                ? Center(child: SpinKitDualRing(color: Palette.mnc))
                : _reportTable.tableAttribute.cells.isEmpty
                    ? Center(child: Text(translation.getText('no_data')))
                    : CustomScrollView(slivers: <Widget>[
                        _buildSliverTable(_reportTable.tableAttribute),
                        _buildSliverChart()
                      ])));
  }

  Widget _buildSliverTable(CustomTableAttribut _data) {
    return SliverPadding(
      padding: EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          CustomTable(
              leftContent: _data.leftContent,
              headerLeftContent: _data.headerLeftContent,
              cells: _data.cells,
              headerColoumn: _data.headerColoumn,
              cellWidth: 100,
              cellHeight: 40,
              headerColor: Colors.blue,
              centerHeader: true)
        ]),
      ),
    );
  }

  Widget _buildSliverChart() {
    return SliverPadding(
      padding: EdgeInsets.all(16.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          Observer(
              builder: (_) => _reportTable.chartData != null
                  ? _reportTable.chartData.isNotEmpty
                      ? _buildFlChart(_reportTable.chartData)
                      : Center(child: Text(translation.getText('no_data')))
                  : Container())
        ]),
      ),
    );
  }

  Widget _buildFlChart(List<FlSpotModel> data) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
            color: Color(0xFF00325d),
          ),
          width: double.infinity,
          height: kDeviceHeight(context) / 1.4,
          padding: const EdgeInsets.only(
              right: 28.5, left: 28.0, top: 58.0, bottom: 12.0),
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: LineChart(
            _mainData(data),
            swapAnimationDuration: Duration(milliseconds: 400),
          ),
        ),
        Positioned.fill(
          left: 27,
          child: Align(
            child: _buildChartFilterDropdown(),
            alignment: Alignment.topLeft,
          ),
        ),
      ],
    );
  }

  Widget _buildChartFilterDropdown() {
    return DropdownButton(
      icon: Icon(
        Icons.arrow_drop_down,
        color: Palette.gold,
      ),
      iconSize: 20,
      elevation: 10,
      style: TextStyle(color: Palette.chartDropdown),
      underline: Container(
        height: 2,
        color: Palette.chartDropdown,
      ),
      value: _reportTable.chartFilter,
      onChanged: _reportTable.changeFilterChart,
      items: _reportTable.filterOptions
          .map((desc, value) {
            return MapEntry(
                desc,
                DropdownMenuItem<chooserFilter>(
                  value: value,
                  child: Text(desc),
                ));
          })
          .values
          .toList(),
    );
  }

  LineChartData _mainData(List<FlSpotModel> data) {
    //* variable for fixed yAxisTitles
    double reduceAxis =
        data.reduce((curr, next) => curr.y > next.y ? curr : next).y == 0
            ? 0
            : data.reduce((curr, next) => curr.y > next.y ? curr : next).y;

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          //* get fixed horizontal FlLine by value
          return FlLine(
            color: Palette.chartGridColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Palette.chartGridColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
//          textStyle: const TextStyle(
//              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: _reportTable.getMonth,
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
//          textStyle: const TextStyle(
//            color: Colors.white,
//            fontWeight: FontWeight.normal,
//            fontSize: 10,
//          ),
          getTitles: (value) => _reportTable.getYAxis(value, reduceAxis),
          reservedSize: kDeviceWidth(context) * 0.06,
          margin: 22,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: Palette.chartGridColor, width: 1)),
      minX: 0,
      maxX: (data.length).toDouble() + 1,
      minY: 0,
      //* fixed maxY
      maxY: 5,
      //* dynamic maxY
      // maxY: (data.map((e) => e.y).reduce(max)) + 1000,
      lineTouchData: LineTouchData(
        enabled: true,
        touchTooltipData: LineTouchTooltipData(
          maxContentWidth: MediaQuery.of(context).size.width * 0.2,
          tooltipBgColor: Palette.yellow,
          getTooltipItems: (touchedSpots) {
            const textStyle = TextStyle(
              color: Color(0xFF00325d),
            );
            return touchedSpots.map((item) {
              //* returns dynamic-type LineTooltipItem
              // return LineTooltipItem("Amount:\n${(item.y * reduceAxis) / 4}", textStyle);
              //* returns fixed-type LineTooltipItem
              return LineTooltipItem(
                  "Amount:\n${(item.y * reduceAxis) / 4}", textStyle);
            }).toList();
          },
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: data.map((spot) {
            //* returns dynamic-type FlSpot
            // return FlSpot(spot.x, spot.y);
            //* returns fixed-type FlSpot
            return FlSpot(spot.x, (spot.y / reduceAxis) * 4);
          }).toList(),
          isCurved: false,
          colors: Palette.chartGradientColor,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            colors: Palette.chartGradientColor
                .map((color) => color.withOpacity(0.3))
                .toList(),
          ),
        ),
      ],
    );
  }
}
