import 'dart:convert';
import 'dart:developer';
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

Future<Map<String, dynamic>>  registerPatient(PatientRegister patient) async {
  final token = await LoginService().getToken();

  final request = patient.toMultipartRequest(token ?? '');

  try {
    final response = await request.send();
log(response.statusCode.toString());
    // Read response body
    final responseBody = await response.stream.bytesToString();
    

    if (response.statusCode == 200) {
      print('Success: $responseBody');
      return jsonDecode(responseBody);
    } else {
      print('Error $response.statusCode: $responseBody');
      throw Exception('Failed to register patient: ${response.statusCode}');
    }
  } catch (e) {
    print('Exception: $e');
    rethrow;
  }
}

}
