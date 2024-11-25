import 'package:fluent_ui/fluent_ui.dart';

/// A Fluent UI styled chip.
class FluentChip extends StatefulWidget {
  /// Creates a Fluent UI styled chip.
  const FluentChip({
    required this.label,
    required this.onDeleted,
    super.key,
    this.avatar,
    this.deleteIcon,
    this.backgroundColor,
    this.deleteIconColor,
    this.labelStyle,
    this.labelPadding,
    this.padding,
    this.side,
    this.shape,
    this.clipBehavior = Clip.none,
    this.autofocus = false,
    this.color,
    this.elevation,
    this.pressElevation,
    this.shadowColor,
    this.surfaceTintColor,
    this.focusNode,
    this.useDeleteButtonTooltip = true,
    this.deleteButtonTooltipMessage,
    this.onPressed,
    this.isEnabled = true,
  });

  /// The primary content of the chip.
  final Widget label;

  /// Called when the chip should be deleted.
  final VoidCallback onDeleted;

  /// A widget to display prior to the chip's label.
  final Widget? avatar;

  /// The icon shown when the chip can be deleted.
  final Widget? deleteIcon;

  /// Color to be used for the chip's background.
  final Color? backgroundColor;

  /// The color to use for the delete icon.
  final Color? deleteIconColor;

  /// The style to be applied to the chip's label.
  final TextStyle? labelStyle;

  /// The padding around the chip's label.
  final EdgeInsetsGeometry? labelPadding;

  /// The padding between the chip's contents and its border.
  final EdgeInsetsGeometry? padding;

  /// The side of the chip's border.
  final BorderSide? side;

  /// The shape of the chip's border.
  final OutlinedBorder? shape;

  /// Determines how the chip's contents will be clipped.
  final Clip clipBehavior;

  /// True if this widget will be selected as the initial focus when no other
  /// node in its scope is currently focused.
  final bool autofocus;

  /// The color of the chip's surface.
  final Color? color;

  /// The elevation to be applied to the chip.
  final double? elevation;

  /// The elevation when the chip is pressed.
  final double? pressElevation;

  /// The shadow color.
  final Color? shadowColor;

  /// The surface tint color.
  final Color? surfaceTintColor;

  /// An optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// Whether to use a delete button tooltip.
  final bool useDeleteButtonTooltip;

  /// The message to be used for the delete button tooltip.
  final String? deleteButtonTooltipMessage;

  /// Called when the chip is pressed.
  final VoidCallback? onPressed;

  /// Whether the chip is enabled.
  final bool isEnabled;

  @override
  State<FluentChip> createState() => _FluentChipState();
}

class _FluentChipState extends State<FluentChip> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: Container(
          padding: widget.padding ?? const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: widget.isEnabled
                ? _isPressed
                    ? theme.resources.controlFillColorSecondary
                    : _isHovered
                        ? theme.resources.controlFillColorTertiary
                        : theme.resources.controlFillColorDefault
                : theme.resources.controlFillColorDisabled,
            border: Border.all(
              color: widget.isEnabled
                  ? theme.resources.controlStrokeColorDefault
                  : theme.resources.controlStrokeColorDefault.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.avatar != null) ...[
                widget.avatar!,
                const SizedBox(width: 8),
              ],
              DefaultTextStyle(
                style: (widget.labelStyle ??
                        theme.typography.body?.copyWith(
                          color: widget.isEnabled
                              ? theme.resources.textFillColorPrimary
                              : theme.resources.textFillColorDisabled,
                        )) ??
                    const TextStyle(),
                child: widget.label,
              ),
              ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: widget.deleteIcon ?? const Icon(FluentIcons.cancel),
                  onPressed: widget.isEnabled ? widget.onDeleted : null,
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all(Colors.transparent),
                    foregroundColor: WidgetStateProperty.resolveWith((states) {
                      return widget.deleteIconColor ??
                          (widget.isEnabled
                              ? theme.resources.textFillColorSecondary
                              : theme.resources.textFillColorDisabled);
                    }),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
