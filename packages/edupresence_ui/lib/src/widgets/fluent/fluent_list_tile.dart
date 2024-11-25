import 'package:fluent_ui/fluent_ui.dart';

/// A Fluent UI styled list tile.
class FluentListTile extends StatelessWidget {
  /// Creates a Fluent UI styled list tile.
  const FluentListTile({
    required this.title,
    super.key,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.selected = false,
    this.enabled = true,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  /// The primary content of the list tile.
  final Widget title;

  /// Additional content below the title.
  final Widget? subtitle;

  /// A widget to display before the title.
  final Widget? leading;

  /// A widget to display after the title.
  final Widget? trailing;

  /// Called when the user taps this list tile.
  final VoidCallback? onTap;

  /// Whether this list tile is selected.
  final bool selected;

  /// Whether this list tile is enabled.
  final bool enabled;

  /// The padding around the content of the list tile.
  final EdgeInsetsGeometry contentPadding;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    Widget content = Padding(
      padding: contentPadding,
      child: Row(
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DefaultTextStyle(
                  style: theme.typography.bodyStrong ?? const TextStyle(),
                  child: title,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  DefaultTextStyle(
                    style:
                        (theme.typography.body ?? const TextStyle()).copyWith(
                      color: theme.resources.textFillColorSecondary,
                    ),
                    child: subtitle!,
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 16),
            trailing!,
          ],
        ],
      ),
    );

    if (onTap != null && enabled) {
      content = HoverButton(
        onPressed: onTap,
        builder: (context, states) {
          return ColoredBox(
            color: selected
                ? theme.resources.subtleFillColorSecondary
                : states.isHovered
                    ? theme.resources.subtleFillColorTertiary
                    : Colors.transparent,
            child: content,
          );
        },
      );
    } else {
      content = Opacity(
        opacity: enabled ? 1.0 : 0.5,
        child: ColoredBox(
          color: selected
              ? theme.resources.subtleFillColorSecondary
              : Colors.transparent,
          child: content,
        ),
      );
    }

    return content;
  }
}
