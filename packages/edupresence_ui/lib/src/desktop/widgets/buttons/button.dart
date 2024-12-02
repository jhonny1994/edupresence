import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:fluent_ui/fluent_ui.dart';

/// Desktop button variants
enum DesktopButtonVariant {
  /// Primary button
  primary,

  /// Secondary button
  secondary,

  /// Text button
  text,
}

/// Desktop button sizes
enum DesktopButtonSize {
  /// Small button
  small,

  /// Medium button
  medium,

  /// Large button
  large,
}

/// Desktop button widget
class DesktopButton extends StatelessWidget {
  /// Creates a desktop button
  const DesktopButton({
    required this.onPressed,
    required this.child,
    this.variant = DesktopButtonVariant.primary,
    this.size = DesktopButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.icon,
    super.key,
  });

  /// Creates a primary desktop button
  const DesktopButton.primary({
    required this.onPressed,
    required this.child,
    this.size = DesktopButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.icon,
    super.key,
  }) : variant = DesktopButtonVariant.primary;

  /// Creates a secondary desktop button
  const DesktopButton.secondary({
    required this.onPressed,
    required this.child,
    this.size = DesktopButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.icon,
    super.key,
  }) : variant = DesktopButtonVariant.secondary;

  /// Creates a text desktop button
  const DesktopButton.text({
    required this.onPressed,
    required this.child,
    this.size = DesktopButtonSize.medium,
    this.loading = false,
    this.disabled = false,
    this.icon,
    super.key,
  }) : variant = DesktopButtonVariant.text;

  /// Called when the button is tapped
  final VoidCallback? onPressed;

  /// The button's content
  final Widget child;

  /// The button's variant
  final DesktopButtonVariant variant;

  /// The button's size
  final DesktopButtonSize size;

  /// Whether the button is loading
  final bool loading;

  /// Whether the button is disabled
  final bool disabled;

  /// The button's icon
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _getButtonStyle();
    final buttonSize = _getButtonSize();

    Widget button = Button(
      onPressed: disabled || loading ? null : onPressed,
      style: buttonStyle,
      child: loading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const ProgressRing(
                  strokeWidth: 2,
                  activeColor: AppColors.surface,
                ),
                const SizedBox(width: 8),
                child,
              ],
            )
          : icon != null
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    icon!,
                    const SizedBox(width: 8),
                    child,
                  ],
                )
              : child,
    );

    if (buttonSize != null) {
      button = SizedBox(
        height: buttonSize,
        child: button,
      );
    }

    return button;
  }

  ButtonStyle? _getButtonStyle() {
    switch (variant) {
      case DesktopButtonVariant.primary:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.isDisabled) {
              return AppColors.primary.withOpacity(0.5);
            }
            if (states.isHovered) {
              return AppColors.primary.withOpacity(0.8);
            }
            if (states.isPressed) {
              return AppColors.primary.withOpacity(0.7);
            }
            return AppColors.primary;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.isDisabled) {
              return AppColors.surface.withOpacity(0.5);
            }
            return AppColors.surface;
          }),
        );
      case DesktopButtonVariant.secondary:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.isDisabled) {
              return AppColors.surface.withOpacity(0.5);
            }
            if (states.isHovered) {
              return AppColors.surface.withOpacity(0.8);
            }
            if (states.isPressed) {
              return AppColors.surface.withOpacity(0.7);
            }
            return AppColors.surface;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.isDisabled) {
              return AppColors.primary.withOpacity(0.5);
            }
            return AppColors.primary;
          }),
          shape: WidgetStateProperty.resolveWith((states) {
            if (states.isDisabled) {
              return RoundedRectangleBorder(
                side: BorderSide(
                  color: AppColors.primary.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(4),
              );
            }
            return RoundedRectangleBorder(
              side: const BorderSide(color: AppColors.primary),
              borderRadius: BorderRadius.circular(4),
            );
          }),
        );
      case DesktopButtonVariant.text:
        return ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.isDisabled) {
              return Colors.transparent;
            }
            if (states.isHovered) {
              return AppColors.primary.withOpacity(0.1);
            }
            if (states.isPressed) {
              return AppColors.primary.withOpacity(0.2);
            }
            return Colors.transparent;
          }),
          foregroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.isDisabled) {
              return AppColors.primary.withOpacity(0.5);
            }
            return AppColors.primary;
          }),
        );
    }
  }

  double? _getButtonSize() {
    switch (size) {
      case DesktopButtonSize.small:
        return 32;
      case DesktopButtonSize.medium:
        return 40;
      case DesktopButtonSize.large:
        return 48;
    }
  }
}
