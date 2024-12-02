import 'package:fluent_ui/fluent_ui.dart';

/// A vertical navigation rail for desktop applications.
///
/// This component is typically used in responsive layouts where the navigation
/// can be collapsed to save space while still providing easy access to main
/// navigation destinations.
class DesktopNavigationRail extends StatelessWidget {
  const DesktopNavigationRail({
    required this.selectedIndex,
    required this.items,
    super.key,
    this.onDestinationSelected,
    this.extended = false,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.minWidth = 72.0,
    this.minExtendedWidth = 256.0,
  });

  /// The index of the selected destination.
  final int selectedIndex;

  /// The list of destinations in the navigation rail.
  final List<NavigationRailDestination> items;

  /// Called when one of the destinations is selected.
  final ValueChanged<int>? onDestinationSelected;

  /// Whether the navigation rail is extended to show labels.
  final bool extended;

  /// A widget to be placed at the top of the rail.
  final Widget? leading;

  /// A widget to be placed at the bottom of the rail.
  final Widget? trailing;

  /// The background color of the rail.
  final Color? backgroundColor;

  /// The minimum width of the rail when collapsed.
  final double minWidth;

  /// The minimum width of the rail when extended.
  final double minExtendedWidth;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Container(
      constraints: BoxConstraints(
        minWidth: extended ? minExtendedWidth : minWidth,
        maxWidth: extended ? minExtendedWidth : minWidth,
      ),
      color: backgroundColor ?? theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          if (leading != null) leading!,
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemBuilder: (context, index) {
                final item = items[index];
                final selected = index == selectedIndex;

                return HoverButton(
                  onPressed: () => onDestinationSelected?.call(index),
                  builder: (context, states) {
                    return Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: selected
                            ? theme.accentColor.withOpacity(0.12)
                            : states.isHovered
                                ? theme.resources.controlFillColorSecondary
                                : Colors.transparent,
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: IconTheme(
                              data: IconThemeData(
                                color: selected
                                    ? theme.accentColor
                                    : theme.resources.textFillColorPrimary,
                                size: 24,
                              ),
                              child: item.icon,
                            ),
                          ),
                          if (extended && item.label != null)
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: DefaultTextStyle(
                                  style: theme.typography.body?.copyWith(
                                        color: selected
                                            ? theme.accentColor
                                            : theme
                                                .resources.textFillColorPrimary,
                                      ) ??
                                      const TextStyle(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  child: item.label!,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// A destination within the navigation rail.
class NavigationRailDestination {
  const NavigationRailDestination({
    required this.icon,
    this.label,
    this.selectedIcon,
  });

  /// The icon to display for this destination.
  final Widget icon;

  /// The label to display for this destination when the rail is extended.
  final Widget? label;

  /// An alternative icon to display when this destination is selected.
  final Widget? selectedIcon;
}
