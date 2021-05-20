// ignore: public_member_api_docs
class ConfigurationModel {
  final int status;
  final String message;
  final String formUpdate;
  final String zipCodeUpdate;
  final String quisionerUpdate;

  // ignore: public_member_api_docs
  ConfigurationModel(
      {this.status,
      this.message,
      this.formUpdate,
      this.zipCodeUpdate,
      this.quisionerUpdate});

  factory ConfigurationModel.fromJson(Map<String, dynamic> json) {
    return ConfigurationModel(
        status: json.containsKey('status') ? json['status'] : null,
        message: json.containsKey('message') ? json['message'] : null,
        formUpdate: json.containsKey('formUpdate') ? json['formUpdate'] : null,
        zipCodeUpdate:
            json.containsKey('zipcodeUpdate') ? json['zipcodeUpdate'] : null,
        quisionerUpdate: json.containsKey('quisionerUpdate')
            ? json['quisionerUpdate']
            : null);
  }
}
