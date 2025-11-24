import 'package:flutter/material.dart';
import 'package:recipe_app/core/constants.dart';

ThemeData appTheme() {
  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary, background: AppColors.bg, primary: AppColors.primary),
    scaffoldBackgroundColor: AppColors.bg,
    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(fontSize: 14),
    ),
  );
}
