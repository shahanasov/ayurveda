class Patient {
  final int id;
  final String name;
  final String user;
  final String phone;
  final String payment;
  final String? dateTime;
  final String branchName;
  final String? treatmentName;

  Patient({
    required this.id,
    required this.name,
    required this.user,
    required this.phone,
    required this.payment,
    required this.dateTime,
    required this.branchName,
    required this.treatmentName,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'] ?? '',
      user: json['user'] ?? '',
      phone: json['phone'] ?? '',
      payment: json['payment'] ?? '',
      dateTime: json['date_nd_time'],
      branchName: json['branch']?['name'] ?? '',
      treatmentName: (json['patientdetails_set'] != null &&
              (json['patientdetails_set'] as List).isNotEmpty)
          ? json['patientdetails_set'][0]['treatment_name']
          : null,
    );
  }
}
