import 'package:flutter/material.dart';

class MaterialCard extends StatelessWidget {
  const MaterialCard({
    required this.child,
    super.key,
    this.padding,
    this.color,
    this.elevation = 1,
    this.onTap,
    this.borderRadius,
    this.selected = false,
  });

  final BorderRadius? borderRadius;
  final Widget child;
  final Color? color;
  final double elevation;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: color ??
                (selected ? colorScheme.primaryContainer : colorScheme.surface),
            borderRadius: borderRadius ?? BorderRadius.circular(12),
            border: Border.all(
              color: selected
                  ? colorScheme.primary
                  : colorScheme.outline.withOpacity(0.2),
              width: selected ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: elevation * 4,
                offset: Offset(0, elevation * 2),
              ),
            ],
          ),
          padding: padding ?? const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}
