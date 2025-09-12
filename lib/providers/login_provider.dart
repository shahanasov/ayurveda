import 'package:ayurveda/data/models/login_model.dart';
import 'package:ayurveda/data/repository/login_repository.dart';
import 'package:flutter/material.dart';
class LoginProvider with ChangeNotifier {
  final LoginRepository _repository = LoginRepository();
  bool isLoading = false;
  String? error;
  LoginResponse? loginResponse;

  Future<void> login(String username, String password) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      loginResponse = await _repository.login(username, password);
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }
}
