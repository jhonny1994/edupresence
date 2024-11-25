import 'package:fluent_ui/fluent_ui.dart';

/// A Fluent UI styled dropdown button.
class FluentDropdown<T> extends StatelessWidget {
  /// Creates a Fluent UI styled dropdown button.
  const FluentDropdown({
    required this.items,
    required this.value,
    required this.onChanged,
    super.key,
    this.icon,
    this.textStyle,
    this.enabled = true,
    this.placeholder,
  });

  /// The list of items to display in the dropdown.
  final List<ComboBoxItem<T>> items;

  /// The currently selected value.
  final T value;

  /// Called when the user selects an item.
  final ValueChanged<T?>? onChanged;

  /// The icon to display next to the button.
  final Widget? icon;

  /// Optional text style customizations.
  final TextStyle? textStyle;

  /// Whether the dropdown is enabled.
  final bool enabled;

  /// Placeholder text to show when no item is selected.
  final String? placeholder;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final defaultTextStyle = TextStyle(
      color: enabled
          ? theme.resources.textFillColorPrimary
          : theme.resources.textFillColorDisabled,
    );

    return Container(
      decoration: BoxDecoration(
        color: enabled
            ? theme.resources.controlFillColorDefault
            : theme.resources.controlFillColorDisabled,
        border: Border.all(
          color: enabled
              ? theme.resources.controlStrokeColorDefault
              : theme.resources.controlStrokeColorDefault.withOpacity(0.3),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: ComboBox<T>(
        items: items,
        value: value,
        onChanged: enabled ? onChanged : null,
        icon: icon ?? const Icon(FluentIcons.chevron_down, size: 16),
        style: textStyle ?? defaultTextStyle,
        placeholder: placeholder != null ? Text(placeholder!) : null,
        isExpanded: true,
      ),
    );
  }
}

/// Helper functions for creating dropdown buttons.
class FluentDropdownBuilder {
  /// Creates a dropdown with a list of items.
  static FluentDropdown<T> withItems<T>({
    required List<T> items,
    required T value,
    required ValueChanged<T?>? onChanged,
    required String Function(T item) labelBuilder,
    Widget? icon,
    TextStyle? textStyle,
    bool enabled = true,
    String? placeholder,
  }) {
    return FluentDropdown<T>(
      items: items.map((item) {
        return ComboBoxItem<T>(
          value: item,
          child: Text(labelBuilder(item)),
        );
      }).toList(),
      value: value,
      onChanged: onChanged,
      icon: icon,
      textStyle: textStyle,
      enabled: enabled,
      placeholder: placeholder,
    );
  }

  /// Creates a dropdown from an enum.
  static FluentDropdown<T> withEnum<T extends Enum>({
    required List<T> items,
    required T value,
    required ValueChanged<T?>? onChanged,
    String Function(T item)? labelBuilder,
    Widget? icon,
    TextStyle? textStyle,
    bool enabled = true,
    String? placeholder,
  }) {
    return FluentDropdown<T>(
      items: items.map((item) {
        return ComboBoxItem<T>(
          value: item,
          child: Text(labelBuilder?.call(item) ?? item.name),
        );
      }).toList(),
      value: value,
      onChanged: onChanged,
      icon: icon,
      textStyle: textStyle,
      enabled: enabled,
      placeholder: placeholder,
    );
  }
}
