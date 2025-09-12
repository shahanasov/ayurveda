
import 'package:ayurveda/core/constants/app_colors.dart';
import 'package:flutter/material.dart';



// Second row with Male/Female counters
class GenderCounterRow extends StatelessWidget {
  final int femaleCount;
  final int maleCount;
  const GenderCounterRow({
    super.key,
    required this.femaleCount,
    required this.maleCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          SizedBox(width: 30), // Align with content above
          // Male section
          Row(
            children: [
              Text(
                'Male',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2E7D2E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Text(
                  "$maleCount",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(width: 32),

          // Female section
          Row(
            children: [
              Text(
                'Female',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF2E7D2E),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Text(
                  "$femaleCount",
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),

          Spacer(),

          // Edit icon
          Icon(Icons.edit, color: Color(0xFF2E7D2E), size: 20),
        ],
      ),
    );
  }
}
