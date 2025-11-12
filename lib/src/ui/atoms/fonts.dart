import 'package:flutter/material.dart';

import 'colors.dart';

class AppTextTheme {
  static TextTheme get textTheme {
    return TextTheme(
      // Display
      displayLarge: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: AppColors.textBlack,
      ),
      displayMedium: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: AppColors.textBlack,
      ),
      displaySmall: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: AppColors.textBlack,
      ),

      // Headline
      headlineLarge: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: AppColors.textBlack,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: AppColors.textBlack,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: AppColors.textBlack,
      ),

      // Title
      titleLarge: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 22,
        fontWeight: FontWeight.w500,
        color: AppColors.textBlack,
      ),
      titleMedium: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.textBlack,
      ),
      titleSmall: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textBlack,
      ),

      // Body
      bodyLarge: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textBlack,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textBlack,
      ),
      bodySmall: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textBlack,
      ),

      // Label
      labelLarge: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textBlack,
      ),
      labelMedium: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: AppColors.textBlack,
      ),
      labelSmall: TextStyle(
        fontFamily: 'SF-UI-DISPLAY',
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: AppColors.textBlack,
      ),
    );
  }

  static TextStyle get buttonStyle {
    return const TextStyle(
      fontFamily: 'SF-UI-DISPLAY',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.textBlack,
    );
  }

  static TextStyle get inputStyle {
    return const TextStyle(
      fontFamily: 'SF-UI-DISPLAY',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.textBlack,
    );
  }

  static TextStyle get hintStyle {
    return const TextStyle(
      fontFamily: 'SF-UI-DISPLAY',
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: Color(0xFF888888),
    );
  }
}
