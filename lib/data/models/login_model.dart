class LoginResponse {
  final String? token;
  final bool? status;

  LoginResponse({this.token, this.status});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      status: json['status'],
    );
  }
}
