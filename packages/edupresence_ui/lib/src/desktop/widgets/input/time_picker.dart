import 'package:edupresence_ui/src/desktop/widgets/input/date_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';

/// Hour format for the time picker.
enum DesktopTimePickerHourFormat {
  /// 12-hour format (1-12 AM/PM)
  h12,

  /// 24-hour format (0-23)
  h24,
}

/// A time picker component for desktop applications.
class DesktopTimePicker extends StatelessWidget {
  const DesktopTimePicker({
    required this.selected,
    required this.onChanged,
    super.key,
    this.header,
    this.hourFormat = DesktopTimePickerHourFormat.h24,
    this.minuteIncrement = 1,
    this.locale,
  });

  /// Currently selected time.
  final DateTime selected;

  /// Called when the selected time changes.
  final ValueChanged<DateTime> onChanged;

  /// Optional header text.
  final String? header;

  /// The hour format to use (12 or 24 hour).
  final DesktopTimePickerHourFormat hourFormat;

  /// The increment to use for minutes (1-30).
  final int minuteIncrement;

  /// The locale to use for formatting.
  final String? locale;

  @override
  Widget build(BuildContext context) {
    return TimePicker(
      header: header,
      selected: selected,
      onChanged: onChanged,
      minuteIncrement: minuteIncrement,
      locale: locale != null ? Locale(locale!) : null,
    );
  }
}

/// A date time picker component that combines date and time selection.
class DesktopDateTimePicker extends StatefulWidget {
  const DesktopDateTimePicker({
    required this.selected,
    required this.onChanged,
    super.key,
    this.dateHeader = 'Date',
    this.timeHeader = 'Time',
    this.firstDate,
    this.lastDate,
    this.hourFormat = DesktopTimePickerHourFormat.h24,
    this.minuteIncrement = 1,
    this.locale,
  });

  /// Currently selected date and time.
  final DateTime selected;

  /// Called when either date or time changes.
  final ValueChanged<DateTime> onChanged;

  /// Header text for the date picker.
  final String dateHeader;

  /// Header text for the time picker.
  final String timeHeader;

  /// The earliest date the user can select.
  final DateTime? firstDate;

  /// The latest date the user can select.
  final DateTime? lastDate;

  /// The hour format to use (12 or 24 hour).
  final DesktopTimePickerHourFormat hourFormat;

  /// The increment to use for minutes (1-30).
  final int minuteIncrement;

  /// The locale to use for formatting.
  final String? locale;

  @override
  State<DesktopDateTimePicker> createState() => _DesktopDateTimePickerState();
}

class _DesktopDateTimePickerState extends State<DesktopDateTimePicker> {
  late DateTime _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.selected;
  }

  @override
  void didUpdateWidget(DesktopDateTimePicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selected != oldWidget.selected) {
      _selected = widget.selected;
    }
  }

  void _handleDateChanged(DateTime date) {
    _selected = DateTime(
      date.year,
      date.month,
      date.day,
      _selected.hour,
      _selected.minute,
    );
    widget.onChanged(_selected);
  }

  void _handleTimeChanged(DateTime time) {
    _selected = DateTime(
      _selected.year,
      _selected.month,
      _selected.day,
      time.hour,
      time.minute,
    );
    widget.onChanged(_selected);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DesktopDatePicker(
          header: widget.dateHeader,
          selected: _selected,
          onChanged: _handleDateChanged,
          firstDate: widget.firstDate,
          lastDate: widget.lastDate,
          locale: widget.locale,
        ),
        const SizedBox(height: 8),
        DesktopTimePicker(
          header: widget.timeHeader,
          selected: _selected,
          onChanged: _handleTimeChanged,
          hourFormat: widget.hourFormat,
          minuteIncrement: widget.minuteIncrement,
          locale: widget.locale,
        ),
      ],
    );
  }
}
