import 'package:ayurveda/core/constants/app_colors.dart';
import 'package:ayurveda/core/utils/formatter.dart';
import 'package:ayurveda/data/models/patient_model.dart';
import 'package:flutter/material.dart';


class BookingCard extends StatelessWidget {
  final Patient booking;
  final int index;

  const BookingCard({super.key, required this.booking, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.borderGray,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: AppColors.lightGray,
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                '$index. ',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
              Text(
                booking.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ],
          ),

          const SizedBox(height: 4),

          // Package name
          Text(
            booking.branchName,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.primaryGreen,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: AppColors.orangeAccent,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    formatDate(booking.dateTime),
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.darkGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(width: 16),

              Row(
                children: [
                  Icon(Icons.person, size: 14, color: AppColors.orangeAccent),
                  const SizedBox(width: 4),
                  Text(
                    booking.user,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.darkGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),
          Divider(),

          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'View Booking details',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.subtitleGray,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                  color: AppColors.primaryGreen,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
