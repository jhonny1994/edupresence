import 'package:fluent_ui/fluent_ui.dart';

/// Direction of the split view.
enum SplitViewDirection {
  horizontal,
  vertical,
}

/// A widget that splits its space between two children with a draggable divider.
class DesktopSplitView extends StatefulWidget {
  const DesktopSplitView({
    required this.first,
    required this.second,
    super.key,
    this.direction = SplitViewDirection.horizontal,
    this.initialWeight = 0.5,
    this.minWeight = 0.1,
    this.maxWeight = 0.9,
    this.gripSize = 8.0,
    this.gripColor,
    this.onWeightChanged,
  })  : assert(
          initialWeight >= 0.0 && initialWeight <= 1.0,
          'Initial weight must be between 0.0 and 1.0',
        ),
        assert(
          minWeight >= 0.0 && minWeight <= 1.0,
          'Minimum weight must be between 0.0 and 1.0',
        ),
        assert(
          maxWeight >= 0.0 && maxWeight <= 1.0,
          'Maximum weight must be between 0.0 and 1.0',
        ),
        assert(
          minWeight <= maxWeight,
          'Minimum weight must be less than or equal to maximum weight',
        );

  /// The first child.
  final Widget first;

  /// The second child.
  final Widget second;

  /// Direction of the split.
  final SplitViewDirection direction;

  /// Initial weight of the first view (0.0 to 1.0).
  final double initialWeight;

  /// Minimum weight of either view.
  final double minWeight;

  /// Maximum weight of either view.
  final double maxWeight;

  /// Size of the grip area.
  final double gripSize;

  /// Color of the grip area.
  final Color? gripColor;

  /// Called when the weight changes.
  final ValueChanged<double>? onWeightChanged;

  @override
  State<DesktopSplitView> createState() => _DesktopSplitViewState();
}

class _DesktopSplitViewState extends State<DesktopSplitView> {
  late double _weight;
  double? _startWeight;
  Offset? _startOffset;

  @override
  void initState() {
    super.initState();
    _weight = widget.initialWeight;
  }

  void _handleDragStart(DragStartDetails details) {
    _startWeight = _weight;
    _startOffset = details.globalPosition;
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_startWeight == null || _startOffset == null) return;

    final delta = details.globalPosition - _startOffset!;
    final mainAxisDelta =
        widget.direction == SplitViewDirection.horizontal ? delta.dx : delta.dy;

    final renderBox = context.findRenderObject()! as RenderBox;
    final mainAxisSize = widget.direction == SplitViewDirection.horizontal
        ? renderBox.size.width
        : renderBox.size.height;

    setState(() {
      _weight = (_startWeight! + mainAxisDelta / mainAxisSize)
          .clamp(widget.minWeight, widget.maxWeight);
      widget.onWeightChanged?.call(_weight);
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    _startWeight = null;
    _startOffset = null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final isHorizontal = widget.direction == SplitViewDirection.horizontal;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size =
            isHorizontal ? constraints.maxWidth : constraints.maxHeight;
        final gripOffset = (size * _weight) - (widget.gripSize / 2);

        return Stack(
          children: [
            Row(
              textDirection:
                  isHorizontal ? TextDirection.ltr : TextDirection.rtl,
              children: [
                SizedBox(
                  width: isHorizontal ? size * _weight : constraints.maxWidth,
                  height: isHorizontal ? constraints.maxHeight : size * _weight,
                  child: widget.first,
                ),
                SizedBox(
                  width: isHorizontal
                      ? size * (1 - _weight)
                      : constraints.maxWidth,
                  height: isHorizontal
                      ? constraints.maxHeight
                      : size * (1 - _weight),
                  child: widget.second,
                ),
              ],
            ),
            Positioned(
              left: isHorizontal ? gripOffset : 0,
              top: isHorizontal ? 0 : gripOffset,
              child: GestureDetector(
                onHorizontalDragStart: isHorizontal ? _handleDragStart : null,
                onHorizontalDragUpdate: isHorizontal ? _handleDragUpdate : null,
                onHorizontalDragEnd: isHorizontal ? _handleDragEnd : null,
                onVerticalDragStart: isHorizontal ? null : _handleDragStart,
                onVerticalDragUpdate: isHorizontal ? null : _handleDragUpdate,
                onVerticalDragEnd: isHorizontal ? null : _handleDragEnd,
                child: MouseRegion(
                  cursor: isHorizontal
                      ? SystemMouseCursors.resizeColumn
                      : SystemMouseCursors.resizeRow,
                  child: Container(
                    width:
                        isHorizontal ? widget.gripSize : constraints.maxWidth,
                    height:
                        isHorizontal ? constraints.maxHeight : widget.gripSize,
                    color: widget.gripColor ??
                        theme.resources.controlStrokeColorDefault,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
