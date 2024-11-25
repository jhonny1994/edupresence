import 'package:flutter/material.dart';

class MaterialListTile extends StatelessWidget {
  const MaterialListTile({
    required this.title,
    super.key,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.selected = false,
    this.enabled = true,
    this.dense = false,
    this.contentPadding,
    this.backgroundColor,
    this.borderRadius,
  });
  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool selected;
  final bool enabled;
  final bool dense;
  final EdgeInsetsGeometry? contentPadding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor ??
                (selected ? colorScheme.primaryContainer : Colors.transparent),
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            border: Border.all(
              color: selected ? colorScheme.primary : Colors.transparent,
              width: selected ? 1 : 0,
            ),
          ),
          child: ListTile(
            title: Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: enabled
                    ? colorScheme.onSurface
                    : colorScheme.onSurface.withOpacity(0.38),
              ),
            ),
            subtitle: subtitle != null
                ? Text(
                    subtitle!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: enabled
                          ? colorScheme.onSurfaceVariant
                          : colorScheme.onSurfaceVariant.withOpacity(0.38),
                    ),
                  )
                : null,
            leading: leading != null
                ? IconTheme(
                    data: IconThemeData(
                      color: enabled
                          ? colorScheme.onSurfaceVariant
                          : colorScheme.onSurfaceVariant.withOpacity(0.38),
                    ),
                    child: leading!,
                  )
                : null,
            trailing: trailing != null
                ? IconTheme(
                    data: IconThemeData(
                      color: enabled
                          ? colorScheme.onSurfaceVariant
                          : colorScheme.onSurfaceVariant.withOpacity(0.38),
                    ),
                    child: trailing!,
                  )
                : null,
            dense: dense,
            enabled: enabled,
            contentPadding:
                contentPadding ?? const EdgeInsets.symmetric(horizontal: 16),
            selected: selected,
            selectedTileColor: colorScheme.primaryContainer,
          ),
        ),
      ),
    );
  }
}
