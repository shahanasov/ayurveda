
import 'package:ayurveda/data/models/login_model.dart';
import 'package:ayurveda/data/services/login_service.dart';

class LoginRepository {
  final LoginService _loginService = LoginService();

  Future<LoginResponse> login(String username, String password) {
    return _loginService.login(username, password);
  }
}
