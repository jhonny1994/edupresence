import 'package:fluent_ui/fluent_ui.dart';

/// A Fluent UI styled navigation view.
class FluentNavigationView extends StatelessWidget {
  /// Creates a Fluent UI styled navigation view.
  const FluentNavigationView({
    required this.selectedIndex,
    required this.items,
    required this.onChanged,
    required this.child,
    super.key,
    this.header,
    this.footer,
    this.autoSuggestBox,
    this.size = const NavigationPaneSize(
      openWidth: 250,
      openMinWidth: 250,
      openMaxWidth: 320,
    ),
    this.displayMode = PaneDisplayMode.auto,
  });

  /// The index of the selected item.
  final int selectedIndex;

  /// The items to display in the navigation view.
  final List<NavigationPaneItem> items;

  /// Called when the selected item changes.
  final ValueChanged<int> onChanged;

  /// The content to display in the main area.
  final Widget child;

  /// The header widget to display at the top of the navigation view.
  final Widget? header;

  /// The footer widget to display at the bottom of the navigation view.
  final Widget? footer;

  /// The auto-suggest box to display at the top of the navigation view.
  final Widget? autoSuggestBox;

  /// The size configuration for the navigation view.
  final NavigationPaneSize size;

  /// The display mode of the navigation view.
  final PaneDisplayMode displayMode;

  @override
  Widget build(BuildContext context) {
    final footerItems = footer != null
        ? [PaneItemHeader(header: footer!)]
        : <NavigationPaneItem>[];

    return NavigationView(
      pane: NavigationPane(
        selected: selectedIndex,
        onChanged: onChanged,
        header: header,
        items: items,
        footerItems: footerItems,
        autoSuggestBox: autoSuggestBox,
        size: size,
        displayMode: displayMode,
      ),
      content: Container(
        child: child,
      ),
    );
  }
}

/// A builder for creating navigation items.
class FluentNavigationItemBuilder {
  /// Creates a navigation item with an icon and title.
  static PaneItem item({
    required Widget icon,
    required Widget title,
    Widget? infoBadge,
  }) {
    return PaneItem(
      icon: icon,
      title: title,
      body: Container(),
      infoBadge: infoBadge,
    );
  }

  /// Creates a navigation item that expands to show more items.
  static PaneItemExpander expandingItem({
    required Widget icon,
    required Widget title,
    required List<NavigationPaneItem> items,
    Widget? infoBadge,
  }) {
    return PaneItemExpander(
      icon: icon,
      title: title,
      body: Container(),
      items: items,
      infoBadge: infoBadge,
    );
  }

  /// Creates a navigation item that acts as a header.
  static PaneItemHeader header({
    required Widget title,
  }) {
    return PaneItemHeader(
      header: title,
    );
  }

  /// Creates a navigation item that acts as a separator.
  static PaneItemSeparator separator() {
    return PaneItemSeparator();
  }
}
