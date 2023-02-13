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
        headlineSmall: TextStyle(
          color: AppColors.blackColor,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: TextStyle(
          color: AppColors.whiteColor,
          fontWeight: FontWeight.w500,
        ),
        bodyMedium: TextStyle(
          color: AppColors.whiteColor,
        ),
        titleSmall: TextStyle(color: AppColors.blackColor)),
    bottomAppBarTheme: const BottomAppBarTheme(color: AppColors.primaryColor),
  );
}
