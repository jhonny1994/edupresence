import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:flutter/material.dart';

/// Mobile dropdown sizes
enum MobileDropdownSize {
  /// Small dropdown
  small,

  /// Medium dropdown
  medium,

  /// Large dropdown
  large,
}

/// Mobile dropdown widget
class MobileDropdown<T> extends StatelessWidget {
  /// Creates a mobile dropdown
  const MobileDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.placeholder,
    this.size = MobileDropdownSize.medium,
    this.disabled = false,
    super.key,
  });

  /// The dropdown's value
  final T? value;

  /// The dropdown's items
  final List<DropdownMenuItem<T>> items;

  /// Called when the value changes
  final ValueChanged<T?>? onChanged;

  /// The dropdown's label
  final String? label;

  /// The dropdown's placeholder
  final String? placeholder;

  /// The dropdown's size
  final MobileDropdownSize size;

  /// Whether the dropdown is disabled
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final dropdownSize = _getDropdownSize();
    final contentPadding = _getContentPadding();

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
          child: DropdownButtonFormField<T>(
            value: value,
            items: items,
            onChanged: disabled ? null : onChanged,
            hint: placeholder != null
                ? Text(
                    placeholder!,
                    style: TextStyle(
                      color: disabled
                          ? AppColors.textHint.withOpacity(0.5)
                          : AppColors.textHint,
                    ),
                  )
                : null,
            icon: const Icon(Icons.arrow_drop_down),
            iconEnabledColor: disabled
                ? AppColors.textPrimary.withOpacity(0.5)
                : AppColors.textPrimary,
            iconDisabledColor: AppColors.textPrimary.withOpacity(0.5),
            decoration: InputDecoration(
              contentPadding: contentPadding,
              filled: true,
              fillColor: disabled
                  ? AppColors.surface.withOpacity(0.5)
                  : AppColors.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: AppColors.primary),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: AppColors.border.withOpacity(0.5),
                ),
              ),
            ),
            style: TextStyle(
              color: disabled
                  ? AppColors.textPrimary.withOpacity(0.5)
                  : AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }

  double _getDropdownSize() {
    switch (size) {
      case MobileDropdownSize.small:
        return 32;
      case MobileDropdownSize.medium:
        return 40;
      case MobileDropdownSize.large:
        return 48;
    }
  }

  EdgeInsetsGeometry _getContentPadding() {
    switch (size) {
      case MobileDropdownSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case MobileDropdownSize.medium:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
      case MobileDropdownSize.large:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 14);
    }
  }
}
