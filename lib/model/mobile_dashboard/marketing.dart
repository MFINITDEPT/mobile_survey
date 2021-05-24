class MarketingUnit {
  final int unit;
  final double amount;
  final double percent;
  final int year;

  MarketingUnit({this.unit, this.amount, this.percent, this.year});
}

class MarketingDataObject {
  final String code;
  final String module;
  final String assetType;
  final String productFacility;
  final int unitJan;
  final double pokokJan;
  final double persenJan;
  final int unitFeb;
  final double pokokFeb;
  final double persenFeb;
  final int unitMar;
  final double pokokMar;
  final double persenMar;
  final int unitApr;
  final double pokokApr;
  final double persenApr;
  final int unitMei;
  final double pokokMei;
  final double persenMei;
  final int unitJun;
  final double pokokJun;
  final double persenJun;
  final int unitJul;
  final double pokokJul;
  final double persenJul;
  final int unitAug;
  final double pokokAug;
  final double persenAug;
  final int unitSep;
  final double pokokSep;
  final double persenSep;
  final int unitOct;
  final double pokokOct;
  final double persenOct;
  final int unitNov;
  final double pokokNov;
  final double persenNov;
  final int unitDec;
  final double pokokDec;
  final double persenDec;

  MarketingDataObject(
      {this.code,
        this.module,
        this.assetType,
        this.productFacility,
        this.unitJan,
        this.pokokJan,
        this.persenJan,
        this.unitFeb,
        this.pokokFeb,
        this.persenFeb,
        this.unitMar,
        this.pokokMar,
        this.persenMar,
        this.unitApr,
        this.pokokApr,
        this.persenApr,
        this.unitMei,
        this.pokokMei,
        this.persenMei,
        this.unitJun,
        this.pokokJun,
        this.persenJun,
        this.unitJul,
        this.pokokJul,
        this.persenJul,
        this.unitAug,
        this.pokokAug,
        this.persenAug,
        this.unitSep,
        this.pokokSep,
        this.persenSep,
        this.unitOct,
        this.pokokOct,
        this.persenOct,
        this.unitNov,
        this.pokokNov,
        this.persenNov,
        this.unitDec,
        this.pokokDec,
        this.persenDec});

  factory MarketingDataObject.fromJson(Map<String, dynamic> json) {
    return MarketingDataObject(
      code: json['CODE'] as String,
      module: json['MODULE'] as String,
      assetType: json['ASSET_TYPE'] as String,
      productFacility: json['PRODUCT_FACILITY'] as String,
      unitJan: (json['UNIT_JAN'] as num).toInt(),
      unitFeb: (json['UNIT_FEB'] as num).toInt(),
      unitMar: (json['UNIT_MAR'] as num).toInt(),
      unitApr: (json['UNIT_APR'] as num).toInt(),
      unitMei: (json['UNIT_MEI'] as num).toInt(),
      unitJun: (json['UNIT_JUN'] as num).toInt(),
      unitJul: (json['UNIT_JUL'] as num).toInt(),
      unitAug: (json['UNIT_AUG'] as num).toInt(),
      unitSep: (json['UNIT_SEP'] as num).toInt(),
      unitOct: (json['UNIT_OCT'] as num).toInt(),
      unitNov: (json['UNIT_NOV'] as num).toInt(),
      unitDec: (json['UNIT_DEC'] as num).toInt(),
      pokokJan: (json['POKOK_JAN'] as num).toDouble(),
      pokokFeb: (json['POKOK_FEB'] as num).toDouble(),
      pokokMar: (json['POKOK_MAR'] as num).toDouble(),
      pokokApr: (json['POKOK_APR'] as num).toDouble(),
      pokokMei: (json['POKOK_MEI'] as num).toDouble(),
      pokokJun: (json['POKOK_JUN'] as num).toDouble(),
      pokokJul: (json['POKOK_JUL'] as num).toDouble(),
      pokokAug: (json['POKOK_AUG'] as num).toDouble(),
      pokokSep: (json['POKOK_SEP'] as num).toDouble(),
      pokokOct: (json['POKOK_OCT'] as num).toDouble(),
      pokokNov: (json['POKOK_NOV'] as num).toDouble(),
      pokokDec: (json['POKOK_DEC'] as num).toDouble(),
      persenJan: (json['PERSEN_JAN'] as num).toDouble(),
      persenFeb: (json['PERSEN_FEB'] as num).toDouble(),
      persenMar: (json['PERSEN_MAR'] as num).toDouble(),
      persenApr: (json['PERSEN_APR'] as num).toDouble(),
      persenMei: (json['PERSEN_MEI'] as num).toDouble(),
      persenJun: (json['PERSEN_JUN'] as num).toDouble(),
      persenJul: (json['PERSEN_JUL'] as num).toDouble(),
      persenAug: (json['PERSEN_AUG'] as num).toDouble(),
      persenSep: (json['PERSEN_SEP'] as num).toDouble(),
      persenOct: (json['PERSEN_OCT'] as num).toDouble(),
      persenNov: (json['PERSEN_NOV'] as num).toDouble(),
      persenDec: (json['PERSEN_DEC'] as num).toDouble(),
    );
  }
}

class MarketingData {
  final String code;
  final String module;
  final String assetType;
  final String productFacility;
  List<MarketingUnit> data;

  MarketingData({
    this.code,
    this.module,
    this.assetType,
    this.productFacility,
    this.data,
  });
}

class MarketingReportModel {
  final List<MarketingDataObject> current;
  final List<MarketingDataObject> before;

  MarketingReportModel({this.current, this.before});

  factory MarketingReportModel.fromJson(Map<String, dynamic> json) {
    List<MarketingDataObject> current = [];
    List<MarketingDataObject> before = [];

    List<dynamic> apires1 = json["Current"];
    List<dynamic> apires2 = json["Before"];

    if (apires1.isNotEmpty)
      for (var item in apires1) {
        current.add(MarketingDataObject.fromJson(item));
      }

    if (apires2.isNotEmpty)
      for (var item in apires2) {
        before.add(MarketingDataObject.fromJson(item));
      }

    return MarketingReportModel(current: current, before: before);
  }
}