import 'package:flutter/material.dart';

class MobileDrawer extends StatelessWidget {
  const MobileDrawer({
    required this.children,
    super.key,
    this.backgroundColor,
    this.elevation,
    this.header,
    this.width,
    this.padding,
  });

  final List<Widget> children;
  final Color? backgroundColor;
  final double? elevation;
  final Widget? header;
  final double? width;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Drawer(
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      elevation: elevation ?? 1,
      width: width ?? mediaQuery.size.width * 0.85,
      child: Column(
        children: [
          if (header != null) header!,
          Expanded(
            child: ListView(
              padding: padding ?? EdgeInsets.zero,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class MobileDrawerItem extends StatelessWidget {
  const MobileDrawerItem({
    required this.title,
    super.key,
    this.leading,
    this.trailing,
    this.selected = false,
    this.onTap,
  });

  final Widget title;
  final Widget? leading;
  final Widget? trailing;
  final bool selected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      title: title,
      leading: leading,
      trailing: trailing,
      selected: selected,
      selectedColor: theme.colorScheme.primary,
      selectedTileColor: theme.colorScheme.primaryContainer.withOpacity(0.12),
      onTap: onTap,
    );
  }
}
