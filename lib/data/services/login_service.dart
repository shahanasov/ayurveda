import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';
import '../models/login_model.dart';

class LoginService {
  final ApiClient _apiClient = ApiClient();

  Future<LoginResponse> login(String username, String password) async {
    final response = await _apiClient.post("Login", {
      "username": username,
      "password": password,
    });

    // Parse response
    final loginResponse = LoginResponse.fromJson(response);

    // Save token in SharedPreferences if login is successful
    if (loginResponse.token != null && loginResponse.token!.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', loginResponse.token!);
    }

    return loginResponse;
  }

  //  to get saved token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
