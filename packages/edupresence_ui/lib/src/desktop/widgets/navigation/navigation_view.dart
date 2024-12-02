import 'package:fluent_ui/fluent_ui.dart';

/// A customized navigation view for desktop applications.
///
/// This widget provides a top-level navigation structure using Fluent UI's design patterns.
/// It includes a navigation pane that can be displayed in different modes (top, left, minimal)
/// and supports both minimal and extended views.
class DesktopNavigationView extends StatelessWidget {
  /// Creates a new instance of [DesktopNavigationView].
  const DesktopNavigationView({
    required this.selectedIndex,
    required this.items,
    required this.content,
    super.key,
    this.onSelectionChanged,
    this.header,
    this.footerItems = const [],
    this.isMinimal = false,
  });

  /// The content to display in the main area.
  final Widget content;

  /// Optional footer items displayed at the bottom of the navigation pane.
  final List<NavigationPaneItem> footerItems;

  /// Optional header widget displayed at the top of the navigation pane.
  final Widget? header;

  /// Whether the navigation pane is displayed in minimal mode.
  final bool isMinimal;

  /// The items to display in the navigation pane.
  final List<NavigationPaneItem> items;

  /// Callback when a navigation item is selected.
  final ValueChanged<int>? onSelectionChanged;

  /// The selected index in the navigation pane.
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      pane: NavigationPane(
        selected: selectedIndex,
        onChanged: onSelectionChanged,
        header: header,
        footerItems: footerItems,
        displayMode: isMinimal ? PaneDisplayMode.minimal : PaneDisplayMode.auto,
        items: items,
      ),
      content: content,
    );
  }
}

/// A builder for creating navigation items with consistent styling.
class NavigationItemBuilder {
  /// Creates a navigation item with an icon and label.
  static PaneItem item({
    required String title,
    required IconData icon,
    Widget? body,
    bool enabled = true,
    InfoBadge? infoBadge,
  }) {
    return PaneItem(
      icon: Icon(icon),
      title: Text(title),
      body: body ?? const SizedBox.shrink(),
      enabled: enabled,
      infoBadge: infoBadge,
    );
  }

  /// Creates a navigation header item with a title.
  static PaneItemHeader header({
    required String title,
  }) {
    return PaneItemHeader(
      header: Text(title),
    );
  }

  /// Creates a navigation item that expands to show child items.
  static PaneItemExpander expander({
    required String title,
    required IconData icon,
    required List<NavigationPaneItem> items,
    Widget? body,
    InfoBadge? infoBadge,
  }) {
    return PaneItemExpander(
      icon: Icon(icon),
      title: Text(title),
      body: body ?? const SizedBox.shrink(),
      items: items,
      infoBadge: infoBadge,
    );
  }
}
