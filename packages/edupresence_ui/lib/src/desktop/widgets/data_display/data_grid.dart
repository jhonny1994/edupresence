import 'package:fluent_ui/fluent_ui.dart';

/// A column definition for the data grid.
class DesktopDataGridColumn<T> {
  const DesktopDataGridColumn({
    required this.header,
    required this.cell,
    this.width = double.nan,
    this.minWidth = 50.0,
    this.maxWidth = double.infinity,
    this.canSort = false,
    this.sortCompare,
  });

  /// The header content for this column.
  final Widget header;

  /// Builder function to create a cell for this column.
  final Widget Function(BuildContext context, T item) cell;

  /// Fixed width for the column. If double.nan, column will size to fit content.
  final double width;

  /// Minimum width for the column.
  final double minWidth;

  /// Maximum width for the column.
  final double maxWidth;

  /// Whether this column can be sorted.
  final bool canSort;

  /// Compare function for sorting. Only used if [canSort] is true.
  final int Function(T a, T b)? sortCompare;
}

/// Sort direction for the data grid.
enum DesktopDataGridSortDirection {
  ascending,
  descending,
  none,
}

/// Selection mode for the data grid.
enum DataGridSelectionMode {
  /// No selection allowed.
  none,

  /// Single item selection.
  single,

  /// Multiple item selection.
  multiple,
}

/// A data grid component for desktop applications.
///
/// This component displays data in a grid format with sortable columns,
/// fixed or flexible column widths, and customizable cell rendering.
class DesktopDataGrid<T> extends StatefulWidget {
  const DesktopDataGrid({
    required this.items,
    required this.columns,
    super.key,
    this.selectionMode = DataGridSelectionMode.single,
    this.selectedItems = const {},
    this.onSelectionChanged,
    this.onSortChanged,
    this.sortColumn,
    this.sortDirection = DesktopDataGridSortDirection.none,
    this.placeholder,
    this.border,
  });

  /// The data items to display in the grid.
  final List<T> items;

  /// The column definitions for the grid.
  final List<DesktopDataGridColumn<T>> columns;

  /// How items can be selected.
  final DataGridSelectionMode selectionMode;

  /// Currently selected items.
  final Set<T> selectedItems;

  /// Called when selection changes.
  final ValueChanged<Set<T>>? onSelectionChanged;

  /// Called when sort changes.
  final void Function(int column, DesktopDataGridSortDirection direction)?
      onSortChanged;

  /// Index of the column being sorted.
  final int? sortColumn;

  /// Current sort direction.
  final DesktopDataGridSortDirection sortDirection;

  /// Widget to show when there are no items.
  final Widget? placeholder;

  /// Border for the grid.
  final BoxBorder? border;

  @override
  State<DesktopDataGrid<T>> createState() => _DesktopDataGridState<T>();
}

class _DesktopDataGridState<T> extends State<DesktopDataGrid<T>> {
  late ScrollController _horizontalController;
  late ScrollController _verticalController;

  @override
  void initState() {
    super.initState();
    _horizontalController = ScrollController();
    _verticalController = ScrollController();
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  Widget _buildHeader(int columnIndex, DesktopDataGridColumn<T> column) {
    final theme = FluentTheme.of(context);
    final sortable = column.canSort && column.sortCompare != null;

    return Container(
      constraints: BoxConstraints(
        minWidth: column.minWidth,
        maxWidth: column.maxWidth,
      ),
      width: column.width.isNaN ? null : column.width,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: theme.resources.dividerStrokeColorDefault,
          ),
          bottom: BorderSide(
            color: theme.resources.dividerStrokeColorDefault,
          ),
        ),
      ),
      child: HoverButton(
        onPressed: sortable
            ? () {
                final newDirection = columnIndex == widget.sortColumn
                    ? widget.sortDirection ==
                            DesktopDataGridSortDirection.ascending
                        ? DesktopDataGridSortDirection.descending
                        : DesktopDataGridSortDirection.ascending
                    : DesktopDataGridSortDirection.ascending;
                widget.onSortChanged?.call(columnIndex, newDirection);
              }
            : null,
        builder: (context, states) {
          return Container(
            padding: const EdgeInsets.all(8),
            color: states.isHovered
                ? theme.resources.controlFillColorSecondary
                : theme.resources.controlFillColorDefault,
            child: Row(
              children: [
                Expanded(child: column.header),
                if (sortable && columnIndex == widget.sortColumn) ...[
                  const SizedBox(width: 4),
                  Icon(
                    widget.sortDirection ==
                            DesktopDataGridSortDirection.ascending
                        ? FluentIcons.sort_up
                        : FluentIcons.sort_down,
                    size: 12,
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCell(BuildContext context, T item, int columnIndex) {
    final theme = FluentTheme.of(context);
    final column = widget.columns[columnIndex];

    return Container(
      constraints: BoxConstraints(
        minWidth: column.minWidth,
        maxWidth: column.maxWidth,
      ),
      width: column.width.isNaN ? null : column.width,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: theme.resources.dividerStrokeColorDefault,
          ),
          bottom: BorderSide(
            color: theme.resources.dividerStrokeColorDefault,
          ),
        ),
      ),
      padding: const EdgeInsets.all(8),
      child: column.cell(context, item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    if (widget.items.isEmpty && widget.placeholder != null) {
      return widget.placeholder!;
    }

    return Container(
      decoration: BoxDecoration(
        border: widget.border ??
            Border.all(
              color: theme.resources.dividerStrokeColorDefault,
            ),
      ),
      child: Column(
        children: [
          // Header row
          SingleChildScrollView(
            controller: _horizontalController,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                widget.columns.length,
                (index) => _buildHeader(index, widget.columns[index]),
              ),
            ),
          ),
          // Data rows
          Expanded(
            child: Scrollbar(
              controller: _verticalController,
              child: SingleChildScrollView(
                controller: _verticalController,
                child: SingleChildScrollView(
                  controller: _horizontalController,
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.items.map((item) {
                      final selected = widget.selectedItems.contains(item);

                      return HoverButton(
                        onPressed: widget.selectionMode !=
                                DataGridSelectionMode.none
                            ? () {
                                final newSelection =
                                    Set<T>.from(widget.selectedItems);
                                if (widget.selectionMode ==
                                    DataGridSelectionMode.single) {
                                  newSelection.clear();
                                }
                                if (selected) {
                                  newSelection.remove(item);
                                } else {
                                  newSelection.add(item);
                                }
                                widget.onSelectionChanged?.call(newSelection);
                              }
                            : null,
                        builder: (context, states) {
                          return Container(
                            decoration: BoxDecoration(
                              color: selected
                                  ? theme.accentColor.withOpacity(0.1)
                                  : states.isHovered
                                      ? theme
                                          .resources.controlFillColorSecondary
                                      : theme.resources.controlFillColorDefault,
                            ),
                            child: Row(
                              children: List.generate(
                                widget.columns.length,
                                (index) => _buildCell(context, item, index),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
