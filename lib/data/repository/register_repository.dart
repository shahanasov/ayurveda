import 'package:ayurveda/data/models/register_model.dart';
import 'package:ayurveda/data/services/register_patient_service.dart';
import '../models/branch_model.dart';
import '../models/treatment_model.dart';

class RegisterRepository {
  final RegisterPatientService _service;

  RegisterRepository(this._service);

  Future<List<Branch>> fetchBranches() => _service.fetchBranches();
  Future<List<Treatment>> fetchTreatments() => _service.fetchTreatments();
  Future<Map<String, dynamic>>  registerPatient(PatientRegister request) => _service.registerPatient(request);
}
