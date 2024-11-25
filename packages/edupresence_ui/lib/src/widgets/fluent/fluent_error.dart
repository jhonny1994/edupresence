import 'package:fluent_ui/fluent_ui.dart';

/// A Fluent UI styled error display.
class FluentError extends StatelessWidget {
  /// Creates a Fluent UI styled error display.
  const FluentError({
    required this.message,
    super.key,
    this.onRetry,
    this.icon,
    this.retryText = 'Retry',
  });

  /// The error message to display.
  final String message;

  /// Called when the user taps the retry button.
  final VoidCallback? onRetry;

  /// The icon to display.
  final IconData? icon;

  /// The text to display on the retry button.
  final String retryText;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon ?? FluentIcons.error_badge,
          size: 48,
          color: theme.resources.systemFillColorCritical,
        ),
        const SizedBox(height: 16),
        Text(
          message,
          style: theme.typography.body,
          textAlign: TextAlign.center,
        ),
        if (onRetry != null) ...[
          const SizedBox(height: 16),
          FilledButton(
            onPressed: onRetry,
            child: Text(retryText),
          ),
        ],
      ],
    );
  }
}
