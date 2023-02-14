import 'package:chat_gpt/app/shared/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MyTheme {
  /// definitions for the app theme
  static final appTheme = ThemeData(
    // useMaterial3: true,
    scaffoldBackgroundColor: AppColors.primaryColor,
    primaryColor: AppColors.primaryColor,
    iconTheme: const IconThemeData(color: AppColors.iconColor),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(
        color: AppColors.whiteColor,
      ),
      bodyLarge: TextStyle(
        color: AppColors.whiteColor,
      ),
      titleMedium: TextStyle(color: AppColors.whiteColor, fontSize: 18),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.primaryColor),
  );
}
