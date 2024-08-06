import 'package:flutter/material.dart';

import '../../core/app_fonts.dart';
import '../../core/constants/constants.dart';
import '../../core/extensions/extensions.dart';
import '../../core/helpers/helpers.dart';

class CustomTextWidget extends StatelessWidget {
  final String? text;
  final TextStyle? style;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final bool isStringKey;
  final AppFontsWeightEnum fontWeight;
  final Color? fontColor;
  final double fontSize;
  final EdgeInsetsGeometry? padding;
  final String? fontFamily;

  const CustomTextWidget(
      this.text, {
        this.style,
        this.overflow,
        this.maxLines,
        this.textAlign,
        this.isStringKey = true,
        this.fontWeight = AppFontsWeightEnum.regular,
        this.fontColor,
        this.fontSize = 14,
        super.key,
        this.padding,
        this.fontFamily = FontFamilyConstants.openSans,
      });

  @override
  Widget build(final BuildContext context) {
    final TextStyle defaultStyle = (style ?? AppFonts.getFontForWeight(fontWeight)).copyWith(
      color: fontColor ?? context.theme.textTheme.bodyMedium?.color,
      fontSize: fontSize,
      fontFamily: fontFamily,
    );

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        isStringKey ? context.stringForKey(text ?? '') : text ?? '',
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow,
        softWrap: true,
        style: defaultStyle,
      ),
    );
  }
}
