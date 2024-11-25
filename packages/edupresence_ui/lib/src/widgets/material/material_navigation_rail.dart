import 'package:flutter/material.dart';

class MaterialNavigationRailItem {
  const MaterialNavigationRailItem({
    required this.label,
    required this.icon,
    this.selectedIcon,
    this.tooltip,
    this.badge,
  });
  final String label;
  final IconData icon;
  final IconData? selectedIcon;
  final String? tooltip;
  final Badge? badge;
}

class MaterialNavigationRail extends StatelessWidget {
  const MaterialNavigationRail({
    required this.items,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.extended = false,
    this.minWidth = 72,
    this.minExtendedWidth = 256,
  });

  final List<MaterialNavigationRailItem> items;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;
  final bool extended;
  final double minWidth;
  final double minExtendedWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      extended: extended,
      backgroundColor: backgroundColor ?? colorScheme.surface,
      leading: leading != null
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: leading,
            )
          : null,
      trailing: trailing != null
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: trailing,
            )
          : null,
      minWidth: minWidth,
      minExtendedWidth: minExtendedWidth,
      useIndicator: true,
      indicatorColor: colorScheme.secondaryContainer,
      destinations: items.map((item) {
        Widget icon = Icon(
          selectedIndex == items.indexOf(item) && item.selectedIcon != null
              ? item.selectedIcon
              : item.icon,
        );

        if (item.badge != null) {
          icon = Badge(
            label: item.badge!.label,
            backgroundColor: item.badge!.backgroundColor ?? colorScheme.error,
            child: icon,
          );
        }

        return NavigationRailDestination(
          icon: icon,
          selectedIcon:
              item.selectedIcon != null ? Icon(item.selectedIcon) : null,
          label: Text(item.label),
          padding: const EdgeInsets.symmetric(vertical: 4),
        );
      }).toList(),
    );
  }
}
