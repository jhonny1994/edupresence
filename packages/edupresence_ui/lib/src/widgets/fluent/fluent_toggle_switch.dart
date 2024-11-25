import 'package:fluent_ui/fluent_ui.dart';

/// A Fluent UI styled toggle switch.
class FluentToggleSwitch extends StatelessWidget {
  /// Creates a Fluent UI styled toggle switch.
  const FluentToggleSwitch({
    required this.checked,
    required this.onChanged,
    super.key,
    this.content,
    this.enabled = true,
    this.style,
    this.semanticLabel,
  });

  /// Whether the toggle switch is checked.
  final bool checked;

  /// Called when the value of the toggle switch should change.
  final ValueChanged<bool>? onChanged;

  /// The content to display next to the toggle switch.
  final Widget? content;

  /// Whether the toggle switch is enabled.
  final bool enabled;

  /// Optional style customizations.
  final ToggleSwitchThemeData? style;

  /// The semantic label for this toggle switch.
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return ToggleSwitch(
      checked: checked,
      onChanged: enabled ? onChanged : null,
      content: content,
      style: style ?? ToggleSwitchThemeData.standard(theme),
      semanticLabel: semanticLabel,
    );
  }
}

/// Helper functions for creating toggle switches.
class FluentToggleSwitchBuilder {
  /// Creates a toggle switch with a text label.
  static FluentToggleSwitch withLabel({
    required bool checked,
    required ValueChanged<bool>? onChanged,
    required String label,
    bool enabled = true,
    ToggleSwitchThemeData? style,
    String? semanticLabel,
  }) {
    return FluentToggleSwitch(
      checked: checked,
      onChanged: onChanged,
      content: Text(label),
      enabled: enabled,
      style: style,
      semanticLabel: semanticLabel ?? label,
    );
  }
}
