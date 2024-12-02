import 'package:flutter/material.dart';

/// A data table that displays data in rows and columns with Material Design.
class MobileDataTable<T> extends StatefulWidget {
  const MobileDataTable({
    required this.columns,
    required this.rows,
    super.key,
    this.onSort,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.onSelectAll,
    this.selectedRows = const {},
    this.onRowTap,
    this.rowsPerPage = 10,
    this.availableRowsPerPage = const [10, 25, 50],
    this.onRowsPerPageChanged,
    this.showCheckboxColumn = true,
    this.dividerThickness = 1.0,
  });

  /// The columns to display.
  final List<DataColumn> columns;

  /// The rows to display.
  final List<T> rows;

  /// Called when a column is sorted.
  final void Function({required int columnIndex, required bool ascending})? onSort;

  /// The current sort column index.
  final int? sortColumnIndex;

  /// Whether the current sort is ascending.
  final bool sortAscending;

  /// Called when the select all checkbox is tapped.
  final void Function({required bool? selected})? onSelectAll;

  /// The currently selected rows.
  final Set<T> selectedRows;

  /// Called when a row is tapped.
  final void Function(T row)? onRowTap;

  /// Number of rows per page.
  final int rowsPerPage;

  /// Available options for rows per page.
  final List<int> availableRowsPerPage;

  /// Called when rows per page is changed.
  final void Function(int?)? onRowsPerPageChanged;

  /// Whether to show the checkbox column.
  final bool showCheckboxColumn;

  /// Thickness of the divider between rows.
  final double dividerThickness;

  @override
  State<MobileDataTable<T>> createState() => _MobileDataTableState<T>();
}

class _MobileDataTableState<T> extends State<MobileDataTable<T>> {
  int _currentPage = 0;
  late int _rowsPerPage;

  @override
  void initState() {
    super.initState();
    _rowsPerPage = widget.rowsPerPage;
  }

  int get _startIndex => _currentPage * _rowsPerPage;
  int get _endIndex =>
      (_startIndex + _rowsPerPage).clamp(0, widget.rows.length);
  int get _pageCount => (widget.rows.length / _rowsPerPage).ceil();

  List<T> get _currentPageRows => widget.rows.sublist(_startIndex, _endIndex);

  bool _isSelected(T row) => widget.selectedRows.contains(row);

  void _handlePreviousPage() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
    }
  }

  void _handleNextPage() {
    if (_currentPage < _pageCount - 1) {
      setState(() => _currentPage++);
    }
  }

  void _handleRowsPerPageChanged(int? value) {
    if (value != null && value != _rowsPerPage) {
      setState(() {
        _rowsPerPage = value;
        _currentPage = 0;
      });
      widget.onRowsPerPageChanged?.call(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              child: DataTable(
                columns: widget.columns,
                rows: _currentPageRows.map((row) {
                  return DataRow(
                    selected: _isSelected(row),
                    onSelectChanged: widget.showCheckboxColumn
                        ? (selected) {
                            if (selected != null) {
                              setState(() {
                                if (selected) {
                                  widget.selectedRows.add(row);
                                } else {
                                  widget.selectedRows.remove(row);
                                }
                              });
                            }
                          }
                        : null,
                    cells: widget.columns.map((column) {
                      return DataCell(
                        Text(row.toString()),
                        onTap: () => widget.onRowTap?.call(row),
                      );
                    }).toList(),
                  );
                }).toList(),
                sortColumnIndex: widget.sortColumnIndex,
                sortAscending: widget.sortAscending,
                onSelectAll: widget.onSelectAll != null
                    ? (bool? selected) => widget.onSelectAll?.call(selected: selected)
                    : null,
                showCheckboxColumn: widget.showCheckboxColumn,
                dividerThickness: widget.dividerThickness,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: theme.dividerColor,
                width: widget.dividerThickness,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (widget.onRowsPerPageChanged != null)
                Row(
                  children: [
                    const Text('Rows per page:'),
                    const SizedBox(width: 8),
                    DropdownButton<int>(
                      value: _rowsPerPage,
                      items: widget.availableRowsPerPage
                          .map(
                            (count) => DropdownMenuItem(
                              value: count,
                              child: Text(count.toString()),
                            ),
                          )
                          .toList(),
                      onChanged: _handleRowsPerPageChanged,
                    ),
                  ],
                ),
              Row(
                children: [
                  Text(
                    '${_startIndex + 1}-$_endIndex of ${widget.rows.length}',
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: _currentPage > 0 ? _handlePreviousPage : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed:
                        _currentPage < _pageCount - 1 ? _handleNextPage : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
