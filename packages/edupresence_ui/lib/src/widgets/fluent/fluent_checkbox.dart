import 'package:fluent_ui/fluent_ui.dart';

/// A Fluent UI styled checkbox.
class FluentCheckbox extends StatelessWidget {
  /// Creates a Fluent UI styled checkbox.
  const FluentCheckbox({
    required this.checked,
    required this.onChanged,
    super.key,
    this.content,
    this.enabled = true,
    this.style,
    this.semanticLabel,
  });

  /// Whether this checkbox is checked.
  final bool checked;

  /// Called when the value of the checkbox should change.
  final ValueChanged<bool>? onChanged;

  /// The content to display next to the checkbox.
  final Widget? content;

  /// Whether the checkbox is enabled.
  final bool enabled;

  /// Optional style customizations for the checkbox.
  final CheckboxThemeData? style;

  /// The semantic label for this checkbox.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final effectiveStyle = style ?? CheckboxThemeData.standard(theme);

    return Checkbox(
      checked: checked,
      onChanged: enabled ? (value) => onChanged?.call(value ?? false) : null,
      content: content,
      style: effectiveStyle.merge(
        CheckboxThemeData(
          checkedDecoration: WidgetStateProperty.resolveWith((states) {
            if (!enabled) {
              return BoxDecoration(
                color: theme.resources.controlFillColorDisabled,
                border: Border.all(
                  color: theme.resources.controlStrokeColorDefault
                      .withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(4),
              );
            }
            if (states.isPressed) {
              return BoxDecoration(
                color: theme.resources.controlFillColorSecondary,
                border: Border.all(
                  color: theme.resources.controlStrokeColorDefault,
                ),
                borderRadius: BorderRadius.circular(4),
              );
            }
            if (states.isHovered) {
              return BoxDecoration(
                color: theme.resources.controlFillColorTertiary,
                border: Border.all(
                  color: theme.resources.controlStrokeColorDefault,
                ),
                borderRadius: BorderRadius.circular(4),
              );
            }
            return BoxDecoration(
              color: theme.resources.controlFillColorDefault,
              border: Border.all(
                color: theme.resources.controlStrokeColorDefault,
              ),
              borderRadius: BorderRadius.circular(4),
            );
          }),
          uncheckedDecoration: WidgetStateProperty.resolveWith((states) {
            if (!enabled) {
              return BoxDecoration(
                color: theme.resources.controlFillColorDisabled,
                border: Border.all(
                  color: theme.resources.controlStrokeColorDefault
                      .withOpacity(0.3),
                ),
                borderRadius: BorderRadius.circular(4),
              );
            }
            if (states.isPressed) {
              return BoxDecoration(
                color: theme.resources.controlFillColorSecondary,
                border: Border.all(
                  color: theme.resources.controlStrokeColorDefault,
                ),
                borderRadius: BorderRadius.circular(4),
              );
            }
            if (states.isHovered) {
              return BoxDecoration(
                color: theme.resources.controlFillColorTertiary,
                border: Border.all(
                  color: theme.resources.controlStrokeColorDefault,
                ),
                borderRadius: BorderRadius.circular(4),
              );
            }
            return BoxDecoration(
              color: theme.resources.controlFillColorDefault,
              border: Border.all(
                color: theme.resources.controlStrokeColorDefault,
              ),
              borderRadius: BorderRadius.circular(4),
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

/// Extension methods for FluentCheckbox.
extension FluentCheckboxExtensions on FluentCheckbox {
  /// Creates a checkbox with a text label.
  static FluentCheckbox withLabel({
    required bool checked,
    required ValueChanged<bool>? onChanged,
    required String label,
    bool enabled = true,
    CheckboxThemeData? style,
    String? semanticLabel,
  }) {
    return FluentCheckbox(
      checked: checked,
      onChanged: onChanged,
      content: Text(label),
      enabled: enabled,
      style: style,
      semanticLabel: semanticLabel ?? label,
    );
  }

  /// Creates a group of checkboxes from a list of items.
  static List<FluentCheckbox> group<T>({
    required List<T> items,
    required Set<T> selectedItems,
    required ValueChanged<Set<T>> onChanged,
    required String Function(T item) labelBuilder,
    bool enabled = true,
    CheckboxThemeData? style,
  }) {
    return items.map((item) {
      final isSelected = selectedItems.contains(item);
      return FluentCheckbox(
        checked: isSelected,
        onChanged: enabled
            ? (checked) {
                final newSelection = Set<T>.from(selectedItems);
                if (checked) {
                  newSelection.add(item);
                } else {
                  newSelection.remove(item);
                }
                onChanged(newSelection);
              }
            : null,
        content: Text(labelBuilder(item)),
        enabled: enabled,
        style: style,
        semanticLabel: labelBuilder(item),
      );
    }).toList();
  }
}
