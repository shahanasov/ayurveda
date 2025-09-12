  import 'package:intl/intl.dart';

String formatDate(String? dateTimeString) {
    if (dateTimeString == null || dateTimeString.isEmpty) return "";
    try {
      DateTime parsedDate = DateTime.parse(dateTimeString);
      return DateFormat('dd/MM/yyyy').format(parsedDate);
    } catch (e) {
      return dateTimeString;
    }
  }