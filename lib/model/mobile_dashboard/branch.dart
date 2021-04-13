// ignore: public_member_api_docs
class BranchModel {
  final String cCode;
  final String cName;
  final int sysCompanyId;

  // ignore: public_member_api_docs
  BranchModel({this.cCode, this.cName, this.sysCompanyId});

  // ignore: public_member_api_docs
  factory BranchModel.fromJson(Map<String, dynamic> json) {
    return BranchModel(
      cCode: (json['C_CODE'] as String),
      cName: (json['C_NAME'] as String),
      sysCompanyId: (json['SYS_COMPANYID'] as num).toInt(),
    );
  }
}