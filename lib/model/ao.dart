class AoModel {
  final String code;
  final String cCode;
  final String isHO;
  final String descs;
  final int maxClientLoad;
  final int currentLoad;
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

