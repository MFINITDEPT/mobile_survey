// ignore: public_member_api_docs
import 'package:mobilesurvey/model/mobile_dashboard/custom_table_atribute.dart';
import 'package:mobilesurvey/model/mobile_dashboard/marketing.dart';

// ignore: public_member_api_docs
class OrdinalSales {
  final String title;
  final int sales;
  final double amount;

  // ignore: public_member_api_docs
  OrdinalSales(this.title, this.sales, {this.amount});
}

// ignore: public_member_api_docs
class SalesReportAtribut {
  final CustomTableAttribut tableAtribut;
  final List<MarketingData> kprList;
  final List<MarketingData> regList;
  final List<MarketingData> expList;

  // ignore: public_member_api_docs
  SalesReportAtribut(
      {this.tableAtribut, this.kprList, this.regList, this.expList});
}

// ignore: public_member_api_docs
class ChartDataAttribut {
  final List<OrdinalSales> kprChart;
  final List<OrdinalSales> regChart;
  final List<OrdinalSales> expChart;
  final List<OrdinalSales> totalChart;

  // ignore: public_member_api_docs
  ChartDataAttribut(
      {this.kprChart, this.regChart, this.expChart, this.totalChart});
}
