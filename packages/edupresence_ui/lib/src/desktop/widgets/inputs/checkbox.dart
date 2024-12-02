import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:fluent_ui/fluent_ui.dart';

/// Desktop checkbox sizes
enum DesktopCheckboxSize {
  /// Small checkbox
  small,

  /// Medium checkbox
  medium,

  /// Large checkbox
  large,
}

/// Desktop checkbox widget
class DesktopCheckbox extends StatelessWidget {
  /// Creates a desktop checkbox
  const DesktopCheckbox({
    required this.value,
    required this.onChanged,
    required this.label,
    this.size = DesktopCheckboxSize.medium,
    this.disabled = false,
    super.key,
  });

  /// The checkbox's value
  final bool value;

  /// Called when the value changes
  final ValueChanged<bool>? onChanged;

  /// The checkbox's label
  final String label;

  /// The checkbox's size
  final DesktopCheckboxSize size;

  /// Whether the checkbox is disabled
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final checkboxSize = _getCheckboxSize();

    return Checkbox(
      checked: value,
      onChanged: disabled ? null : (value) => onChanged?.call(value ?? false),
      content: Text(
        label,
        style: TextStyle(
          fontSize: checkboxSize - 8,
          color: disabled ? AppColors.textPrimary.withOpacity(0.5) : AppColors.textPrimary,
        ),
      ),
      style: CheckboxThemeData(
        checkedDecoration: WidgetStateProperty.resolveWith((states) {
          if (states.isDisabled) {
            return BoxDecoration(
              color: AppColors.primary.withOpacity(0.5),
              border: Border.all(color: AppColors.primary.withOpacity(0.5)),
            );
          }
          return BoxDecoration(
            color: AppColors.primary,
            border: Border.all(color: AppColors.primary),
          );
        }),
        uncheckedDecoration: WidgetStateProperty.resolveWith((states) {
          if (states.isDisabled) {
            return BoxDecoration(
              border: Border.all(color: AppColors.border.withOpacity(0.5)),
            );
          }
          return BoxDecoration(
            border: Border.all(color: AppColors.border),
          );
        }),
      ),
    );
  }

  double _getCheckboxSize() {
    switch (size) {
      case DesktopCheckboxSize.small:
        return 16;
      case DesktopCheckboxSize.medium:
        return 20;
      case DesktopCheckboxSize.large:
        return 24;
    }
  }
}
