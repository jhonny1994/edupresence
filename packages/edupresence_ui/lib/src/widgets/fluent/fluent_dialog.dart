import 'package:fluent_ui/fluent_ui.dart';

/// A Fluent UI styled dialog.
class FluentDialog extends StatelessWidget {
  /// Creates a Fluent UI styled dialog.
  const FluentDialog({
    required this.title,
    required this.content,
    super.key,
    this.actions,
    this.closeButtonLabel = 'Close',
    this.barrierDismissible = true,
    this.style,
  });

  /// The title of the dialog.
  final String title;

  /// The content of the dialog.
  final Widget content;

  /// The actions to display at the bottom of the dialog.
  final List<Widget>? actions;

  /// The label for the close button.
  final String closeButtonLabel;

  /// Whether the dialog can be dismissed by tapping outside it.
  final bool barrierDismissible;

  /// Optional style customizations for the dialog.
  final ContentDialogThemeData? style;

  /// Shows a Fluent UI styled dialog.
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions,
    String closeButtonLabel = 'Close',
    bool barrierDismissible = true,
    ContentDialogThemeData? style,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => FluentDialog(
        title: title,
        content: content,
        actions: actions,
        closeButtonLabel: closeButtonLabel,
        barrierDismissible: barrierDismissible,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final effectiveStyle = style ?? ContentDialogThemeData.standard(theme);

    return ContentDialog(
      title: Text(
        title,
        style: theme.typography.title,
      ),
      content: content,
      actions: [
        ...?actions,
        Button(
          child: Text(closeButtonLabel),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      style: effectiveStyle,
    );
  }
}

/// Extension methods for FluentDialog.
extension FluentDialogExtensions on FluentDialog {
  /// Shows an error dialog.
  static Future<void> showError({
    required BuildContext context,
    required String title,
    required String message,
    String closeButtonLabel = 'Close',
    VoidCallback? onRetry,
  }) {
    return FluentDialog.show(
      context: context,
      title: title,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
      closeButtonLabel: closeButtonLabel,
    );
  }

  /// Shows a confirmation dialog.
  static Future<bool?> showConfirmation({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'Yes',
    String cancelLabel = 'No',
  }) {
    return FluentDialog.show<bool>(
      context: context,
      title: title,
      content: Text(message),
      actions: [
        Button(
          child: Text(cancelLabel),
          onPressed: () => Navigator.of(context).pop(false),
        ),
        FilledButton(
          child: Text(confirmLabel),
          onPressed: () => Navigator.of(context).pop(true),
        ),
      ],
    );
  }

  /// Shows a success dialog.
  static Future<void> showSuccess({
    required BuildContext context,
    required String title,
    required String message,
    String closeButtonLabel = 'Close',
  }) {
    return FluentDialog.show(
      context: context,
      title: title,
      content: Text(message),
      closeButtonLabel: closeButtonLabel,
    );
  }
}
