import 'dart:convert';
import 'package:ayurveda/data/models/branch_model.dart';
import 'package:ayurveda/data/models/register_model.dart';
import 'package:ayurveda/data/models/treatment_model.dart';
import 'package:ayurveda/data/services/login_service.dart';
import 'package:http/http.dart' as http;

class RegisterPatientService {
  final String baseUrl = "https://flutter-amr.noviindus.in/api";

  // Fetch Branches
  Future<List<Branch>> fetchBranches() async {
    final token = await LoginService().getToken();

    final response = await http.get(
      Uri.parse('$baseUrl/BranchList'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List data = json.decode(response.body)['branches'];
      return data.map((e) => Branch.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load branches');
    }
  }

  // Fetch Treatments
  Future<List<Treatment>> fetchTreatments() async {
    final token = await LoginService().getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/TreatmentList"),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List list = data["treatments"] ?? [];
      return list.map((e) => Treatment.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load treatments: ${response.statusCode}");
    }
  }

  // Register Patient
Future<bool> registerPatient(PatientRegister patient) async {
  try {
    final token = await LoginService().getToken();
    if (token == null) throw Exception('Token not found');

    final response = await http.post(
      Uri.parse('$baseUrl/PatientUpdate'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: json.encode(patient.toJson()),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == true) return true;
      else {
        throw Exception(data['message'] ?? 'Registration failed');
      }
    } else {
      throw Exception(
          'Failed to register patient. Status code: ${response.statusCode}');
    }
  } catch (e) {
    
    print('registerPatient error: $e');
    rethrow;
  }
}

}
