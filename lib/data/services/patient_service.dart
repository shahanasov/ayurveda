import 'dart:convert';
import 'package:ayurveda/data/services/login_service.dart';
import 'package:http/http.dart' as http;

class PatientService {
  final String baseUrl = "https://flutter-amr.noviindus.in/api";

  Future<List<dynamic>> fetchPatients() async {
    final token = await LoginService().getToken();
    print(token);
    final response = await http.get(
      Uri.parse("$baseUrl/PatientList"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data["patient"] ?? [];
    } else {
      throw Exception("Failed to load patients: ${response.statusCode}");
    }
  }
}
