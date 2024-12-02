import 'package:fluent_ui/fluent_ui.dart';

/// A horizontal navigation bar for desktop applications.
///
/// This component is typically used at the top of the application to provide
/// easy access to main navigation destinations in a horizontal layout.
class DesktopNavigationBar extends StatelessWidget {
  const DesktopNavigationBar({
    required this.selectedIndex,
    required this.items,
    super.key,
    this.onDestinationSelected,
    this.backgroundColor,
    this.height = 48.0,
    this.leading,
    this.trailing,
  });

  /// The index of the selected destination.
  final int selectedIndex;

  /// The list of destinations in the navigation bar.
  final List<NavigationBarDestination> items;

  /// Called when one of the destinations is selected.
  final ValueChanged<int>? onDestinationSelected;

  /// The background color of the bar.
  final Color? backgroundColor;

  /// The height of the navigation bar.
  final double height;

  /// A widget to be placed at the start of the bar.
  final Widget? leading;

  /// A widget to be placed at the end of the bar.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Container(
      height: height,
      color: backgroundColor ?? theme.scaffoldBackgroundColor,
      child: Row(
        children: [
          if (leading != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: leading,
            ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final selected = index == selectedIndex;

                return HoverButton(
                  onPressed: () => onDestinationSelected?.call(index),
                  builder: (context, states) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: selected
                            ? theme.accentColor.withOpacity(0.12)
                            : states.isHovered
                                ? theme.resources.controlFillColorSecondary
                                : Colors.transparent,
                        border: Border(
                          bottom: BorderSide(
                            color: selected
                                ? theme.accentColor
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          IconTheme(
                            data: IconThemeData(
                              color: selected
                                  ? theme.accentColor
                                  : theme.resources.textFillColorPrimary,
                              size: 20,
                            ),
                            child: selected && item.selectedIcon != null
                                ? item.selectedIcon!
                                : item.icon,
                          ),
                          if (item.label != null)
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: DefaultTextStyle(
                                style: (selected
                                            ? theme.typography.bodyStrong
                                            : theme.typography.body)
                                        ?.copyWith(
                                      color: selected
                                          ? theme.accentColor
                                          : theme
                                              .resources.textFillColorPrimary,
                                    ) ??
                                    const TextStyle(),
                                child: item.label!,
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
          if (trailing != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: trailing,
            ),
        ],
      ),
    );
  }
}

/// A destination within the navigation bar.
class NavigationBarDestination {
  const NavigationBarDestination({
    required this.icon,
    this.label,
    this.selectedIcon,
  });

  /// The icon to display for this destination.
  final Widget icon;

  /// The label to display for this destination.
  final Widget? label;

  /// An alternative icon to display when this destination is selected.
  final Widget? selectedIcon;
}
