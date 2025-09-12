import 'package:flutter/material.dart';

class TimeDropdown extends StatelessWidget {
  final String hint;
  final String? value;
  final Function(String?) onChanged;

  const TimeDropdown({
    super.key,
    required this.hint,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.green),
        onChanged: onChanged,
        items: const [], 
      ),
    );
  }
}
