import 'package:hive/hive.dart';
part 'ao.g.dart';

@HiveType()
class AoModel {
  @HiveField(0)
  final String code;
  @HiveField(1)
  final String cCode;
  @HiveField(2)
  final String isHO;
  @HiveField(3)
  final String descs;
  @HiveField(4)
  final int maxClientLoad;
  @HiveField(5)
  final int currentLoad;
  @HiveField(6)
  final String modDate;

  AoModel(
      {this.code,
      this.cCode,
      this.isHO,
      this.descs,
      this.maxClientLoad,
      this.currentLoad,
      this.modDate});

  factory AoModel.fromJson(Map<String, dynamic> json) {
    return AoModel(
        code: json['CODE'] ?? "",
        cCode: json['C_CODE'] ?? "",
        isHO: json["IS_HO"] ?? "0",
        descs: json['DESCS'] ?? "",
        maxClientLoad: json["MAX_CLIENT_LOAD"] ?? 0,
        currentLoad: json["CURRENT_LOAD"] ?? 0,
        modDate: json["MOD_DATE"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "CODE": this.code,
      "C_CODE": this.cCode,
      "IS_HO": this.isHO,
      "DESCS": this.descs,
      "MAX_CLIENT_LOAD": this.maxClientLoad,
      "CURRENT_LOAD": this.currentLoad,
      "MOD_DATE": this.modDate,
    };
  }
}

