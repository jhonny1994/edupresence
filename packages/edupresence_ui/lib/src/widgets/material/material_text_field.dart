import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialTextField extends StatelessWidget {
  const MaterialTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
    this.minLines,
    this.expands = false,
    this.textCapitalization = TextCapitalization.none,
    this.contentPadding,
    this.autofocus = false,
    this.focusNode,
  });
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final VoidCallback? onTap;
  final bool readOnly;
  final Widget? prefix;
  final Widget? suffix;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final TextCapitalization textCapitalization;
  final EdgeInsets? contentPadding;
  final bool autofocus;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        errorText: errorText,
        prefixIcon: prefix,
        suffixIcon: suffix,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: colorScheme.error, width: 2),
        ),
        filled: true,
        fillColor: theme.brightness == Brightness.dark
            ? colorScheme.surfaceContainerHighest.withOpacity(0.1)
            : colorScheme.surface,
      ),
      style: theme.textTheme.bodyLarge,
      obscureText: obscureText,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      validator: validator,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      minLines: minLines,
      expands: expands,
      textCapitalization: textCapitalization,
      autofocus: autofocus,
      focusNode: focusNode,
    );
  }
}
