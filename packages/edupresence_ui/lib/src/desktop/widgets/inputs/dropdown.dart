import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:fluent_ui/fluent_ui.dart';

/// Desktop dropdown sizes
enum DesktopDropdownSize {
  /// Small dropdown
  small,

  /// Medium dropdown
  medium,

  /// Large dropdown
  large,
}

/// Desktop dropdown widget
class DesktopDropdown<T> extends StatelessWidget {
  /// Creates a desktop dropdown
  const DesktopDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.placeholder,
    this.size = DesktopDropdownSize.medium,
    this.disabled = false,
    super.key,
  });

  /// The dropdown's value
  final T? value;

  /// The dropdown's items
  final List<ComboBoxItem<T>> items;

  /// Called when the value changes
  final ValueChanged<T?>? onChanged;

  /// The dropdown's label
  final String? label;

  /// The dropdown's placeholder
  final String? placeholder;

  /// The dropdown's size
  final DesktopDropdownSize size;

  /// Whether the dropdown is disabled
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final dropdownSize = _getDropdownSize();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
        ],
        SizedBox(
          height: dropdownSize,
          child: ComboBox<T>(
            value: value,
            items: items,
            onChanged: disabled ? null : onChanged,
            placeholder: placeholder != null ? Text(placeholder!) : null,
          ),
        ),
      ],
    );
  }

  double _getDropdownSize() {
    switch (size) {
      case DesktopDropdownSize.small:
        return 32;
      case DesktopDropdownSize.medium:
        return 40;
      case DesktopDropdownSize.large:
        return 48;
    }
  }
}
