import 'package:fluent_ui/fluent_ui.dart';

/// A list item configuration for the desktop list view.
class DesktopListItem<T> {
  const DesktopListItem({
    required this.value,
    this.leading,
    this.trailing,
    this.subtitle,
    this.selected = false,
    this.enabled = true,
  });

  /// The value associated with this item.
  final T value;

  /// Widget to display before the title.
  final Widget? leading;

  /// Widget to display after the title.
  final Widget? trailing;

  /// Optional subtitle to display below the title.
  final Widget? subtitle;

  /// Whether this item is selected.
  final bool selected;

  /// Whether this item is enabled.
  final bool enabled;
}

/// Selection mode for the list view.
enum DesktopListSelectionMode {
  /// No selection allowed.
  none,

  /// Single item selection.
  single,

  /// Multiple item selection.
  multiple,
}

/// A list view component for desktop applications.
///
/// This component displays items in a vertical list with support for
/// selection, leading/trailing widgets, and subtitles.
class DesktopListView<T> extends StatefulWidget {
  const DesktopListView({
    required this.items,
    required this.itemBuilder,
    super.key,
    this.selectionMode = DesktopListSelectionMode.single,
    this.selectedItems = const {},
    this.onSelectionChanged,
    this.itemHeight,
    this.dividerThickness = 1.0,
    this.showDividers = true,
    this.padding = EdgeInsets.zero,
  });

  /// The items to display in the list.
  final List<DesktopListItem<T>> items;

  /// Builder function to create the content for each item.
  final Widget Function(BuildContext context, DesktopListItem<T> item)
      itemBuilder;

  /// How items can be selected.
  final DesktopListSelectionMode selectionMode;

  /// Currently selected items.
  final Set<T> selectedItems;

  /// Called when selection changes.
  final ValueChanged<Set<T>>? onSelectionChanged;

  /// Optional fixed height for items.
  final double? itemHeight;

  /// Thickness of dividers between items.
  final double dividerThickness;

  /// Whether to show dividers between items.
  final bool showDividers;

  /// Padding around the list.
  final EdgeInsetsGeometry padding;

  @override
  State<DesktopListView<T>> createState() => _DesktopListViewState<T>();
}

class _DesktopListViewState<T> extends State<DesktopListView<T>> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _handleItemTap(DesktopListItem<T> item) {
    if (!item.enabled ||
        widget.selectionMode == DesktopListSelectionMode.none) {
      return;
    }

    final newSelection = Set<T>.from(widget.selectedItems);
    if (widget.selectionMode == DesktopListSelectionMode.single) {
      newSelection.clear();
    }

    if (newSelection.contains(item.value)) {
      newSelection.remove(item.value);
    } else {
      newSelection.add(item.value);
    }

    widget.onSelectionChanged?.call(newSelection);
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Scrollbar(
      controller: _scrollController,
      child: ListView.separated(
        controller: _scrollController,
        padding: widget.padding,
        itemCount: widget.items.length,
        separatorBuilder: (context, index) => widget.showDividers
            ? Divider(
                style: DividerThemeData(
                  thickness: widget.dividerThickness,
                  horizontalMargin: EdgeInsets.zero,
                ),
              )
            : const SizedBox.shrink(),
        itemBuilder: (context, index) {
          final item = widget.items[index];
          final selected = widget.selectedItems.contains(item.value);

          return SizedBox(
            height: widget.itemHeight,
            child: HoverButton(
              onPressed: item.enabled ? () => _handleItemTap(item) : null,
              builder: (context, states) {
                return ColoredBox(
                  color: selected
                      ? theme.accentColor.withOpacity(0.1)
                      : states.isHovered
                          ? theme.resources.controlFillColorSecondary
                          : theme.resources.controlFillColorDefault,
                  child: widget.itemBuilder(context, item),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
