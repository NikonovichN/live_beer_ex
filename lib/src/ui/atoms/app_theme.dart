import 'package:flutter/material.dart';

import 'colors.dart';
import 'fonts.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // Color Scheme
      colorScheme: ColorScheme.light(
        primary: AppColors.accentYellow,
        onPrimary: AppColors.textBlack,
        secondary: AppColors.accentYellow,
        onSecondary: AppColors.textBlack,
        surfaceBright: AppColors.backgroundWhite,
        onSurfaceVariant: AppColors.textBlack,
        surface: AppColors.surfaceWhite,
        onSurface: AppColors.textBlack,
        outline: AppColors.borderGray,
        outlineVariant: AppColors.borderGray,
      ),

      // Scaffold
      scaffoldBackgroundColor: AppColors.pureWhite,

      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.pureWhite,
        foregroundColor: AppColors.textBlack,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextTheme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
        iconTheme: const IconThemeData(color: AppColors.textBlack),
      ),

      // Text Theme
      textTheme: AppTextTheme.textTheme,

      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.pureWhite,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderGray, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.borderGray, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.accentYellow, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        labelStyle: AppTextTheme.hintStyle,
        hintStyle: AppTextTheme.hintStyle,
        floatingLabelStyle: AppTextTheme.inputStyle.copyWith(color: AppColors.accentYellow),
      ),

      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentYellow,
          foregroundColor: AppColors.textBlack,
          textStyle: AppTextTheme.buttonStyle,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.textBlack,
          textStyle: AppTextTheme.buttonStyle.copyWith(decoration: TextDecoration.underline),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.textBlack,
          textStyle: AppTextTheme.buttonStyle,
          side: const BorderSide(color: AppColors.borderGray),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.darkNav,
        selectedItemColor: AppColors.accentYellow,
        unselectedItemColor: Color(0xFF888888),
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.pureWhite,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.borderGray, width: 1),
        ),
      ),

      // Divider Theme
      dividerTheme: const DividerThemeData(color: AppColors.borderGray, thickness: 1, space: 1),

      // Progress Indicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(color: AppColors.accentYellow),
    );
  }
}
