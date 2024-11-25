import 'package:fluent_ui/fluent_ui.dart';

/// A Fluent UI styled card.
class FluentCard extends StatelessWidget {
  /// Creates a Fluent UI styled card.
  const FluentCard({
    required this.child,
    super.key,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(4)),
    this.elevation = 0.0,
    this.onTap,
  });

  /// The widget below this widget in the tree.
  final Widget child;

  /// The card's background color.
  final Color? backgroundColor;

  /// The amount of space to inset the [child].
  final EdgeInsetsGeometry padding;

  /// The amount of space to surround the card.
  final EdgeInsetsGeometry margin;

  /// The border radius of the card.
  final BorderRadius borderRadius;

  /// The elevation of the card.
  final double elevation;

  /// Called when the user taps the card.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final effectiveBackgroundColor = backgroundColor ?? theme.cardColor;

    Widget content = Container(
      margin: margin,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: borderRadius,
        boxShadow: elevation > 0
            ? [
                BoxShadow(
                  color:
                      theme.resources.cardStrokeColorDefault.withOpacity(0.1),
                  blurRadius: elevation * 2,
                  offset: Offset(0, elevation),
                ),
              ]
            : null,
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );

    if (onTap != null) {
      content = HoverButton(
        onPressed: onTap,
        builder: (context, states) {
          return AnimatedContainer(
            duration: theme.fastAnimationDuration,
            curve: theme.animationCurve,
            transform: Matrix4.identity()
              ..scale(states.isHovered ? 1.02 : 1.0)
              ..translate(0.0, states.isPressed ? 2.0 : 0.0),
            child: content,
          );
        },
      );
    }

    return content;
  }
}
