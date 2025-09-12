import 'package:ayurveda/data/models/patient_model.dart';
import 'package:ayurveda/data/repository/patient_repository.dart';
import 'package:flutter/material.dart';

class PatientProvider with ChangeNotifier {
  final PatientRepository _repository = PatientRepository();

  List<Patient> _patients = [];
  bool _isLoading = false;

  List<Patient> get patients => _patients;
  bool get isLoading => _isLoading;

  Future<void> fetchPatients() async {
    _isLoading = true;
    notifyListeners();
    try {
      _patients = await _repository.getPatients();
    } catch (e) {
      _patients = [];
    }
    _isLoading = false;
    notifyListeners();
  }
}
