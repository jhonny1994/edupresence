import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:flutter/material.dart';

/// Mobile checkbox sizes
enum MobileCheckboxSize {
  /// Small checkbox
  small,

  /// Medium checkbox
  medium,

  /// Large checkbox
  large,
}

/// Mobile checkbox widget
class MobileCheckbox extends StatelessWidget {
  /// Creates a mobile checkbox
  const MobileCheckbox({
    required this.value,
    required this.onChanged,
    required this.label,
    this.size = MobileCheckboxSize.medium,
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
  final MobileCheckboxSize size;

  /// Whether the checkbox is disabled
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final checkboxSize = _getCheckboxSize();

    return GestureDetector(
      onTap: disabled ? null : () => onChanged?.call(!value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox.square(
            dimension: checkboxSize,
            child: Checkbox(
              value: value,
              onChanged: disabled ? null : (value) => onChanged?.call(value ?? false),
              activeColor: AppColors.primary,
              checkColor: AppColors.surface,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              side: BorderSide(
                color: disabled
                    ? AppColors.border.withOpacity(0.5)
                    : AppColors.border,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: checkboxSize - 4,
              color: disabled
                  ? AppColors.textPrimary.withOpacity(0.5)
                  : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  double _getCheckboxSize() {
    switch (size) {
      case MobileCheckboxSize.small:
        return 16;
      case MobileCheckboxSize.medium:
        return 20;
      case MobileCheckboxSize.large:
        return 24;
    }
  }
}
