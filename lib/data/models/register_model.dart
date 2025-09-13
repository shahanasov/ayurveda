// class PatientRegister {
//   String name;
//   String excecutive;
//   String payment;
//   String phone;
//   String address;
//   double totalAmount;
//   double discountAmount;
//   double advanceAmount;
//   double balanceAmount;
//   String dateNdTime;
//   String? id; // pass empty string if new patient
//   String male; // comma-separated treatment IDs
//   String female; // comma-separated treatment IDs
//   String branch;
//   String treatments; // comma-separated treatment IDs

//   PatientRegister({
//     required this.name,
//     required this.excecutive,
//     required this.payment,
//     required this.phone,
//     required this.address,
//     required this.totalAmount,
//     required this.discountAmount,
//     required this.advanceAmount,
//     required this.balanceAmount,
//     required this.dateNdTime,
//     required this.id,
//     required this.male,
//     required this.female,
//     required this.branch,
//     required this.treatments,
//   });


// Map<String, dynamic> toJson() {
//   final data = {
//     "name": name,
//     "excecutive": excecutive,
//     "payment": payment,
//     "phone": phone,
//     "address": address,
//     "total_amount": totalAmount.toString(),
//     "discount_amount": discountAmount.toString(),
//     "advance_amount": advanceAmount.toString(),
//     "balance_amount": balanceAmount.toString(),
//     "date_nd_time": dateNdTime,
//     "male": male, // list of IDs as string
//     "female": female, // list of IDs as string
//     "branch": branch, // send only ID
//     "treatments": treatments, // list of IDs as string
//      "id": id ?? '',
//   };

//   // 👇 Only include id if it’s not empty


//   return data;
// }

//   // Optional: Create a PatientUpdate object from JSON
//   factory PatientRegister.fromJson(Map<String, dynamic> json) {
//     return PatientRegister(
//       name: json['name'] ?? '',
//       excecutive: json['excecutive'] ?? '',
//       payment: json['payment'] ?? '',
//       phone: json['phone'] ?? '',
//       address: json['address'] ?? '',
//       totalAmount: (json['total_amount'] ?? 0).toDouble(),
//       discountAmount: (json['discount_amount'] ?? 0).toDouble(),
//       advanceAmount: (json['advance_amount'] ?? 0).toDouble(),
//       balanceAmount: (json['balance_amount'] ?? 0).toDouble(),
//       dateNdTime: json['date_nd_time'] ?? '',
//       id: json['id'] ?? '',
//       male: json['male'] ?? '',
//       female: json['female'] ?? '',
//       branch: json['branch'] ?? '',
//       treatments: json['treatments'] ?? '',
//     );
//   }
// }

import 'package:http/http.dart' as http;

class PatientRegister {
  String name;
  String executive; // ✅ FIXED: was "excecutive"
  String payment;
  String phone;
  String address;
  double totalAmount;
  double discountAmount;
  double advanceAmount;
  double balanceAmount;
  String dateNdTime;
  String? id;
  String male;
  String female;
  String branch;
  String treatments;

  PatientRegister({
    required this.name,
    required this.executive, // ✅ Fixed spelling
    required this.payment,
    required this.phone,
    required this.address,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateNdTime,
    required this.id,
    required this.male,
    required this.female,
    required this.branch,
    required this.treatments,
  });

  // 👇 NEW: Convert to MultipartRequest
  http.MultipartRequest toMultipartRequest(String token) {
    final request = http.MultipartRequest('POST', Uri.parse(
        'https://flutter-amr.noviindus.in/api/PatientUpdate'));

    // Add Authorization header if needed (check login response)
    if (token.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $token';
    }

    // Add all fields as strings
    request.fields['name'] = name;
    request.fields['executive'] = executive; // ✅ Correct spelling
    request.fields['payment'] = payment;
    request.fields['phone'] = phone;
    request.fields['address'] = address;
    request.fields['total_amount'] = totalAmount.toString();
    request.fields['discount_amount'] = discountAmount.toString();
    request.fields['advance_amount'] = advanceAmount.toString();
    request.fields['balance_amount'] = balanceAmount.toString();
    request.fields['date_nd_time'] = dateNdTime;
    request.fields['id'] = id ?? '';
    request.fields['male'] = male;
    request.fields['female'] = female;
    request.fields['branch'] = branch;
    request.fields['treatments'] = treatments;

    return request;
  }
}