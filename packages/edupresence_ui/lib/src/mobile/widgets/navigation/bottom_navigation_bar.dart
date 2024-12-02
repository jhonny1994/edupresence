import 'package:flutter/material.dart';

class MobileBottomNavigationBar extends StatelessWidget {
  const MobileBottomNavigationBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
    this.elevation,
    this.type = BottomNavigationBarType.fixed,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
  });

  final List<BottomNavigationBarItem> items;
  final int currentIndex;
  final void Function(int) onTap;
  final double? elevation;
  final BottomNavigationBarType type;
  final Color? backgroundColor;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BottomNavigationBar(
      items: items,
      currentIndex: currentIndex,
      onTap: onTap,
      elevation: elevation ?? 8,
      type: type,
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      selectedItemColor: selectedItemColor ?? theme.colorScheme.primary,
      unselectedItemColor:
          unselectedItemColor ?? theme.colorScheme.onSurface.withOpacity(0.64),
      showSelectedLabels: showSelectedLabels,
      showUnselectedLabels: showUnselectedLabels,
    );
  }
}
