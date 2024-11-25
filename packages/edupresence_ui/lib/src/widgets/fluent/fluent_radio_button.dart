import 'package:fluent_ui/fluent_ui.dart';

/// A Fluent UI styled radio button.
class FluentRadioButton<T> extends StatelessWidget {
  /// Creates a Fluent UI styled radio button.
  const FluentRadioButton({
    required this.checked,
    required this.value,
    required this.onChanged,
    super.key,
    this.content,
    this.enabled = true,
    this.style,
    this.semanticLabel,
  });

  /// Whether this radio button is checked.
  final bool checked;

  /// The value represented by this radio button.
  final T value;

  /// Called when the value of the radio button should change.
  final ValueChanged<T>? onChanged;

  /// The content to display next to the radio button.
  final Widget? content;

  /// Whether the radio button is enabled.
  final bool enabled;

  /// Optional style customizations for the radio button.
  final RadioButtonThemeData? style;

  /// The semantic label for this radio button.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final effectiveStyle = style ?? RadioButtonThemeData.standard(theme);

    return RadioButton(
      checked: checked,
      onChanged: enabled ? (value) => onChanged?.call(this.value) : null,
      content: content,
      style: effectiveStyle.merge(
        RadioButtonThemeData(
          checkedDecoration: WidgetStateProperty.resolveWith((states) {
            if (!enabled) {
              return BoxDecoration(
                color: theme.resources.controlFillColorDisabled,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.resources.controlStrokeColorDefault
                      .withOpacity(0.3),
                ),
              );
            }
            if (states.isPressed) {
              return BoxDecoration(
                color: theme.resources.controlFillColorSecondary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.resources.controlStrokeColorDefault,
                ),
              );
            }
            if (states.isHovered) {
              return BoxDecoration(
                color: theme.resources.controlFillColorTertiary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.resources.controlStrokeColorDefault,
                ),
              );
            }
            return BoxDecoration(
              color: theme.resources.controlFillColorDefault,
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.resources.controlStrokeColorDefault,
              ),
            );
          }),
          uncheckedDecoration: WidgetStateProperty.resolveWith((states) {
            if (!enabled) {
              return BoxDecoration(
                color: theme.resources.controlFillColorDisabled,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.resources.controlStrokeColorDefault
                      .withOpacity(0.3),
                ),
              );
            }
            if (states.isPressed) {
              return BoxDecoration(
                color: theme.resources.controlFillColorSecondary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.resources.controlStrokeColorDefault,
                ),
              );
            }
            if (states.isHovered) {
              return BoxDecoration(
                color: theme.resources.controlFillColorTertiary,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.resources.controlStrokeColorDefault,
                ),
              );
            }
            return BoxDecoration(
              color: theme.resources.controlFillColorDefault,
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.resources.controlStrokeColorDefault,
              ),
            );
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (!enabled) {
              return theme.resources.textFillColorDisabled;
            }
            return theme.resources.textFillColorPrimary;
          }),
        ),
      ),
      semanticLabel: semanticLabel,
    );
  }
}

/// Helper functions for creating radio buttons.
class FluentRadioButtonBuilder {
  /// Creates a radio button with a text label.
  static FluentRadioButton<T> withLabel<T>({
    required bool checked,
    required T value,
    required ValueChanged<T>? onChanged,
    required String label,
    bool enabled = true,
    RadioButtonThemeData? style,
    String? semanticLabel,
  }) {
    return FluentRadioButton<T>(
      checked: checked,
      value: value,
      onChanged: onChanged,
      content: Text(label),
      enabled: enabled,
      style: style,
      semanticLabel: semanticLabel ?? label,
    );
  }

  /// Creates a group of radio buttons from a list of items.
  static List<FluentRadioButton<T>> group<T>({
    required List<T> items,
    required T selectedItem,
    required ValueChanged<T> onChanged,
    required String Function(T item) labelBuilder,
    bool enabled = true,
    RadioButtonThemeData? style,
  }) {
    return items.map((item) {
      return FluentRadioButton<T>(
        checked: item == selectedItem,
        value: item,
        onChanged: enabled ? onChanged : null,
        content: Text(labelBuilder(item)),
        enabled: enabled,
        style: style,
        semanticLabel: labelBuilder(item),
      );
    }).toList();
  }
}
