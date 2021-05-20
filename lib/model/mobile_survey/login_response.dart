// ignore: public_member_api_docs
class LoginSurveyResponse {
  final String nik;
  final String nama;

  // ignore: public_member_api_docs
  LoginSurveyResponse({this.nik, this.nama});

  // ignore: public_member_api_docs
  factory LoginSurveyResponse.fromJson(Map<String, dynamic> json) {
    return LoginSurveyResponse(
        nik: (json['nik'] as String), nama: (json['name'] as String));
  }
}
