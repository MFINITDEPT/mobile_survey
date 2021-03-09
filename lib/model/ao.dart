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
        code: json['code'] ?? "",
        cCode: json['cCode'] ?? "",
        isHO: json["isHo"] ?? "0",
        descs: json['descs'] ?? "",
        maxClientLoad: json["maxClientLoad"] ?? 0,
        currentLoad: json["currentLoad"] ?? 0,
        modDate: json["modDate"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {
      "code": this.code,
      "cCode": this.cCode,
      "isHo": this.isHO,
      "descs": this.descs,
      "maxClientLoad": this.maxClientLoad,
      "currentLoad": this.currentLoad,
      "modDate": this.modDate,
    };
  }
}

