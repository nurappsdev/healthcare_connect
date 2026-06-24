import 'package:flutter/material.dart';

import 'app_dimensions.dart';

abstract final class AppTextStyles {
  static const String fontFamily = 'Rubik';

  static const TextStyle lightLabelLarge = TextStyle(color: Color(0xFF252525));

  static const TextTheme textTheme = TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.w300,
      fontSize: Dimensions.fontSizeDefault,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: Dimensions.fontSizeDefault,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: Dimensions.fontSizeDefault,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: Dimensions.fontSizeDefault,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: Dimensions.fontSizeDefault,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: Dimensions.fontSizeDefault,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w900,
      fontSize: Dimensions.fontSizeDefault,
    ),
    titleMedium: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontSize: 12),
    bodyLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );
}
