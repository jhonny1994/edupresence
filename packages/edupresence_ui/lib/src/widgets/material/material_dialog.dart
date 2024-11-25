import 'package:flutter/material.dart';

enum MaterialDialogType {
  info,
  success,
  error,
  warning,
}

class MaterialDialog extends StatelessWidget {
  const MaterialDialog({
    required this.title,
    required this.message,
    super.key,
    this.type = MaterialDialogType.info,
    this.actions,
    this.onClose,
    this.barrierDismissible = true,
  });
  final String title;
  final String message;
  final MaterialDialogType type;
  final List<Widget>? actions;
  final VoidCallback? onClose;
  final bool barrierDismissible;

  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required String message,
    MaterialDialogType type = MaterialDialogType.info,
    List<Widget>? actions,
    VoidCallback? onClose,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => MaterialDialog(
        title: title,
        message: message,
        type: type,
        actions: actions,
        onClose: onClose,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  IconData _getIcon() {
    switch (type) {
      case MaterialDialogType.info:
        return Icons.info_outline;
      case MaterialDialogType.success:
        return Icons.check_circle_outline;
      case MaterialDialogType.error:
        return Icons.error_outline;
      case MaterialDialogType.warning:
        return Icons.warning_amber_outlined;
    }
  }

  Color _getColor(ColorScheme colorScheme) {
    switch (type) {
      case MaterialDialogType.info:
        return colorScheme.primary;
      case MaterialDialogType.success:
        return Colors.green;
      case MaterialDialogType.error:
        return colorScheme.error;
      case MaterialDialogType.warning:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = _getColor(colorScheme);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Row(
        children: [
          Icon(_getIcon(), color: color),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
          if (barrierDismissible)
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop();
                onClose?.call();
              },
              color: colorScheme.onSurfaceVariant,
            ),
        ],
      ),
      content: Text(
        message,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      actions: actions ??
          [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onClose?.call();
              },
              child: const Text('OK'),
            ),
          ],
      backgroundColor: colorScheme.surface,
    );
  }
}
