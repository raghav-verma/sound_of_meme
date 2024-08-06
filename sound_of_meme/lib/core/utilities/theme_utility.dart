import 'package:flutter/material.dart';

import '../app_fonts.dart';

class ThemeUtility {
  static const Color primaryColor = Color(0xFF0F172A);
  static const Color secondaryColor = Color(0xFF4ADE80);
  static const Color backgroundColorLight = Color(0xFFFFFFFF);
  static const Color backgroundColorDark = Color(0xFF1E1E2C);
  static const Color textColorLight = Color(0xFF000000);
  static const Color textColorDark = Color(0xFFFFFFFF);
  static const Color hintTextColor = Color(0xFF727272);
  static const Color fillColor = Color(0xFF111111);
  static const Color borderColor = Color(0xFF111111);
  static const Color errorColor = Color(0xFFFF0000);
  static const Color tealColor = Color(0xff083344);

  TextTheme buildTextTheme(Color textColor) {
    return TextTheme(
      displayLarge: AppFonts.blackStyle(fontColor: textColor, fontSize: 96),
      displayMedium: AppFonts.blackStyle(fontColor: textColor, fontSize: 60),
      displaySmall: AppFonts.regularStyle(fontColor: textColor, fontSize: 48),
      headlineLarge: AppFonts.regularStyle(fontColor: textColor, fontSize: 34),
      headlineMedium: AppFonts.regularStyle(fontColor: textColor, fontSize: 24),
      headlineSmall: AppFonts.regularStyle(fontColor: textColor, fontSize: 20),
      titleLarge: AppFonts.mediumStyle(fontColor: textColor, fontSize: 16),
      titleMedium: AppFonts.regularStyle(fontColor: textColor, fontSize: 14),
      titleSmall: AppFonts.mediumStyle(fontColor: textColor, fontSize: 14),
      bodyLarge: AppFonts.regularStyle(fontColor: textColor, fontSize: 16),
      bodyMedium: AppFonts.regularStyle(fontColor: textColor, fontSize: 14),
      bodySmall: AppFonts.regularStyle(fontColor: textColor, fontSize: 12),
      labelLarge: AppFonts.mediumStyle(fontColor: textColor, fontSize: 14),
      labelMedium: AppFonts.regularStyle(fontColor: textColor, fontSize: 12),
      labelSmall: AppFonts.regularStyle(fontColor: textColor, fontSize: 10),
    );
  }

  ThemeData getLightTheme() => ThemeData(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: backgroundColorLight,
    canvasColor: Colors.white,
    colorScheme: const ColorScheme.light(
      primary: Colors.white,
      secondary: secondaryColor,
      onPrimary: textColorLight,
      onSecondary: textColorLight,
      background: backgroundColorLight,
      error: errorColor,
    ),
    textTheme: buildTextTheme(textColorLight),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      hintStyle: AppFonts.regularStyle(fontColor: hintTextColor),
      labelStyle: AppFonts.regularStyle(fontColor: textColorLight),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: errorColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: secondaryColor,
      colorScheme: ColorScheme.light(
        primary: secondaryColor,
        onPrimary: textColorLight,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
      foregroundColor: textColorLight,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: primaryColor,
      textStyle: AppFonts.regularStyle(fontColor: textColorLight),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.6),
      selectedLabelStyle: AppFonts.mediumStyle(fontColor: Colors.white),
      unselectedLabelStyle: AppFonts.mediumStyle(fontColor: Colors.white.withOpacity(0.6)),
      selectedIconTheme: const IconThemeData(color: Colors.white),
      unselectedIconTheme: IconThemeData(color: Colors.white.withOpacity(0.6)),
    ),
  );

  ThemeData getDarkTheme() => ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColorDark,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      onPrimary: textColorDark,
      onSecondary: textColorDark,
      background: backgroundColorDark,
      error: errorColor,
    ),
    canvasColor: tealColor,
    textTheme: buildTextTheme(textColorDark),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      hintStyle: AppFonts.regularStyle(fontColor: hintTextColor),
      labelStyle: AppFonts.regularStyle(fontColor: textColorDark),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: primaryColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: errorColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: borderColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: secondaryColor,
      colorScheme: ColorScheme.dark(
        primary: secondaryColor,
        onPrimary: textColorDark,
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: secondaryColor,
      foregroundColor: textColorDark,
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: primaryColor,
      textStyle: AppFonts.regularStyle(fontColor: textColorDark),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white.withOpacity(0.6),
      selectedLabelStyle: AppFonts.mediumStyle(fontColor: Colors.white),
      unselectedLabelStyle: AppFonts.mediumStyle(fontColor: Colors.white.withOpacity(0.6)),
      selectedIconTheme: const IconThemeData(color: Colors.white),
      unselectedIconTheme: IconThemeData(color: Colors.white.withOpacity(0.6)),
    ),
  );
}