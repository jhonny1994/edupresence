import 'package:flutter/material.dart';

/// A list view that displays items in a scrollable list with Material Design.
class MobileListView<T> extends StatelessWidget {
  const MobileListView({
    required this.items,
    required this.itemBuilder,
    super.key,
    this.onRefresh,
    this.onLoadMore,
    this.loadMoreThreshold = 200,
    this.padding = EdgeInsets.zero,
    this.separatorBuilder,
    this.emptyBuilder,
    this.physics,
    this.shrinkWrap = false,
    this.primary,
  });

  /// The items to display in the list.
  final List<T> items;

  /// Builder function for list items.
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Called when the user pulls to refresh.
  final Future<void> Function()? onRefresh;

  /// Called when the user scrolls near the end of the list.
  final Future<void> Function()? onLoadMore;

  /// Distance from the bottom that triggers load more.
  final double loadMoreThreshold;

  /// Padding around the list.
  final EdgeInsetsGeometry padding;

  /// Builder function for item separators.
  final Widget Function(BuildContext context, int index)? separatorBuilder;

  /// Builder function for empty state.
  final Widget Function(BuildContext context)? emptyBuilder;

  /// Scroll physics for the list.
  final ScrollPhysics? physics;

  /// Whether the list should shrink wrap its contents.
  final bool shrinkWrap;

  /// Whether this is the primary scroll view.
  final bool? primary;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty && emptyBuilder != null) {
      return emptyBuilder!(context);
    }

    Widget listView = separatorBuilder != null
        ? ListView.separated(
            padding: padding,
            itemCount: items.length,
            separatorBuilder: separatorBuilder!,
            itemBuilder: (context, index) =>
                itemBuilder(context, items[index], index),
            physics: physics,
            shrinkWrap: shrinkWrap,
            primary: primary,
          )
        : ListView.builder(
            padding: padding,
            itemCount: items.length,
            itemBuilder: (context, index) =>
                itemBuilder(context, items[index], index),
            physics: physics,
            shrinkWrap: shrinkWrap,
            primary: primary,
          );

    if (onLoadMore != null) {
      listView = NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            final metrics = notification.metrics;
            final pixels = metrics.pixels;
            final maxScroll = metrics.maxScrollExtent;
            if (maxScroll - pixels <= loadMoreThreshold) {
              onLoadMore?.call();
            }
          }
          return false;
        },
        child: listView,
      );
    }

    if (onRefresh != null) {
      listView = RefreshIndicator(
        onRefresh: onRefresh!,
        child: listView,
      );
    }

    return listView;
  }
}

/// A list tile with Material Design styling.
class MobileListTile extends StatelessWidget {
  const MobileListTile({
    required this.title,
    super.key,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.enabled = true,
    this.contentPadding,
    this.dense,
    this.visualDensity,
    this.shape,
    this.selectedColor,
    this.selectedTileColor,
  });

  /// The primary content of the list tile.
  final Widget title;

  /// Additional content below the title.
  final Widget? subtitle;

  /// A widget to display before the title.
  final Widget? leading;

  /// A widget to display after the title.
  final Widget? trailing;

  /// Called when the user taps this list tile.
  final VoidCallback? onTap;

  /// Called when the user long-presses this list tile.
  final VoidCallback? onLongPress;

  /// Whether this list tile is selected.
  final bool selected;

  /// Whether this list tile is interactive.
  final bool enabled;

  /// The padding around the content.
  final EdgeInsetsGeometry? contentPadding;

  /// Whether to render the tile with less height.
  final bool? dense;

  /// Defines how compact the tile's layout will be.
  final VisualDensity? visualDensity;

  /// The shape of the tile's Material.
  final ShapeBorder? shape;

  /// The color of the selected tile's text.
  final Color? selectedColor;

  /// The color of the selected tile's background.
  final Color? selectedTileColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: enabled ? onTap : null,
      onLongPress: enabled ? onLongPress : null,
      selected: selected,
      enabled: enabled,
      contentPadding: contentPadding,
      dense: dense,
      visualDensity: visualDensity,
      shape: shape,
      selectedColor: selectedColor,
      selectedTileColor: selectedTileColor,
    );
  }
}
