import 'package:mobilesurvey/model/mobile_dashboard/custom_table_atribute.dart';
import 'package:mobilesurvey/model/mobile_dashboard/marketing.dart';

class OrdinalSales {
  final String title;
  final int sales;
  final double amount;

  OrdinalSales(this.title, this.sales, {this.amount});
}

class SalesReportAtribut {
  final CustomTableAttribut tableAtribut;
  final List<MarketingData> kprList;
  final List<MarketingData> regList;
  final List<MarketingData> expList;

  SalesReportAtribut(
      {this.tableAtribut, this.kprList, this.regList, this.expList});
}

class ChartDataAttribut {
  final List<OrdinalSales> kprChart;
  final List<OrdinalSales> regChart;
  final List<OrdinalSales> expChart;
  final List<OrdinalSales> totalChart;

  ChartDataAttribut(
      {this.kprChart, this.regChart, this.expChart, this.totalChart});
}
