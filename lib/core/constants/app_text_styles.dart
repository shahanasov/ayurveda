import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextTheme {
  static const TextTheme textTheme = TextTheme(
    titleLarge: TextStyle( 
      color: AppColors.darkGray,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
    titleMedium: TextStyle( 
      color: AppColors.subtitleGray,
      fontSize: 16,
    ),
    bodyLarge: TextStyle( 
      color: AppColors.darkGray,
      fontSize: 14,
    ),
    bodyMedium: TextStyle( 
      color: AppColors.subtitleGray,
      fontSize: 14,
    ),
    bodySmall: TextStyle( 
      color: AppColors.hintGray,
      fontSize: 12,
    ),
  );
}
