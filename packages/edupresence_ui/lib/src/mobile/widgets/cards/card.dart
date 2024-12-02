import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:flutter/material.dart';

/// Mobile card variants
enum MobileCardVariant {
  /// Elevated card
  elevated,

  /// Outlined card
  outlined,

  /// Filled card
  filled,
}

/// Mobile card widget
class MobileCard extends StatelessWidget {
  /// Creates a mobile card
  const MobileCard({
    required this.child,
    this.variant = MobileCardVariant.elevated,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.onTap,
    super.key,
  });

  /// Creates an elevated mobile card
  const MobileCard.elevated({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.onTap,
    super.key,
  }) : variant = MobileCardVariant.elevated;

  /// Creates an outlined mobile card
  const MobileCard.outlined({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.onTap,
    super.key,
  }) : variant = MobileCardVariant.outlined;

  /// Creates a filled mobile card
  const MobileCard.filled({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.onTap,
    super.key,
  }) : variant = MobileCardVariant.filled;

  /// The card's content
  final Widget child;

  /// The card's variant
  final MobileCardVariant variant;

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
      card = Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: card,
        ),
      );
    }

    return card;
  }

  BoxDecoration _getDecoration() {
    switch (variant) {
      case MobileCardVariant.elevated:
        return BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: AppColors.textPrimary.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        );
      case MobileCardVariant.outlined:
        return BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
        );
      case MobileCardVariant.filled:
        return BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
        );
    }
  }
}
