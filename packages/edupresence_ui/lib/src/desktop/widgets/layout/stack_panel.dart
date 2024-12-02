import 'package:fluent_ui/fluent_ui.dart';

/// Direction of the stack panel.
enum StackPanelDirection {
  vertical,
  horizontal,
}

/// A panel that stacks its children vertically or horizontally with consistent spacing.
class DesktopStackPanel extends StatelessWidget {
  const DesktopStackPanel({
    required this.children,
    super.key,
    this.direction = StackPanelDirection.vertical,
    this.spacing = 8.0,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.padding = EdgeInsets.zero,
  });

  /// The widgets to stack.
  final List<Widget> children;

  /// Direction to stack the children.
  final StackPanelDirection direction;

  /// Spacing between children.
  final double spacing;

  /// Size of the main axis.
  final MainAxisSize mainAxisSize;

  /// Alignment of children along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// Padding around the stack panel.
  final EdgeInsetsGeometry padding;

  List<Widget> _addSpacing() {
    final spacedChildren = <Widget>[];
    for (var i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      if (i < children.length - 1) {
        spacedChildren.add(
          direction == StackPanelDirection.vertical
              ? SizedBox(height: spacing)
              : SizedBox(width: spacing),
        );
      }
    }
    return spacedChildren;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: direction == StackPanelDirection.vertical
          ? Column(
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              children: _addSpacing(),
            )
          : Row(
              mainAxisSize: mainAxisSize,
              crossAxisAlignment: crossAxisAlignment,
              children: _addSpacing(),
            ),
    );
  }
}
