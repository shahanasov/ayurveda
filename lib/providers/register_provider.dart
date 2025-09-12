import 'package:ayurveda/data/models/branch_model.dart';
import 'package:ayurveda/data/models/register_model.dart';
import 'package:ayurveda/data/models/treatment_model.dart';
import 'package:flutter/material.dart';
import 'package:ayurveda/data/services/register_patient_service.dart';

class RegisterPatientProvider with ChangeNotifier {
  final RegisterPatientService service;

  RegisterPatientProvider(this.service) {
    loadBranches();
    loadTreatments();
  }

  // ------------------- Controllers -------------------
  final TextEditingController nameController = TextEditingController();
  final TextEditingController whatsappController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController totalAmountController = TextEditingController();
  final TextEditingController discountAmountController =
      TextEditingController();
  final TextEditingController advanceAmountController = TextEditingController();
  final TextEditingController balanceAmountController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // ------------------- Dropdowns & selections -------------------
  List<Branch> branches = [];
  Branch? selectedBranch;

  List<String> locations = [
    'Kasaragod',
    'Kannur',
    'Wayanad',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Thrissur',
    'Ernakulam',
    'Idukki',
    'Kottayam',
    'Alappuzha',
    'Pathanamthitta',
    'Kollam',
    'Thiruvananthapuram',
  ];
  String? selectedLocation;

  List<Treatment> treatments = [];
  List<Treatment> selectedTreatments = [];
  bool isTreatmentLoading = false;

  // ------------------- Gender counts -------------------
  int maleCount = 0;
  int femaleCount = 0;

  // ------------------- Payment -------------------
  String paymentOption = "Cash";

  // ------------------- Time picker -------------------
  List<String> hours = List.generate(12, (i) => (i + 1).toString());
  List<String> minutes = List.generate(60, (i) => i.toString().padLeft(2, '0'));
  String? selectedHour;
  String? selectedMinute;

  bool isLoading = false;

  // ------------------- Dropdown setters -------------------
  void setBranch(Branch? branch) {
    selectedBranch = branch;
    notifyListeners();
  }

  void setLocation(String? location) {
    selectedLocation = location;
    notifyListeners();
  }

  void setHour(String? hour) {
    selectedHour = hour;
    notifyListeners();
  }

  void setMinute(String? minute) {
    selectedMinute = minute;
    notifyListeners();
  }

  void setPaymentOption(String? option) {
    if (option != null) {
      paymentOption = option;
      notifyListeners();
    }
  }

  // ------------------- Gender counter -------------------
  void setMaleCount(int count) {
    maleCount = count;
    notifyListeners();
  }

  void setFemaleCount(int count) {
    femaleCount = count;
    notifyListeners();
  }

  // ------------------- Load API data -------------------
  Future<void> loadBranches() async {
    isLoading = true;
    notifyListeners();
    try {
      branches = await service.fetchBranches();
    } catch (e) {
      debugPrint("Error loading branches: $e");
      branches = [];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> loadTreatments() async {
    isTreatmentLoading = true;
    notifyListeners();

    try {
      treatments = await service.fetchTreatments();
    } catch (e) {
      debugPrint("Error fetching treatments: $e");
      treatments = []; // fallback
    }

    isTreatmentLoading = false;
    notifyListeners();
  }

  // ------------------- Date picker -------------------
  Future<void> pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      notifyListeners();
    }
  }

  // ------------------- Register patient -------------------
  Future<PatientRegister> savePatientData() async {
  if (selectedBranch == null || selectedLocation == null) {
    throw Exception("Branch or location not selected");
  }

  // Format date and time for date_nd_time key
  String dateText = dateController.text.isNotEmpty
      ? dateController.text
      : "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
  String timeText = '${selectedHour ?? '00'}:${selectedMinute ?? '00'} ${DateTime.now().hour >= 12 ? 'PM' : 'AM'}';
  String dateAndTime = '$dateText-$timeText';

  final patient = PatientRegister(
    name: nameController.text,
    executive: selectedBranch!.name,
    payment: paymentOption,
    phone: whatsappController.text,
    address: addressController.text,
    totalAmount: double.tryParse(totalAmountController.text) ?? 0,
    discountAmount: double.tryParse(discountAmountController.text) ?? 0,
    advanceAmount: double.tryParse(advanceAmountController.text) ?? 0,
    balanceAmount: double.tryParse(balanceAmountController.text) ?? 0,
    dateAndTime: dateAndTime,
    id: '', // always empty
    male: selectedTreatments.map((t) => t.id).take(maleCount).join(","), // male treatments
    female: selectedTreatments
        .map((t) => t.id)
        .skip(maleCount)
        .take(femaleCount)
        .join(","), // female treatments
    branch: selectedBranch!.id.toString(),
    treatments: selectedTreatments.map((t) => t.id).join(","), // all treatments
  );

  return patient;
}



  // ------------------- Add/Remove treatment -------------------
  void addTreatment(Treatment treatment) {
    selectedTreatments.add(treatment);
    notifyListeners();
  }

  void removeTreatment(Treatment treatment) {
    selectedTreatments.remove(treatment);
    notifyListeners();
  }
}
