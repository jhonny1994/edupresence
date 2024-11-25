import 'package:fluent_ui/fluent_ui.dart';

/// A Fluent UI styled info bar.
class FluentInfoBar extends StatelessWidget {
  /// Creates a Fluent UI styled info bar.
  const FluentInfoBar({
    required this.title,
    required this.message,
    super.key,
    this.severity = InfoBarSeverity.info,
    this.action,
    this.onClose,
    this.isLong = false,
    this.style,
  });

  /// The title of the info bar.
  final String title;

  /// The message to display in the info bar.
  final String message;

  /// The severity of the info bar.
  final InfoBarSeverity severity;

  /// The action button to display.
  final Widget? action;

  /// Called when the close button is pressed.
  final VoidCallback? onClose;

  /// Whether the info bar should display a longer message.
  final bool isLong;

  /// Optional style customizations for the info bar.
  final InfoBarThemeData? style;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final defaultStyle = InfoBarThemeData.standard(theme);
    final effectiveStyle = style ?? defaultStyle;

    return InfoBar(
      title: Text(title),
      content: Text(message),
      severity: severity,
      action: action,
      isLong: isLong,
      onClose: onClose,
      style: effectiveStyle,
    );
  }
}
