import 'package:ayurveda/core/constants/app_colors.dart';
import 'package:ayurveda/presentation/register_patient/widgets/gender_counter.dart';
import 'package:flutter/material.dart';

class TreatWidget extends StatelessWidget {
  final String title;
  final int index;
  final VoidCallback onEdit;
  final VoidCallback onRemove;
  final int femaleCount;
  final int maleCount;
  const TreatWidget({
    super.key,
    required this.title,
    required this.index,
    required this.onEdit,
    required this.onRemove,
    required this.femaleCount,
    required this.maleCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.lightGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "$index.",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onRemove, // Remove treatment
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFF8A9B),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GenderCounterRow(
            femaleCount: femaleCount,
            maleCount: maleCount,
            // onEdit: onEdit,
          ),
        ],
      ),
    );
  }
}
