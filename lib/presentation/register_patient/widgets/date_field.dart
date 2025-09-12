import 'package:ayurveda/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DateField extends StatelessWidget {
  final String label;
  final Function(DateTime?) onDateSelected;

  const DateField({
    super.key,
    required this.label,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextField(
            readOnly: true,
            onTap: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2025, 12, 31),
              );
              onDateSelected(picked);
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(16),
              suffixIcon: Padding(
                padding: EdgeInsets.all(12),
                child: Icon(Icons.calendar_month, color: AppColors.primaryGreen, size: 20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
