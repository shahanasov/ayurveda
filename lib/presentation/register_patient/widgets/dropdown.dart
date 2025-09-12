import 'package:ayurveda/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RegisterDropdownField extends StatelessWidget {
  final String label;
  final String hint;
  final String? value;
  final Function(String?) onChanged;
  final  List<String> items;


  const RegisterDropdownField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.onChanged,
    required this.items
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
          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: AppColors.hintGray, fontSize: 14),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
            icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.primaryGreen),
            onChanged: onChanged,

            items: items
                .map(
                  (location) => DropdownMenuItem<String>(
                    value: location,
                    child: Text(location),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
