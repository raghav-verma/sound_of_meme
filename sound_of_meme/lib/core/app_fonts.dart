import 'package:flutter/material.dart';
import 'constants/constants.dart';
import 'helpers/helpers.dart';

/*
Weight Chart:
blackStyle: w900
extraBoldStyle: w800
boldStyle: w700
semiBoldStyle: w600
mediumStyle: w500
regularStyle: w400
thinStyle: w300
 */

class AppFonts {
  static TextStyle blackStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontFamily,
    final Color? fontColor,
    final TextDecoration? decoration,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      fontFamily: fontFamily,
      fontColor: fontColor,
      fontWeight: AppFontsWeightEnum.black,
      decoration: decoration,
    );
  }

  static TextStyle extraBoldStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontFamily,
    final Color? fontColor,
    final TextDecoration? decoration,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      fontFamily: fontFamily,
      fontColor: fontColor,
      fontWeight: AppFontsWeightEnum.extraBold,
      decoration: decoration,
    );
  }

  static TextStyle boldStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontFamily,
    final Color? fontColor,
    final TextDecoration? decoration,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      fontFamily: fontFamily,
      fontColor: fontColor,
      fontWeight: AppFontsWeightEnum.bold,
      decoration: decoration,
    );
  }

  static TextStyle semiBoldStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontFamily,
    final Color? fontColor,
    final TextDecoration? decoration,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      fontFamily: fontFamily,
      fontColor: fontColor,
      fontWeight: AppFontsWeightEnum.semiBold,
      decoration: decoration,
    );
  }

  static TextStyle mediumStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontFamily,
    final Color? fontColor,
    final TextDecoration? decoration,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      fontFamily: fontFamily,
      fontColor: fontColor,
      fontWeight: AppFontsWeightEnum.medium,
      decoration: decoration,
    );
  }

  static TextStyle regularStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontFamily,
    final Color? fontColor,
    final TextDecoration? decoration,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      fontFamily: fontFamily,
      fontColor: fontColor,
      fontWeight: AppFontsWeightEnum.regular,
      decoration: decoration,
    );
  }

  static TextStyle thinStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontFamily,
    final Color? fontColor,
    final TextDecoration? decoration,
  }) {
    return _getTextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: height,
      fontFamily: fontFamily,
      fontColor: fontColor,
      fontWeight: AppFontsWeightEnum.thin,
      decoration: decoration,
    );
  }

  static TextStyle _getTextStyle({
    final double? fontSize,
    final double? letterSpacing,
    final double? wordSpacing,
    final double? height,
    final String? fontFamily,
    final Color? fontColor,
    final AppFontsWeightEnum? fontWeight,
    final TextDecoration? decoration,
  }) {
    final double? heightMetrics =
        height == null ? null : height / (fontSize ?? 12);

    const String defaultFamily = FontFamilyConstants.openSans;

    return TextStyle(
      fontSize: fontSize,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      height: heightMetrics,
      fontFamily: fontFamily ?? defaultFamily,
      fontWeight: fontWeight?.value ?? FontWeight.w500,
      color: fontColor,
      decoration: decoration,
    );
  }

  static TextStyle getFontForWeight(final AppFontsWeightEnum weight) {
    switch (weight) {
      case AppFontsWeightEnum.black:
        return AppFonts.blackStyle();
      case AppFontsWeightEnum.extraBold:
        return AppFonts.extraBoldStyle();
      case AppFontsWeightEnum.bold:
        return AppFonts.boldStyle();
      case AppFontsWeightEnum.semiBold:
        return AppFonts.semiBoldStyle();
      case AppFontsWeightEnum.medium:
        return AppFonts.mediumStyle();
      case AppFontsWeightEnum.regular:
        return AppFonts.regularStyle();
      case AppFontsWeightEnum.thin:
        return AppFonts.thinStyle();
    }
  }
}
