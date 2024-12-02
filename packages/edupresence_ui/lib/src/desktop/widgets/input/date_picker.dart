import 'package:fluent_ui/fluent_ui.dart';

/// A date picker component for desktop applications.
class DesktopDatePicker extends StatelessWidget {
  const DesktopDatePicker({
    required this.selected,
    required this.onChanged,
    super.key,
    this.header,
    this.firstDate,
    this.lastDate,
    this.locale,
  });

  /// Currently selected date.
  final DateTime selected;

  /// Called when the selected date changes.
  final ValueChanged<DateTime> onChanged;

  /// Optional header text.
  final String? header;

  /// The earliest date the user can select.
  final DateTime? firstDate;

  /// The latest date the user can select.
  final DateTime? lastDate;

  /// The locale to use for formatting.
  final String? locale;

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      header: header,
      selected: selected,
      onChanged: onChanged,
      locale: locale != null ? Locale(locale!) : null,
    );
  }
}

/// A date range picker component for desktop applications.
class DesktopDateRangePicker extends StatefulWidget {
  const DesktopDateRangePicker({
    required this.start,
    required this.end,
    required this.onChanged,
    super.key,
    this.startHeader = 'Start date',
    this.endHeader = 'End date',
    this.firstDate,
    this.lastDate,
    this.locale,
  });

  /// Currently selected start date.
  final DateTime start;

  /// Currently selected end date.
  final DateTime end;

  /// Called when either date changes.
  final void Function(DateTime start, DateTime end) onChanged;

  /// Header text for the start date picker.
  final String startHeader;

  /// Header text for the end date picker.
  final String endHeader;

  /// The earliest date the user can select.
  final DateTime? firstDate;

  /// The latest date the user can select.
  final DateTime? lastDate;

  /// The locale to use for formatting.
  final String? locale;

  @override
  State<DesktopDateRangePicker> createState() => _DesktopDateRangePickerState();
}

class _DesktopDateRangePickerState extends State<DesktopDateRangePicker> {
  late DateTime _start;
  late DateTime _end;

  @override
  void initState() {
    super.initState();
    _start = widget.start;
    _end = widget.end;
  }

  @override
  void didUpdateWidget(DesktopDateRangePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.start != oldWidget.start) {
      _start = widget.start;
    }
    if (widget.end != oldWidget.end) {
      _end = widget.end;
    }
  }

  void _handleStartDateChanged(DateTime date) {
    if (date.isAfter(_end)) {
      _end = date;
    }
    _start = date;
    widget.onChanged(_start, _end);
  }

  void _handleEndDateChanged(DateTime date) {
    if (date.isBefore(_start)) {
      _start = date;
    }
    _end = date;
    widget.onChanged(_start, _end);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        DesktopDatePicker(
          header: widget.startHeader,
          selected: _start,
          onChanged: _handleStartDateChanged,
          firstDate: widget.firstDate,
          lastDate: widget.end,
          locale: widget.locale,
        ),
        const SizedBox(width: 8),
        DesktopDatePicker(
          header: widget.endHeader,
          selected: _end,
          onChanged: _handleEndDateChanged,
          firstDate: _start,
          lastDate: widget.lastDate,
          locale: widget.locale,
        ),
      ],
    );
  }
}
