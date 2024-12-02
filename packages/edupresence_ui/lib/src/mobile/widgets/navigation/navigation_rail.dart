import 'package:flutter/material.dart';

class MobileNavigationRail extends StatelessWidget {
  const MobileNavigationRail({
    required this.destinations,
    required this.selectedIndex,
    required this.onDestinationSelected,
    super.key,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.elevation,
    this.extended = false,
    this.labelType,
    this.groupAlignment,
    this.minWidth,
    this.minExtendedWidth,
  });

  final List<NavigationRailDestination> destinations;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;
  final double? elevation;
  final bool extended;
  final NavigationRailLabelType? labelType;
  final double? groupAlignment;
  final double? minWidth;
  final double? minExtendedWidth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return NavigationRail(
      destinations: destinations,
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      leading: leading,
      trailing: trailing,
      backgroundColor: backgroundColor ?? theme.colorScheme.surface,
      elevation: elevation ?? 1,
      extended: extended,
      labelType: labelType ?? NavigationRailLabelType.selected,
      groupAlignment: groupAlignment ?? -1,
      minWidth: minWidth ?? 72,
      minExtendedWidth: minExtendedWidth ?? 256,
      selectedIconTheme: IconThemeData(
        color: theme.colorScheme.primary,
      ),
      unselectedIconTheme: IconThemeData(
        color: theme.colorScheme.onSurface.withOpacity(0.64),
      ),
      selectedLabelTextStyle: TextStyle(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelTextStyle: TextStyle(
        color: theme.colorScheme.onSurface.withOpacity(0.64),
      ),
    );
  }
}
