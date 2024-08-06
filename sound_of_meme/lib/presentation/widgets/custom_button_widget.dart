import 'package:flutter/material.dart';
import '../../core/app_fonts.dart';
import '../../core/extensions/extensions.dart';
import '../../core/helpers/helpers.dart';
import 'widgets.dart';

class CustomButtonWidget extends StatelessWidget {
  const CustomButtonWidget({
    super.key,
    required this.onTap,
    this.title,
    this.height = 48,
    this.width,
    this.color,
    this.borderColor,
    this.textStyle,
    this.stateNotifier,
    this.prefix,
    this.prefixPadding = const EdgeInsets.symmetric(horizontal: 10),
    this.suffix,
    this.suffixPadding = const EdgeInsets.symmetric(horizontal: 10),
    this.fontSize,
    this.borderRadius = 8,
    this.fontColor,
    this.buttonType = ButtonTypeEnum.normalButton,
    this.gradient,
  });

  final GestureTapCallback onTap;
  final double height;
  final double? width;
  final String? title;
  final Color? color;
  final Color? fontColor;
  final Color? borderColor;
  final TextStyle? textStyle;
  final ValueNotifier<ButtonStateEnum>? stateNotifier;
  final Widget? prefix;
  final Widget? suffix;
  final EdgeInsets prefixPadding;
  final EdgeInsets suffixPadding;
  final double? fontSize;
  final double borderRadius;
  final ButtonTypeEnum buttonType;
  final Gradient? gradient;

  @override
  Widget build(final BuildContext context) {
    final buttonColor = context.theme.buttonTheme.colorScheme?.primary;
    const textColor = Colors.black;

    return stateNotifier != null
        ? ValueListenableBuilder<ButtonStateEnum>(
            valueListenable: stateNotifier!,
            builder: (final context, final state, final notifierWidget) {
              return _buildButton(context, state, buttonColor, textColor);
            },
          )
        : _buildButton(context, ButtonStateEnum.idle, buttonColor, textColor);
  }

  Widget _buildButton(final BuildContext context, final ButtonStateEnum state,
      final Color? buttonColor, final Color textColor) {
    return Container(
      height: height,
      width: width ??
          (context.isLandScape ? context.screenWidth / 4 : context.screenWidth),
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? buttonColor : null,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          width: 1,
          color: borderColor ?? buttonColor!,
        ),
        boxShadow: _getShadow(context),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: state.isLoading ? () {} : onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: state.isLoading
              ? const Center(
                  child: SizedBox(
                    height: 28,
                    width: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.black,
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    prefix?.padding(prefixPadding) ??
                        const CustomSpacerWidget(),
                    CustomTextWidget(
                      title,
                      fontWeight: AppFontsWeightEnum.bold,
                      fontSize: fontSize ?? 16,
                      fontColor: fontColor ?? textColor,
                      style: textStyle ?? AppFonts.boldStyle(),
                    ),
                    if (suffix != null) const Spacer(),
                    suffix?.padding(suffixPadding) ??
                        const CustomSpacerWidget(),
                  ],
                ),
        ),
      ),
    );
  }

  List<BoxShadow> _getShadow(final BuildContext context) {
    return [
      BoxShadow(
        color: context.theme.shadowColor.withOpacity(0.05),
        blurRadius: 2,
        offset: const Offset(0, 1),
      )
    ];
  }
}
