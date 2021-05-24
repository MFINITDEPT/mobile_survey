class LoginSurveyResponse {
  final String nik;
  final String nama;

  LoginSurveyResponse({this.nik, this.nama});

  factory LoginSurveyResponse.fromJson(Map<String, dynamic> json) {
    return LoginSurveyResponse(
        nik: (json['nik'] as String), nama: (json['name'] as String));
  }
}
