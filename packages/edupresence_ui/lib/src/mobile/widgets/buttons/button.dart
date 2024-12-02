import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:flutter/material.dart';

/// Mobile button variants
enum MobileButtonVariant {
  /// Primary button
  primary,

  /// Secondary button
  secondary,

  /// Text button
  text,
}

/// Mobile button sizes
enum MobileButtonSize {
  /// Small button
  small,

  /// Medium button
  medium,

  /// Large button
  large,
}

/// Mobile button widget
class MobileButton extends StatelessWidget {
  /// Creates a mobile button
  const MobileButton({
    required this.onPressed,
    required this.child,
    this.variant = MobileButtonVariant.primary,
    this.size = MobileButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.icon,
    super.key,
  });

  /// Creates a primary mobile button
  const MobileButton.primary({
    required this.onPressed,
    required this.child,
    this.size = MobileButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.icon,
    super.key,
  }) : variant = MobileButtonVariant.primary;

  /// Creates a secondary mobile button
  const MobileButton.secondary({
    required this.onPressed,
    required this.child,
    this.size = MobileButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.icon,
    super.key,
  }) : variant = MobileButtonVariant.secondary;

  /// Creates a text mobile button
  const MobileButton.text({
    required this.onPressed,
    required this.child,
    this.size = MobileButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.icon,
    super.key,
  }) : variant = MobileButtonVariant.text;

  /// Called when the button is tapped
  final VoidCallback? onPressed;

  /// The button's content
  final Widget child;

  /// The button's variant
  final MobileButtonVariant variant;

  /// The button's size
  final MobileButtonSize size;

  /// Whether the button is loading
  final bool loading;

  /// Whether the button is disabled
  final bool disabled;

  /// The button's icon
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final buttonSize = _getButtonSize();
    final buttonStyle = _getButtonStyle();

    Widget button;
    switch (variant) {
      case MobileButtonVariant.primary:
      case MobileButtonVariant.secondary:
        button = ElevatedButton(
          onPressed: disabled || loading ? null : onPressed,
          style: buttonStyle,
          child: _buildChild(),
        );
      case MobileButtonVariant.text:
        button = TextButton(
          onPressed: disabled || loading ? null : onPressed,
          style: buttonStyle,
          child: _buildChild(),
        );
    }

    if (buttonSize != null) {
      button = SizedBox(
        height: buttonSize,
        child: button,
      );
    }

    return button;
  }

  Widget _buildChild() {
    if (loading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == MobileButtonVariant.primary
                    ? AppColors.surface
                    : AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 8),
          child,
        ],
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          const SizedBox(width: 8),
          child,
        ],
      );
    }

    return child;
  }

  ButtonStyle _getButtonStyle() {
    switch (variant) {
      case MobileButtonVariant.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.surface,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.5),
          disabledForegroundColor: AppColors.surface.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        );
      case MobileButtonVariant.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.surface,
          foregroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.surface.withOpacity(0.5),
          disabledForegroundColor: AppColors.primary.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
            side: BorderSide(
              color: disabled
                  ? AppColors.primary.withOpacity(0.5)
                  : AppColors.primary,
            ),
          ),
        );
      case MobileButtonVariant.text:
        return TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.primary.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        );
    }
  }

  double? _getButtonSize() {
    switch (size) {
      case MobileButtonSize.small:
        return 32;
      case MobileButtonSize.medium:
        return 40;
      case MobileButtonSize.large:
        return 48;
    }
  }
}
