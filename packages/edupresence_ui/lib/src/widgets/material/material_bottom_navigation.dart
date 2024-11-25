import 'package:flutter/material.dart';

class MaterialBottomNavigationItem {
  const MaterialBottomNavigationItem({
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

class MaterialBottomNavigation extends StatelessWidget {
  const MaterialBottomNavigation({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
    this.elevation = 8,
    this.backgroundColor,
    this.showLabels = true,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
  });
  final List<MaterialBottomNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final double elevation;
  final Color? backgroundColor;
  final bool showLabels;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return NavigationBar(
      destinations: items.map((item) {
        Widget icon = Icon(
          currentIndex == items.indexOf(item) && item.selectedIcon != null
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

        return NavigationDestination(
          icon: icon,
          label: item.label,
          tooltip: item.tooltip,
        );
      }).toList(),
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: backgroundColor ?? colorScheme.surface,
      elevation: elevation,
      labelBehavior: showLabels
          ? NavigationDestinationLabelBehavior.alwaysShow
          : showSelectedLabels
              ? NavigationDestinationLabelBehavior.onlyShowSelected
              : NavigationDestinationLabelBehavior.alwaysHide,
      animationDuration: const Duration(milliseconds: 200),
      height: 80,
    );
  }
}
