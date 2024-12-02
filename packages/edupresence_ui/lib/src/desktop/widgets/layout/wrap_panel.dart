import 'package:fluent_ui/fluent_ui.dart';

/// Direction of the wrap panel.
enum WrapPanelDirection {
  horizontal,
  vertical,
}

/// A panel that wraps its children when they exceed the available space.
class DesktopWrapPanel extends StatelessWidget {
  const DesktopWrapPanel({
    required this.children,
    super.key,
    this.direction = WrapPanelDirection.horizontal,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.padding = EdgeInsets.zero,
  });

  /// The widgets to wrap.
  final List<Widget> children;

  /// Direction of the wrapping.
  final WrapPanelDirection direction;

  /// Spacing between children in the main axis.
  final double spacing;

  /// Spacing between runs in the cross axis.
  final double runSpacing;

  /// Alignment of children within a run.
  final WrapAlignment alignment;

  /// Alignment of runs within the cross axis.
  final WrapAlignment runAlignment;

  /// Alignment of children within the cross axis of a run.
  final WrapCrossAlignment crossAxisAlignment;

  /// Padding around the wrap panel.
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Wrap(
        direction: direction == WrapPanelDirection.horizontal
            ? Axis.horizontal
            : Axis.vertical,
        spacing: spacing,
        runSpacing: runSpacing,
        alignment: alignment,
        runAlignment: runAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: children,
      ),
    );
  }
}

/// A wrap panel that maintains equal-sized items.
class DesktopUniformWrapPanel extends StatelessWidget {
  const DesktopUniformWrapPanel({
    required this.children,
    required this.itemWidth,
    required this.itemHeight,
    super.key,
    this.direction = WrapPanelDirection.horizontal,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.alignment = WrapAlignment.start,
    this.runAlignment = WrapAlignment.start,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.padding = EdgeInsets.zero,
  });

  /// The widgets to wrap.
  final List<Widget> children;

  /// Width of each item.
  final double itemWidth;

  /// Height of each item.
  final double itemHeight;

  /// Direction of the wrapping.
  final WrapPanelDirection direction;

  /// Spacing between children in the main axis.
  final double spacing;

  /// Spacing between runs in the cross axis.
  final double runSpacing;

  /// Alignment of children within a run.
  final WrapAlignment alignment;

  /// Alignment of runs within the cross axis.
  final WrapAlignment runAlignment;

  /// Alignment of children within the cross axis of a run.
  final WrapCrossAlignment crossAxisAlignment;

  /// Padding around the wrap panel.
  final EdgeInsetsGeometry padding;

  List<Widget> _wrapChildren() {
    return children.map((child) {
      return SizedBox(
        width: itemWidth,
        height: itemHeight,
        child: child,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Wrap(
        direction: direction == WrapPanelDirection.horizontal
            ? Axis.horizontal
            : Axis.vertical,
        spacing: spacing,
        runSpacing: runSpacing,
        alignment: alignment,
        runAlignment: runAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: _wrapChildren(),
      ),
    );
  }
}
