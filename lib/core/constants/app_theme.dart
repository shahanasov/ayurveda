import 'package:ayurveda/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryGreen,
    scaffoldBackgroundColor: AppColors.white,

    appBarTheme: const AppBarTheme(
      color: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.darkGray),
      titleTextStyle: TextStyle(
        color: AppColors.darkGray,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      elevation: 0,
    ),

    textTheme: AppTextTheme.textTheme,

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderGray),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryGreen, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      hintStyle: const TextStyle(color: AppColors.hintGray),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGreen,
        foregroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  );
}
