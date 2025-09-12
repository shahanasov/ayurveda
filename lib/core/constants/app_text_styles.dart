import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextTheme {
  static TextTheme textTheme = TextTheme(
    titleLarge: GoogleFonts.poppins(
      color: AppColors.darkGray,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    titleMedium: GoogleFonts.poppins(
      color: AppColors.subtitleGray,
      fontSize: 16,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: AppColors.darkGray,
      fontSize: 14,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: AppColors.subtitleGray,
      fontSize: 14,
    ),
    bodySmall: GoogleFonts.poppins(
      color: AppColors.hintGray,
      fontSize: 12,
    ),
  );
}
