import 'package:flutter/material.dart';

enum MaterialLoadingSize {
  small,
  medium,
  large,
}

class MaterialLoading extends StatelessWidget {
  const MaterialLoading({
    super.key,
    this.message,
    this.size = MaterialLoadingSize.medium,
    this.color,
    this.backgroundColor,
    this.strokeWidth,
  });

  final String? message;
  final MaterialLoadingSize size;
  final Color? color;
  final Color? backgroundColor;
  final double? strokeWidth;

  double _getSize() {
    switch (size) {
      case MaterialLoadingSize.small:
        return 16;
      case MaterialLoadingSize.medium:
        return 24;
      case MaterialLoadingSize.large:
        return 32;
    }
  }

  double _getStrokeWidth() {
    switch (size) {
      case MaterialLoadingSize.small:
        return strokeWidth ?? 2;
      case MaterialLoadingSize.medium:
        return strokeWidth ?? 3;
      case MaterialLoadingSize.large:
        return strokeWidth ?? 4;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: _getSize(),
          height: _getSize(),
          child: CircularProgressIndicator(
            strokeWidth: _getStrokeWidth(),
            valueColor: AlwaysStoppedAnimation<Color>(
              color ?? colorScheme.primary,
            ),
            backgroundColor:
                backgroundColor ?? colorScheme.surfaceContainerHighest,
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 16),
          Text(
            message!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
