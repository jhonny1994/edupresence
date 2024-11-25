import 'package:flutter/material.dart';

enum MaterialButtonVariant {
  primary,
  secondary,
  text,
  outlined,
}

class MaterialButton extends StatelessWidget {
  const MaterialButton({
    required this.text,
    super.key,
    this.onPressed,
    this.variant = MaterialButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = false,
    this.icon,
    this.width,
    this.height,
  });

  final String text;
  final VoidCallback? onPressed;
  final MaterialButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Widget buttonChild = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18),
          const SizedBox(width: 8),
        ],
        Text(text),
      ],
    );

    if (isLoading) {
      buttonChild = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == MaterialButtonVariant.primary
                    ? Colors.white
                    : colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      );
    }

    Widget button;
    switch (variant) {
      case MaterialButtonVariant.primary:
        button = FilledButton(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: buttonChild,
        );
      case MaterialButtonVariant.secondary:
        button = FilledButton.tonal(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.secondaryContainer,
            foregroundColor: colorScheme.onSecondaryContainer,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: buttonChild,
        );
      case MaterialButtonVariant.text:
        button = TextButton(
          onPressed: isLoading ? null : onPressed,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: buttonChild,
        );
      case MaterialButtonVariant.outlined:
        button = OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          child: buttonChild,
        );
    }

    if (width != null || height != null || isFullWidth) {
      button = SizedBox(
        width: isFullWidth ? double.infinity : width,
        height: height,
        child: button,
      );
    }

    return button;
  }
}
