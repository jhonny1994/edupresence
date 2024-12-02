import 'package:flutter/material.dart';

/// A grid view that displays items in a scrollable grid with Material Design.
class MobileGridView<T> extends StatelessWidget {
  const MobileGridView({
    required this.items,
    required this.itemBuilder,
    super.key,
    this.onRefresh,
    this.onLoadMore,
    this.loadMoreThreshold = 200,
    this.padding = EdgeInsets.zero,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8,
    this.crossAxisSpacing = 8,
    this.childAspectRatio = 1,
    this.emptyBuilder,
    this.physics,
    this.shrinkWrap = false,
    this.primary,
  });

  /// The items to display in the grid.
  final List<T> items;

  /// Builder function for grid items.
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Called when the user pulls to refresh.
  final Future<void> Function()? onRefresh;

  /// Called when the user scrolls near the end of the grid.
  final Future<void> Function()? onLoadMore;

  /// Distance from the bottom that triggers load more.
  final double loadMoreThreshold;

  /// Padding around the grid.
  final EdgeInsetsGeometry padding;

  /// Number of items in the cross axis.
  final int crossAxisCount;

  /// Spacing between items in the main axis.
  final double mainAxisSpacing;

  /// Spacing between items in the cross axis.
  final double crossAxisSpacing;

  /// The ratio of the cross-axis to the main-axis extent of each child.
  final double childAspectRatio;

  /// Builder function for empty state.
  final Widget Function(BuildContext context)? emptyBuilder;

  /// Scroll physics for the grid.
  final ScrollPhysics? physics;

  /// Whether the grid should shrink wrap its contents.
  final bool shrinkWrap;

  /// Whether this is the primary scroll view.
  final bool? primary;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty && emptyBuilder != null) {
      return emptyBuilder!(context);
    }

    Widget gridView = GridView.builder(
      padding: padding,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: mainAxisSpacing,
        crossAxisSpacing: crossAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) =>
          itemBuilder(context, items[index], index),
      physics: physics,
      shrinkWrap: shrinkWrap,
      primary: primary,
    );

    if (onLoadMore != null) {
      gridView = NotificationListener<ScrollNotification>(
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
        child: gridView,
      );
    }

    if (onRefresh != null) {
      gridView = RefreshIndicator(
        onRefresh: onRefresh!,
        child: gridView,
      );
    }

    return gridView;
  }
}

/// A grid tile with Material Design styling.
class MobileGridTile extends StatelessWidget {
  const MobileGridTile({
    required this.child,
    super.key,
    this.header,
    this.footer,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.enabled = true,
    this.shape,
    this.selectedColor,
    this.selectedTileColor,
  });

  /// The primary content of the grid tile.
  final Widget child;

  /// Optional header widget.
  final Widget? header;

  /// Optional footer widget.
  final Widget? footer;

  /// Called when the user taps this grid tile.
  final VoidCallback? onTap;

  /// Called when the user long-presses this grid tile.
  final VoidCallback? onLongPress;

  /// Whether this grid tile is selected.
  final bool selected;

  /// Whether this grid tile is interactive.
  final bool enabled;

  /// The shape of the tile's Material.
  final ShapeBorder? shape;

  /// The color of the selected tile's content.
  final Color? selectedColor;

  /// The color of the selected tile's background.
  final Color? selectedTileColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = selected
        ? selectedTileColor ?? theme.colorScheme.primary.withOpacity(0.12)
        : null;
    final foregroundColor =
        selected ? selectedColor ?? theme.colorScheme.primary : null;

    return Material(
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
      color: backgroundColor,
      child: InkWell(
        onTap: enabled ? onTap : null,
        onLongPress: enabled ? onLongPress : null,
        child: GridTile(
          header: header,
          footer: footer,
          child: DefaultTextStyle(
            style: theme.textTheme.bodyMedium!.copyWith(
              color: foregroundColor,
            ),
            child: IconTheme(
              data: IconThemeData(color: foregroundColor),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
