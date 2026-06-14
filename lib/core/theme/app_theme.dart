import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

abstract final class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    fontFamily: AppTextStyles.fontFamily,
    primaryColor: AppColors.darkPrimaryColor,
    secondaryHeaderColor: AppColors.secondaryColor,
    brightness: Brightness.dark,
    cardColor: AppColors.darkCardColor,
    hintColor: AppColors.darkHintColor,
    disabledColor: AppColors.darkDisabledColor,
    shadowColor: Colors.black.withValues(alpha: 0.4),
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.whiteColor,
    ),
    pageTransitionsTheme: _pageTransitionsTheme,
    textTheme: AppTextStyles.textTheme.copyWith(
      labelLarge: AppTextStyles.lightLabelLarge,
    ),
  );

  static final ThemeData lightTheme = ThemeData(
    fontFamily: AppTextStyles.fontFamily,
    scaffoldBackgroundColor: AppColors.blackColor,
    primaryColor: AppColors.primaryColor,
    secondaryHeaderColor: AppColors.secondaryColor,
    brightness: Brightness.light,
    cardColor: AppColors.whiteColor,
    hintColor: AppColors.lightHintColor,
    disabledColor: AppColors.lightDisabledColor,
    shadowColor: Colors.grey.shade300,
    pageTransitionsTheme: _pageTransitionsTheme,
    textTheme: AppTextStyles.textTheme,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      iconTheme: const IconThemeData(color: AppColors.whiteColor),
      backgroundColor: AppColors.primaryColor,
      shadowColor: Colors.black.withValues(alpha: 0.12),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
    ),
    datePickerTheme: const DatePickerThemeData(
      dayStyle: TextStyle(color: AppColors.primaryColor, fontSize: 14),
      weekdayStyle: TextStyle(color: AppColors.blackColor, fontSize: 14),
    ),
  );

  static const PageTransitionsTheme _pageTransitionsTheme =
      PageTransitionsTheme(
        builders: {
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
          TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
        },
      );
}
