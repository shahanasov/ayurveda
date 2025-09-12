import '../models/patient_model.dart';
import '../services/patient_service.dart';

class PatientRepository {
  final PatientService _service = PatientService();

  Future<List<Patient>> getPatients() async {
    final result = await _service.fetchPatients();
    return result.map<Patient>((json) => Patient.fromJson(json)).toList();
  }
}
