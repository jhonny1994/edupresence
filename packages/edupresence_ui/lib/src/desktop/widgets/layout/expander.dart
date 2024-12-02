import 'package:fluent_ui/fluent_ui.dart';

/// A widget that can be expanded or collapsed to show or hide its content.
class DesktopExpander extends StatefulWidget {
  const DesktopExpander({
    required this.header,
    required this.content,
    super.key,
    this.initiallyExpanded = false,
    this.onStateChanged,
    this.animationDuration = const Duration(milliseconds: 200),
    this.backgroundColor,
    this.headerBackgroundColor,
    this.headerPadding = const EdgeInsets.all(12),
    this.contentPadding = const EdgeInsets.all(12),
  });

  /// The header widget to display.
  final Widget header;

  /// The content widget to show when expanded.
  final Widget content;

  /// Whether the expander is initially expanded.
  final bool initiallyExpanded;

  /// Called when the expander is expanded or collapsed.
  final ValueChanged<bool>? onStateChanged;

  /// Duration of the expand/collapse animation.
  final Duration animationDuration;

  /// Background color of the entire expander.
  final Color? backgroundColor;

  /// Background color of the header section.
  final Color? headerBackgroundColor;

  /// Padding around the header.
  final EdgeInsetsGeometry headerPadding;

  /// Padding around the content.
  final EdgeInsetsGeometry contentPadding;

  @override
  State<DesktopExpander> createState() => _DesktopExpanderState();
}

class _DesktopExpanderState extends State<DesktopExpander>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
      widget.onStateChanged?.call(_isExpanded);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Container(
      decoration: BoxDecoration(
        color:
            widget.backgroundColor ?? theme.resources.controlFillColorDefault,
        border: Border.all(
          color: theme.resources.controlStrokeColorDefault,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HoverButton(
            onPressed: _toggleExpanded,
            builder: (context, states) {
              return Container(
                padding: widget.headerPadding,
                decoration: BoxDecoration(
                  color: states.isHovered
                      ? theme.resources.controlFillColorSecondary
                      : widget.headerBackgroundColor ??
                          theme.resources.controlFillColorDefault,
                  borderRadius: BorderRadius.vertical(
                    top: const Radius.circular(4),
                    bottom: Radius.circular(_isExpanded ? 0 : 4),
                  ),
                ),
                child: Row(
                  children: [
                    RotationTransition(
                      turns: Tween<double>(begin: -0.25, end: 0)
                          .animate(_animation),
                      child: const Icon(
                        FluentIcons.chevron_right,
                        size: 12,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: widget.header),
                  ],
                ),
              );
            },
          ),
          SizeTransition(
            axisAlignment: -1,
            sizeFactor: _animation,
            child: Container(
              width: double.infinity,
              padding: widget.contentPadding,
              child: widget.content,
            ),
          ),
        ],
      ),
    );
  }
}
