import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
//-------------------------------------
import 'package:social_x/core/ui/colors.dart';
import 'package:social_x/core/helpers/extensions//themes_helper.dart';
//--------------------------------------------------------------------

class XTextField extends StatelessWidget {
  final bool secret;

  /// determines if this is a multiline text field.
  final bool textArea;

  final bool allowDigitsOnly;
  final bool preventWhiteSpaces;

  final double? borderRadius;
  final int? minLines;
  final String errorText;
  final String hintText;

  final TextInputType inputType;

  final TextEditingController? controller;
  final FocusNode? focusNode;

  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final Color? textColor;
  final Widget? suffix;
  final Widget? prefix;

  const XTextField({
    super.key,
    this.borderRadius,
    this.minLines = 1,
    this.secret = false,
    this.textColor,
    this.fillColor,
    this.textArea = false,
    this.allowDigitsOnly = false,
    this.preventWhiteSpaces = false,
    this.errorText = "",
    this.hintText = "",
    this.inputType = TextInputType.text,
    this.focusNode,
    this.controller,
    this.onChanged,
    this.prefix,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: false,
      focusNode: focusNode,
      controller: controller,
      obscureText: secret,
      keyboardType: textArea ? TextInputType.multiline : inputType,
      minLines: textArea ? 3 : minLines,
      maxLines: textArea ? null : 1,
      style: TextStyle(
        height: 1.25,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: textColor ?? Theme.of(context).colorScheme.secondary,
      ),
      cursorWidth: 1.5,
      cursorColor: Theme.of(context).colorScheme.secondary,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        fillColor: fillColor ??
            (context.darkMoodEnabled
                ? AppColors.bgBlack
                : const Color(0xffF3F5F7)),
        hintText: hintText,
        hintStyle: TextStyle(
          height: 1.25,
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: textColor ??
              Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        ),
        errorText: errorText.isEmpty ? null : errorText,
        errorStyle: TextStyle(
          height: 1.0,
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.error,
        ),
        contentPadding: const EdgeInsets.all(16.0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(borderRadius ?? 16.0),
        ),
        suffixIcon: suffix,
        prefixIcon: prefix,
      ),
      inputFormatters: [
        if (allowDigitsOnly) FilteringTextInputFormatter.digitsOnly,
        if (preventWhiteSpaces) ...[
          FilteringTextInputFormatter.deny(RegExp(r"\s\b|\b\s")),
          FilteringTextInputFormatter.deny(" "),
        ],
        if (inputType == TextInputType.phone) ...[
          LengthLimitingTextInputFormatter(11),
          FilteringTextInputFormatter(" ", allow: false),
        ],
      ],
    );
  }
}
