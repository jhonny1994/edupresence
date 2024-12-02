import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:flutter/material.dart';

/// Mobile text input sizes
enum MobileTextInputSize {
  /// Small input
  small,

  /// Medium input
  medium,

  /// Large input
  large,
}

/// Mobile text input widget
class MobileTextInput extends StatelessWidget {
  /// Creates a mobile text input
  const MobileTextInput({
    required this.controller,
    this.label,
    this.placeholder,
    this.error,
    this.size = MobileTextInputSize.medium,
    this.disabled = false,
    this.obscureText = false,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
    this.onSubmitted,
    super.key,
  });

  /// The text editing controller
  final TextEditingController controller;

  /// The input's label
  final String? label;

  /// The input's placeholder
  final String? placeholder;

  /// The input's error message
  final String? error;

  /// The input's size
  final MobileTextInputSize size;

  /// Whether the input is disabled
  final bool disabled;

  /// Whether to obscure the text
  final bool obscureText;

  /// The keyboard type
  final TextInputType? keyboardType;

  /// The maximum number of lines
  final int? maxLines;

  /// The minimum number of lines
  final int? minLines;

  /// The maximum length of the input
  final int? maxLength;

  /// The input's prefix icon
  final Widget? prefixIcon;

  /// The input's suffix icon
  final Widget? suffixIcon;

  /// Called when the text changes
  final ValueChanged<String>? onChanged;

  /// Called when the text is submitted
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    final inputSize = _getInputSize();
    final contentPadding = _getContentPadding();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
        ],
        SizedBox(
          height: inputSize,
          child: TextField(
            controller: controller,
            enabled: !disabled,
            obscureText: obscureText,
            keyboardType: keyboardType,
            maxLines: maxLines,
            minLines: minLines,
            maxLength: maxLength,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(
              hintText: placeholder,
              errorText: error,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              contentPadding: contentPadding,
              filled: true,
              fillColor: disabled
                  ? AppColors.surface.withOpacity(0.5)
                  : AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: error != null ? AppColors.error : AppColors.border,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.error),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.error),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: AppColors.border.withOpacity(0.5),
                ),
              ),
            ),
            style: TextStyle(
              color: disabled
                  ? AppColors.textPrimary.withOpacity(0.5)
                  : AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  double _getInputSize() {
    switch (size) {
      case MobileTextInputSize.small:
        return 32;
      case MobileTextInputSize.medium:
        return 40;
      case MobileTextInputSize.large:
        return 48;
    }
  }

  EdgeInsetsGeometry _getContentPadding() {
    switch (size) {
      case MobileTextInputSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case MobileTextInputSize.medium:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
      case MobileTextInputSize.large:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 14);
    }
  }
}
