import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sound_of_meme/core/app_fonts.dart';
import 'package:sound_of_meme/presentation/app/app.dart';
import '../../core/extensions/extensions.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final void Function(String)? onChange;
  final Widget? prefixWidget;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? suffixWidget;
  final double borderRadius;
  final String? hintText;
  final TextStyle? hintTextStyle;
  final TextStyle? style;
  final TextInputType keyboardType;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final bool isEnabled;
  final Function? onTapCallback;
  final int maxLines;
  final int minLines;
  final EdgeInsets contentPadding;
  final Color? fillColor;
  final void Function(bool)? focus;
  final String? Function(String?)? validator;
  final bool showFocusedBorder;
  final TextInputAction textInputAction;
  final bool obscureText;
  final String? labelText;
  final TextStyle? labelStyle;
  final InputDecoration? inputDecoration;
  final double cursorWidth;
  final bool filled;
  final bool isDense;
  final TextStyle? errorStyle;
  final Color? borderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final TextAlign textAlign;
  final String? initialValue;
  final int? maxLength;

  const CustomTextFieldWidget({
    super.key,
    this.labelText,
    this.suffix,
    this.labelStyle,
    this.controller,
    this.onChange,
    this.style,
    this.prefixWidget,
    this.borderRadius = 8,
    this.hintText,
    this.hintTextStyle,
    this.suffixWidget,
    this.isEnabled = true,
    this.onTapCallback,
    this.maxLines = 1,
    this.minLines = 1,
    this.contentPadding = const EdgeInsets.only(
      left: 22.0,
      top: 12.0,
      bottom: 12.0,
    ),
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.sentences,
    this.fillColor,
    this.focus,
    this.validator,
    this.showFocusedBorder = false,
    this.focusNode,
    this.prefix,
    this.textInputAction = TextInputAction.done,
    this.obscureText = false,
    this.inputDecoration,
    this.cursorWidth = 1,
    this.filled = true,
    this.isDense = true,
    this.errorStyle,
    this.borderColor,
    this.errorBorderColor,
    this.focusedBorderColor,
    this.initialValue,
    this.maxLength,
    this.textAlign = TextAlign.left,
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  late final FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    widget.focusNode?.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    _focusNode.hasFocus;
  }

  @override
  Widget build(final BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      initialValue: widget.initialValue,
      key: widget.key,
      focusNode: _focusNode,
      enabled: widget.isEnabled,
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      obscureText: widget.obscureText,
      onChanged: (final value) {
        widget.onChange?.call(value);
      },
      textAlignVertical: TextAlignVertical.center,
      style: widget.style ?? AppFonts.mediumStyle(
        fontColor: context.isDark
            ? context.theme.textTheme.bodyLarge?.color
            : context.theme.textTheme.bodyMedium?.color,
        fontSize: 14,
      ),
      textAlign: widget.textAlign,
      cursorWidth: widget.cursorWidth,
      textCapitalization: widget.textCapitalization,
      inputFormatters: widget.inputFormatters,
      keyboardType: widget.keyboardType,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      onTap: () {
        widget.onTapCallback?.call();
      },
      validator: widget.validator,
      decoration: widget.inputDecoration ??
          InputDecoration(
            labelStyle: widget.labelStyle,
            label: widget.labelText != null ? Text(widget.labelText!) : null,
            isDense: widget.isDense,
            contentPadding: widget.contentPadding,
            prefixIcon: widget.prefixWidget,
            hintStyle: widget.hintTextStyle ?? AppFonts.mediumStyle(
              fontColor: context.theme.hintColor,
            ),
            hintText: context.stringForKey(widget.hintText),
            errorStyle: widget.errorStyle,
            prefix: widget.prefix,
            suffix: widget.suffix,
            suffixIcon: widget.suffixWidget,
            filled: widget.filled,
            fillColor: widget.fillColor ?? context.theme.inputDecorationTheme.fillColor?.withOpacity(0.4),
            border: _getBorder(context),
            focusedBorder: widget.showFocusedBorder
                ? _getFocusedBorder(context)
                : _getBorder(context),
            enabledBorder: _getBorder(context),
            errorBorder: _getErrorBorder(context),
            disabledBorder: _getBorder(context),
          ),
    );
  }

  InputBorder? _getBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: widget.borderColor ?? Colors.transparent,
      ),
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );
  }

  OutlineInputBorder? _getFocusedBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: widget.focusedBorderColor ?? context.theme.colorScheme.primary,
      ),
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );
  }

  OutlineInputBorder? _getErrorBorder(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: widget.errorBorderColor ?? context.theme.colorScheme.error,
      ),
      borderRadius: BorderRadius.circular(widget.borderRadius),
    );
  }
}
