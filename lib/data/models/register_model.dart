class PatientRegister {
  final String name;
  final String executive;
  final String payment;
  final String phone;
  final String address;
  final double totalAmount;
  final double discountAmount;
  final double advanceAmount;
  final double balanceAmount;
  final String dateAndTime;
  final String id;
  final String male; 
  final String female; 
  final String branch;
  final String treatments;

  PatientRegister({
    required this.name,
    required this.executive,
    required this.payment,
    required this.phone,
    required this.address,
    required this.totalAmount,
    required this.discountAmount,
    required this.advanceAmount,
    required this.balanceAmount,
    required this.dateAndTime,
    this.id = "",
    required this.male,
    required this.female,
    required this.branch,
    required this.treatments,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "excecutive": executive,
      "payment": payment,
      "phone": phone,
      "address": address,
      "total_amount": totalAmount,
      "discount_amount": discountAmount,
      "advance_amount": advanceAmount,
      "balance_amount": balanceAmount,
      "date_nd_time": dateAndTime,
      "id": id,
      "male": male,
      "female": female,
      "branch": branch,
      "treatments": treatments,
    };
  }
}
