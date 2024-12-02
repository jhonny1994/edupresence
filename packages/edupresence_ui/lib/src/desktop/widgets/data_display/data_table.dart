import 'package:fluent_ui/fluent_ui.dart';

/// A customizable data table component for displaying tabular data
/// with sorting, filtering, and pagination capabilities.
class EduDataTable extends StatelessWidget {
  const EduDataTable({
    required this.columns,
    required this.rows,
    super.key,
    this.sortable = true,
    this.showPagination = true,
    this.rowsPerPage,
    this.onSelectRow,
    this.onSort,
  });

  /// Callback when a row is selected
  final void Function(EduDataRow row)? onSelectRow;

  /// Callback when a column sort is triggered
  final void Function(EduDataColumn column, {required bool ascending})? onSort;

  /// The columns configuration for the table
  final List<EduDataColumn> columns;

  /// The rows of data to display
  final List<EduDataRow> rows;

  /// The number of rows per page when pagination is enabled
  final int? rowsPerPage;

  /// Whether to show the pagination controls
  final bool showPagination;

  /// Whether the table should be sortable
  final bool sortable;

  Map<int, TableColumnWidth> _generateColumnWidths() {
    return {
      for (var i = 0; i < columns.length; i++)
        i: columns[i].width ?? const FlexColumnWidth(),
    };
  }

  List<Widget> _buildColumnHeaders(BuildContext context) {
    return columns.map((column) {
      return Container(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(child: Text(column.label)),
            if (sortable && column.sortable)
              IconButton(
                icon: const Icon(FluentIcons.sort),
                onPressed: () {
                  onSort?.call(column, ascending: true);
                },
              ),
          ],
        ),
      );
    }).toList();
  }

  TableRow _buildDataRow(BuildContext context, EduDataRow row) {
    return TableRow(
      decoration: BoxDecoration(
        color: row.selected
            ? FluentTheme.of(context).accentColor.withOpacity(0.1)
            : null,
      ),
      children: row.cells.map((cell) {
        return GestureDetector(
          onTap: () => onSelectRow?.call(row),
          child: Container(
            padding: const EdgeInsets.all(8),
            child: cell.content,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: FluentTheme.of(context).brightness.isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      child: const Row(),
    );
  }

  Widget _buildPagination(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: FluentTheme.of(context).brightness.isDark
                ? Colors.white.withOpacity(0.1)
                : Colors.black.withOpacity(0.1),
          ),
        ),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          _buildHeader(context),

          // Table content
          Expanded(
            child: ListView(
              children: [
                Table(
                  columnWidths: _generateColumnWidths(),
                  children: [
                    // Column headers
                    TableRow(
                      decoration: BoxDecoration(
                        color: FluentTheme.of(context).cardColor,
                      ),
                      children: _buildColumnHeaders(context),
                    ),
                    // Data rows
                    ...rows.map((row) => _buildDataRow(context, row)),
                  ],
                ),
              ],
            ),
          ),

          // Pagination
          if (showPagination) _buildPagination(context),
        ],
      ),
    );
  }
}

/// Represents a column in the data table
class EduDataColumn {
  const EduDataColumn({
    required this.label,
    this.sortable = true,
    this.width,
  });

  /// The label to display in the column header
  final String label;

  /// Whether this column can be sorted
  final bool sortable;

  /// The width of the column
  final TableColumnWidth? width;
}

/// Represents a row in the data table
class EduDataRow {
  const EduDataRow({
    required this.cells,
    this.selected = false,
  });

  /// The cells in this row
  final List<EduDataCell> cells;

  /// Whether this row is selected
  final bool selected;
}

/// Represents a cell in the data table
class EduDataCell {
  const EduDataCell({
    required this.content,
  });

  /// The content to display in the cell
  final Widget content;
}
