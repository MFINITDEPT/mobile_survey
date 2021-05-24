class LoginResponse {
  final String flag;
  final String message;

  LoginResponse({this.flag, this.message});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        flag: (json['flag'] as String), message: (json['message'] as String));
  }
}