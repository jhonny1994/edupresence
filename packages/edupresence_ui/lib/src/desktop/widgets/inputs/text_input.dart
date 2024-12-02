import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:fluent_ui/fluent_ui.dart';

/// Desktop text input sizes
enum DesktopTextInputSize {
  /// Small input
  small,

  /// Medium input
  medium,

  /// Large input
  large,
}

/// Desktop text input widget
class DesktopTextInput extends StatelessWidget {
  /// Creates a desktop text input
  const DesktopTextInput({
    required this.controller,
    this.label,
    this.placeholder,
    this.error,
    this.size = DesktopTextInputSize.medium,
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
  final DesktopTextInputSize size;

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
          child: TextBox(
            controller: controller,
            placeholder: placeholder,
            enabled: !disabled,
            obscureText: obscureText,
            keyboardType: keyboardType,
            maxLines: maxLines,
            minLines: minLines,
            maxLength: maxLength,
            prefix: prefixIcon,
            suffix: suffixIcon,
            onChanged: onChanged,
            onSubmitted: onSubmitted,
            decoration: BoxDecoration(
              border: Border.all(
                color: error != null
                    ? AppColors.error
                    : disabled
                        ? AppColors.border.withOpacity(0.5)
                        : AppColors.border,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            style: TextStyle(
              color: disabled
                  ? AppColors.textPrimary.withOpacity(0.5)
                  : AppColors.textPrimary,
            ),
            placeholderStyle: TextStyle(
              color: disabled
                  ? AppColors.textHint.withOpacity(0.5)
                  : AppColors.textHint,
            ),
          ),
        ),
        if (error != null) ...[
          const SizedBox(height: 4),
          Text(
            error!,
            style: const TextStyle(
              color: AppColors.error,
              fontSize: 12,
            ),
          ),
        ],
      ],
    );
  }

  double _getInputSize() {
    switch (size) {
      case DesktopTextInputSize.small:
        return 32;
      case DesktopTextInputSize.medium:
        return 40;
      case DesktopTextInputSize.large:
        return 48;
    }
  }
}
