import 'package:fluent_ui/fluent_ui.dart';

/// Position of the tooltip relative to the target.
enum DesktopTooltipPosition {
  top,
  bottom,
  left,
  right,
}

/// A tooltip that displays information when hovering over a widget.
class DesktopTooltip extends StatelessWidget {
  const DesktopTooltip({
    required this.message,
    required this.child,
    super.key,
    this.position = DesktopTooltipPosition.bottom,
    this.style,
    this.showDuration = const Duration(milliseconds: 200),
  });

  /// The message to display in the tooltip.
  final String message;

  /// The widget that triggers the tooltip.
  final Widget child;

  /// Position of the tooltip relative to the child.
  final DesktopTooltipPosition position;

  /// Optional style for the tooltip text.
  final TextStyle? style;

  /// Duration before showing the tooltip.
  final Duration showDuration;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return HoverButton(
      builder: (context, states) {
        return Tooltip(
          message: message,
          displayHorizontally: position == DesktopTooltipPosition.left ||
              position == DesktopTooltipPosition.right,
          style: TooltipThemeData(
            textStyle: style ??
                theme.typography.caption?.copyWith(
                  color: theme.resources.textOnAccentFillColorPrimary,
                ),
            decoration: BoxDecoration(
              color: theme.accentColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          child: child,
        );
      },
    );
  }
}

/// A tooltip with a title and optional description.
class DesktopRichTooltip extends StatelessWidget {
  const DesktopRichTooltip({
    required this.title,
    required this.child,
    super.key,
    this.description,
    this.position = DesktopTooltipPosition.bottom,
    this.showDuration = const Duration(milliseconds: 200),
  });

  /// The title of the tooltip.
  final String title;

  /// Optional description text.
  final String? description;

  /// The widget that triggers the tooltip.
  final Widget child;

  /// Position of the tooltip relative to the child.
  final DesktopTooltipPosition position;

  /// Duration before showing the tooltip.
  final Duration showDuration;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return HoverButton(
      builder: (context, states) {
        return Tooltip(
          message: '',
          displayHorizontally: position == DesktopTooltipPosition.left ||
              position == DesktopTooltipPosition.right,
          style: TooltipThemeData(
            decoration: BoxDecoration(
              color: theme.resources.controlFillColorDefault,
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.typography.body?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (description != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    description!,
                    style: theme.typography.caption,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
