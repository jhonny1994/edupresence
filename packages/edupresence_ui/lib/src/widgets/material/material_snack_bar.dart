import 'package:flutter/material.dart';

enum MaterialSnackBarType {
  info,
  success,
  error,
  warning,
}

class MaterialSnackBar extends StatelessWidget {
  const MaterialSnackBar({
    required this.message,
    super.key,
    this.type = MaterialSnackBarType.info,
    this.action,
    this.duration = const Duration(seconds: 4),
    this.onDismissed,
  });

  final String message;
  final MaterialSnackBarType type;
  final SnackBarAction? action;
  final Duration duration;
  final VoidCallback? onDismissed;

  static void show({
    required BuildContext context,
    required String message,
    MaterialSnackBarType type = MaterialSnackBarType.info,
    SnackBarAction? action,
    Duration? duration,
    VoidCallback? onDismissed,
  }) {
    final snackBar = MaterialSnackBar(
      message: message,
      type: type,
      action: action,
      duration: duration ?? const Duration(seconds: 4),
      onDismissed: onDismissed,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      snackBar._build(context),
    );
  }

  Color _getColor(ColorScheme colorScheme) {
    switch (type) {
      case MaterialSnackBarType.info:
        return colorScheme.primary;
      case MaterialSnackBarType.success:
        return Colors.green;
      case MaterialSnackBarType.error:
        return colorScheme.error;
      case MaterialSnackBarType.warning:
        return Colors.orange;
    }
  }

  IconData _getIcon() {
    switch (type) {
      case MaterialSnackBarType.info:
        return Icons.info_outline;
      case MaterialSnackBarType.success:
        return Icons.check_circle_outline;
      case MaterialSnackBarType.error:
        return Icons.error_outline;
      case MaterialSnackBarType.warning:
        return Icons.warning_amber_outlined;
    }
  }

  SnackBar _build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final color = _getColor(colorScheme);

    return SnackBar(
      content: Row(
        children: [
          Icon(
            _getIcon(),
            color: colorScheme.onSurface,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: color.withOpacity(0.1),
      duration: duration,
      action: action,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: color),
      ),
      dismissDirection: DismissDirection.horizontal,
      onVisible: () {
        if (duration != Duration.zero) {
          Future.delayed(duration, onDismissed ?? () {});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) => const SizedBox();
}
