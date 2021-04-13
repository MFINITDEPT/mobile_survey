// ignore: public_member_api_docs
import 'flspot.dart';

// ignore: public_member_api_docs
class ReportChartDataObject {
  final int bulan;
  final double portofolioAmount;
  final double portofolioUnit;
  final double currentAmount;
  final double currentUnit;
  final double bucket1_30Amount;
  final double bucket1_30Unit;
  final double bucket31_60Amount;
  final double bucket31_60Unit;
  final double bucket61_90Amount;
  final double bucket61_90Unit;
  final double bucket91_120Amount;
  final double bucket91_120Unit;
  final double bucket121_150Amount;
  final double bucket121_150Unit;
  final double bucket151_180Amount;
  final double bucket151_180Unit;
  final double bucket181_270Amount;
  final double bucket181_270Unit;
  final double bucketUp270Amount;
  final double bucketUp270Unit;

  // ignore: public_member_api_docs
  ReportChartDataObject({
    this.bulan,
    this.portofolioAmount,
    this.portofolioUnit,
    this.currentAmount,
    this.currentUnit,
    this.bucket1_30Amount,
    this.bucket1_30Unit,
    this.bucket31_60Amount,
    this.bucket31_60Unit,
    this.bucket61_90Amount,
    this.bucket61_90Unit,
    this.bucket91_120Amount,
    this.bucket91_120Unit,
    this.bucket121_150Amount,
    this.bucket121_150Unit,
    this.bucket151_180Amount,
    this.bucket151_180Unit,
    this.bucket181_270Amount,
    this.bucket181_270Unit,
    this.bucketUp270Amount,
    this.bucketUp270Unit,
  });

  // ignore: public_member_api_docs
  factory ReportChartDataObject.fromJSON(Map<String, dynamic> json) {
    return ReportChartDataObject(
      bulan: (json['bulan']).toInt(),
      currentAmount:
          ((json['currentAmount'] == 0 ? 0.0 : json['currentAmount']) ?? 0.0),
      currentUnit: (json['currentUnit'] ?? 0.0),
      portofolioAmount: (json['portofolioAmount'] ?? 0.0),
      portofolioUnit: (json['portofolioUnit'] ?? 0.0),
      bucket1_30Amount: (json['bucket1_30Amount'] ?? 0.0),
      bucket1_30Unit: (json['bucket1_30Unit'] ?? 0.0),
      bucket31_60Amount: (json['bucket31_60Amount'] ?? 0.0),
      bucket31_60Unit: (json['bucket31_60Unit'] ?? 0.0),
      bucket61_90Amount: (json['bucket61_90Amount'] ?? 0.0),
      bucket61_90Unit: (json['bucket61_90Unit'] ?? 0.0),
      bucket91_120Amount: (json['bucket91_120Amount'] ?? 0.0),
      bucket91_120Unit: (json['bucket91_120Unit'] ?? 0.0),
      bucket121_150Amount: (json['bucket121_150Amount'] ?? 0.0),
      bucket121_150Unit: (json['bucket121_150Unit'] ?? 0.0),
      bucket151_180Amount: (json['bucket151_180Amount'] ?? 0.0),
      bucket151_180Unit: (json['bucket151_180Unit'] ?? 0.0),
      bucket181_270Amount: (json['bucket181_270Amount'] ?? 0.0),
      bucket181_270Unit: (json['bucket181_270Unit'] ?? 0.0),
      bucketUp270Amount: (json['bucketUp270Amount'] ?? 0.0),
      bucketUp270Unit: (json['bucketUp270Unit'] ?? 0.0),
    );
  }
}

// ignore: public_member_api_docs
class ReportChartAttribute {
  final List<FlSpotModel> current;
  final List<FlSpotModel> portofolio;
  final List<FlSpotModel> bucket1_30;
  final List<FlSpotModel> bucket31_60;
  final List<FlSpotModel> bucket61_90;
  final List<FlSpotModel> bucket91_120;
  final List<FlSpotModel> bucket121_150;
  final List<FlSpotModel> bucket151_180;
  final List<FlSpotModel> bucket181_270;
  final List<FlSpotModel> bucketUp270;

  // ignore: public_member_api_docs
  ReportChartAttribute({
    this.current,
    this.portofolio,
    this.bucket1_30,
    this.bucket31_60,
    this.bucket61_90,
    this.bucket91_120,
    this.bucket121_150,
    this.bucket151_180,
    this.bucket181_270,
    this.bucketUp270,
  });
}
