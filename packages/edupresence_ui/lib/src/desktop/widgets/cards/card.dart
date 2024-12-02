import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:fluent_ui/fluent_ui.dart';

/// Desktop card variants
enum DesktopCardVariant {
  /// Elevated card
  elevated,

  /// Outlined card
  outlined,

  /// Filled card
  filled,
}

/// Desktop card widget
class DesktopCard extends StatelessWidget {
  /// Creates a desktop card
  const DesktopCard({
    required this.child,
    this.variant = DesktopCardVariant.elevated,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.onTap,
    super.key,
  });

  /// Creates an elevated desktop card
  const DesktopCard.elevated({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.onTap,
    super.key,
  }) : variant = DesktopCardVariant.elevated;

  /// Creates an outlined desktop card
  const DesktopCard.outlined({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.onTap,
    super.key,
  }) : variant = DesktopCardVariant.outlined;

  /// Creates a filled desktop card
  const DesktopCard.filled({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.onTap,
    super.key,
  }) : variant = DesktopCardVariant.filled;

  /// The card's content
  final Widget child;

  /// The card's variant
  final DesktopCardVariant variant;

  /// The card's padding
  final EdgeInsetsGeometry padding;

  /// The card's margin
  final EdgeInsetsGeometry margin;

  /// Called when the card is tapped
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final decoration = _getDecoration();

    Widget card = Container(
      padding: padding,
      margin: margin,
      decoration: decoration,
      child: child,
    );

    if (onTap != null) {
      card = HoverButton(
        onPressed: onTap,
        builder: (context, states) {
          return Container(
            padding: padding,
            margin: margin,
            decoration: _getDecoration(states: states),
            child: child,
          );
        },
      );
    }

    return card;
  }

  BoxDecoration _getDecoration({Set<WidgetState >? states}) {
    final isHovering = states?.isHovered  ?? false;
    final isPressed = states?.isPressed ?? false;

    switch (variant) {
      case DesktopCardVariant.elevated:
        return BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withOpacity(0.1),
              blurRadius: isPressed
                  ? 4
                  : isHovering
                      ? 8
                      : 6,
              offset: isPressed
                  ? const Offset(0, 1)
                  : isHovering
                      ? const Offset(0, 4)
                      : const Offset(0, 2),
            ),
          ],
        );
      case DesktopCardVariant.outlined:
        return BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isHovering
                ? AppColors.primary
                : AppColors.border,
          ),
        );
      case DesktopCardVariant.filled:
        return BoxDecoration(
          color: isHovering
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.background,
          borderRadius: BorderRadius.circular(8),
        );
    }
  }
}
