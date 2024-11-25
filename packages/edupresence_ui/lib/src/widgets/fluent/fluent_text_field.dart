import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';

/// A Fluent UI styled text field.
class FluentTextField extends StatelessWidget {
  /// Creates a Fluent UI styled text field.
  const FluentTextField({
    super.key,
    this.controller,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.style,
    this.textAlign = TextAlign.start,
    this.textAlignVertical,
    this.readOnly = false,
    this.showCursor,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.maxLength,
    this.onChanged,
    this.onSubmitted,
    this.inputFormatters,
    this.enabled = true,
    this.cursorWidth = 2.0,
    this.cursorHeight,
    this.cursorRadius = const Radius.circular(2),
    this.cursorColor,
    this.scrollPadding = const EdgeInsets.all(20),
    this.scrollController,
    this.scrollPhysics,
    this.contentPadding = const EdgeInsets.all(8),
    this.prefix,
    this.suffix,
    this.header,
    this.placeholder,
    this.errorText,
  });

  /// Controls the text being edited.
  final TextEditingController? controller;

  /// Defines the keyboard focus for this widget.
  final FocusNode? focusNode;

  /// The type of keyboard to use for editing the text.
  final TextInputType? keyboardType;

  /// The type of action button to show on the keyboard.
  final TextInputAction? textInputAction;

  /// The style to use for the text being edited.
  final TextStyle? style;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// How the text should be aligned vertically.
  final TextAlignVertical? textAlignVertical;

  /// Whether the text can be changed.
  final bool readOnly;

  /// Whether to show cursor.
  final bool? showCursor;

  /// Whether this text field should focus itself if nothing else is already focused.
  final bool autofocus;

  /// Whether to hide the text being edited.
  final bool obscureText;

  /// Whether to enable autocorrection.
  final bool autocorrect;

  /// Whether to show input suggestions.
  final bool enableSuggestions;

  /// The maximum number of lines for the text to span.
  final int? maxLines;

  /// The minimum number of lines for the text to span.
  final int? minLines;

  /// Whether this widget's height will be sized to fill its parent.
  final bool expands;

  /// The maximum number of characters to allow in the text field.
  final int? maxLength;

  /// Called when the user initiates a change to the text field's value.
  final ValueChanged<String>? onChanged;

  /// Called when the user indicates that they are done editing the text in the field.
  final ValueChanged<String>? onSubmitted;

  /// Optional input validation and formatting overrides.
  final List<TextInputFormatter>? inputFormatters;

  /// Whether the text field is enabled.
  final bool enabled;

  /// How thick the cursor will be.
  final double cursorWidth;

  /// How tall the cursor will be.
  final double? cursorHeight;

  /// How rounded the corners of the cursor should be.
  final Radius cursorRadius;

  /// The color of the cursor.
  final Color? cursorColor;

  /// The padding of the scroll view around the field.
  final EdgeInsets scrollPadding;

  /// The scrollController for the text field.
  final ScrollController? scrollController;

  /// The physics for the text field's scroll view.
  final ScrollPhysics? scrollPhysics;

  /// The padding around the content of the text field.
  final EdgeInsetsGeometry contentPadding;

  /// A widget to display before the text field.
  final Widget? prefix;

  /// A widget to display after the text field.
  final Widget? suffix;

  /// The header text to display above the text field.
  final String? header;

  /// The placeholder text to display when the text field is empty.
  final String? placeholder;

  /// The error text to display below the text field.
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (header != null) ...[
          Text(
            header!,
            style: theme.typography.body?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
        ],
        TextBox(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          style: style ?? theme.typography.body,
          textAlign: textAlign,
          textAlignVertical: textAlignVertical,
          readOnly: readOnly,
          showCursor: showCursor,
          autofocus: autofocus,
          obscureText: obscureText,
          autocorrect: autocorrect,
          enableSuggestions: enableSuggestions,
          maxLines: maxLines,
          minLines: minLines,
          expands: expands,
          maxLength: maxLength,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          inputFormatters: inputFormatters,
          enabled: enabled,
          cursorWidth: cursorWidth,
          cursorHeight: cursorHeight,
          cursorRadius: cursorRadius,
          cursorColor: cursorColor ?? theme.accentColor,
          scrollPadding: scrollPadding,
          scrollController: scrollController,
          scrollPhysics: scrollPhysics,
          padding: contentPadding,
          prefix: prefix,
          suffix: suffix,
          placeholder: placeholder,
          placeholderStyle: theme.typography.caption?.copyWith(
            color: theme.resources.textFillColorDisabled,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: enabled
                  ? theme.resources.controlStrokeColorDefault
                  : theme.resources.controlStrokeColorDefault.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          foregroundDecoration: errorText != null
              ? BoxDecoration(
                  border: Border.all(
                    color: theme.resources.systemFillColorCritical,
                  ),
                  borderRadius: BorderRadius.circular(4),
                )
              : null,
        ),
        if (errorText != null) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: theme.typography.caption?.copyWith(
              color: theme.resources.systemFillColorCritical,
            ),
          ),
        ],
      ],
    );
  }
}
