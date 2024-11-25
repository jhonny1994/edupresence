import 'package:fluent_ui/fluent_ui.dart';

/// A Fluent UI styled button.
class FluentButton extends StatelessWidget {
  /// Creates a Fluent UI styled button.
  const FluentButton({
    required this.onPressed,
    required this.child,
    super.key,
    this.variant = FluentButtonVariant.primary,
    this.size = FluentButtonSize.medium,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// Called when the button is tapped.
  final VoidCallback? onPressed;

  /// The size of the button.
  final FluentButtonSize size;

  /// The variant of the button.
  final FluentButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Button(
      onPressed: onPressed,
      style: ButtonStyle(
        padding: WidgetStateProperty.resolveWith((states) {
          switch (size) {
            case FluentButtonSize.small:
              return const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              );
            case FluentButtonSize.medium:
              return const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              );
            case FluentButtonSize.large:
              return const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              );
          }
        }),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          final baseColor = variant == FluentButtonVariant.primary
              ? theme.accentColor
              : Colors.white;

          if (states.isDisabled) {
            return variant == FluentButtonVariant.text
                ? Colors.transparent
                : baseColor.withOpacity(0.5);
          }

          if (states.isPressed) {
            return variant == FluentButtonVariant.text
                ? theme.resources.subtleFillColorSecondary
                : baseColor.withOpacity(0.8);
          }

          if (states.isHovered) {
            return variant == FluentButtonVariant.text
                ? theme.resources.subtleFillColorTertiary
                : baseColor.withOpacity(0.9);
          }

          return variant == FluentButtonVariant.text
              ? Colors.transparent
              : baseColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.isDisabled) {
            return theme.resources.textFillColorDisabled;
          }

          switch (variant) {
            case FluentButtonVariant.primary:
              return Colors.white;
            case FluentButtonVariant.secondary:
            case FluentButtonVariant.text:
              return states.isPressed
                  ? theme.accentColor.darker
                  : states.isHovered
                      ? theme.accentColor.lighter
                      : theme.accentColor;
          }
        }),
        shape: WidgetStateProperty.resolveWith((states) {
          final borderRadius = BorderRadius.circular(4);

          switch (variant) {
            case FluentButtonVariant.primary:
              return RoundedRectangleBorder(borderRadius: borderRadius);
            case FluentButtonVariant.secondary:
              return RoundedRectangleBorder(
                borderRadius: borderRadius,
                side: BorderSide(
                  color: states.isDisabled
                      ? theme.resources.textFillColorDisabled
                      : states.isPressed
                          ? theme.accentColor.darker
                          : states.isHovered
                              ? theme.accentColor.lighter
                              : theme.accentColor,
                ),
              );
            case FluentButtonVariant.text:
              return RoundedRectangleBorder(borderRadius: borderRadius);
          }
        }),
      ),
      child: child,
    );
  }
}

/// The size of the button.
enum FluentButtonSize {
  /// A small button.
  small,

  /// A medium button.
  medium,

  /// A large button.
  large,
}

/// The variant of the button.
enum FluentButtonVariant {
  /// A primary button.
  primary,

  /// A secondary button.
  secondary,

  /// A text button.
  text,
}
