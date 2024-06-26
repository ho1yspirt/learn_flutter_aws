import 'package:flutter/material.dart';

import '../../constants/constants.dart';

final class AppTheme {
  final ThemeData _baseThemeData = ThemeData(
    fontFamily: AppFonts.inter,
    splashFactory: InkSparkle.splashFactory,
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    }),
    textTheme: const TextTheme(),
    appBarTheme: const AppBarTheme(
      centerTitle: false,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      labelStyle: TextStyle(color: AppColors.primary),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(24)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        minimumSize: const Size.fromHeight(48),
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    ),
  );

  late final ThemeData lightThemeData = _baseThemeData.copyWith(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      surfaceTint: Colors.transparent,
      brightness: Brightness.light,
      seedColor: AppColors.primary,
    ),
  );

  late final ThemeData darkThemeData = _baseThemeData.copyWith(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSeed(
      surfaceTint: Colors.transparent,
      brightness: Brightness.dark,
      seedColor: AppColors.primary,
    ),
  );
}
