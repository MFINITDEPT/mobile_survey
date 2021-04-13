// ignore: public_member_api_docs
class LoginResponse {
  final String flag;
  final String message;

  // ignore: public_member_api_docs
  LoginResponse({this.flag, this.message});

  // ignore: public_member_api_docs
  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        flag: (json['flag'] as String), message: (json['message'] as String));
  }
}