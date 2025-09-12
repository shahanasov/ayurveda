import 'package:ayurveda/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class RadioOption extends StatelessWidget {
  final String option;
  final String groupValue;
  final Function(String?) onChanged;

  const RadioOption({
    super.key,
    required this.option,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: option,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: AppColors.hintGray,
        ),
        Text(
          option,
          style: const TextStyle(fontSize: 14, color: AppColors.black),
        ),
      ],
    );
  }
}
