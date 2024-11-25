import 'package:flutter/material.dart';

enum MaterialChipVariant {
  filled,
  outlined,
  tonal,
}

class MaterialChip extends StatelessWidget {
  const MaterialChip({
    required this.label,
    super.key,
    this.icon,
    this.onTap,
    this.onDelete,
    this.variant = MaterialChipVariant.filled,
    this.selected = false,
    this.enabled = true,
    this.color,
  });

  final Color? color;
  final bool enabled;
  final IconData? icon;
  final String label;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;
  final bool selected;
  final MaterialChipVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    Color backgroundColor;
    Color labelColor;
    Color? borderColor;

    switch (variant) {
      case MaterialChipVariant.filled:
        backgroundColor = selected
            ? color ?? colorScheme.primary
            : color?.withOpacity(0.1) ?? colorScheme.primary.withOpacity(0.1);
        labelColor =
            selected ? colorScheme.onPrimary : color ?? colorScheme.primary;
        borderColor = null;
      case MaterialChipVariant.outlined:
        backgroundColor = selected
            ? color?.withOpacity(0.1) ?? colorScheme.primary.withOpacity(0.1)
            : Colors.transparent;
        labelColor = color ?? colorScheme.primary;
        borderColor = color ?? colorScheme.primary;
      case MaterialChipVariant.tonal:
        backgroundColor = selected
            ? colorScheme.secondaryContainer
            : colorScheme.surfaceContainerHighest;
        labelColor = selected
            ? colorScheme.onSecondaryContainer
            : colorScheme.onSurfaceVariant;
        borderColor = null;
    }

    if (!enabled) {
      backgroundColor = colorScheme.surfaceContainerHighest.withOpacity(0.5);
      labelColor = colorScheme.onSurfaceVariant.withOpacity(0.38);
      borderColor = borderColor?.withOpacity(0.38);
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: borderColor != null ? Border.all(color: borderColor) : null,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: onDelete != null ? 8 : 12,
            vertical: 6,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 18,
                  color: labelColor,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: labelColor,
                ),
              ),
              if (onDelete != null) ...[
                const SizedBox(width: 4),
                InkWell(
                  onTap: enabled ? onDelete : null,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: labelColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
