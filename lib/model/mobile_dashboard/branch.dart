class BranchModel {
  final String cCode;
  final String cName;
  final int sysCompanyId;

  BranchModel({this.cCode, this.cName, this.sysCompanyId});

  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      cCode: (json['C_CODE'] as String),
      cName: (json['C_NAME'] as String),
      sysCompanyId: (json['SYS_COMPANYID'] as num).toInt(),
    );
  }
}