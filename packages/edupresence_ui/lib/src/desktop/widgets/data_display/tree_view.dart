import 'package:fluent_ui/fluent_ui.dart';

/// A tree node representing an item in the tree view.
class TreeNode<T> {
  TreeNode({
    required this.value,
    this.children = const [],
    this.icon,
    this.selectedIcon,
    this.expanded = false,
  });

  /// The value associated with this node.
  final T value;

  /// The child nodes of this node.
  final List<TreeNode<T>> children;

  /// The icon to display when the node is not selected.
  final IconData? icon;

  /// The icon to display when the node is selected.
  final IconData? selectedIcon;

  /// Whether this node is expanded to show its children.
  final bool expanded;

  /// Creates a copy of this node with the given fields replaced.
  TreeNode<T> copyWith({
    T? value,
    List<TreeNode<T>>? children,
    IconData? icon,
    IconData? selectedIcon,
    bool? expanded,
  }) {
    return TreeNode<T>(
      value: value ?? this.value,
      children: children ?? this.children,
      icon: icon ?? this.icon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      expanded: expanded ?? this.expanded,
    );
  }
}

/// A tree view component for desktop applications.
///
/// This component displays hierarchical data in a tree structure,
/// with support for expansion/collapse, selection, and custom icons.
class DesktopTreeView<T> extends StatefulWidget {
  const DesktopTreeView({
    required this.nodes,
    required this.itemBuilder,
    super.key,
    this.selectedItem,
    this.onSelectionChanged,
    this.onNodeExpanded,
    this.indent = 20.0,
    this.expanderIcon = FluentIcons.chevron_right,
    this.expandedIcon = FluentIcons.chevron_down,
  });

  /// The root nodes of the tree.
  final List<TreeNode<T>> nodes;

  /// Builder function to create the content for each node.
  final Widget Function(BuildContext context, T item, {required bool isSelected}) itemBuilder;

  /// Currently selected item.
  final T? selectedItem;

  /// Called when selection changes.
  final ValueChanged<T?>? onSelectionChanged;

  /// Called when a node is expanded or collapsed.
  final void Function(T item, {required bool expanded})? onNodeExpanded;

  /// Indentation for each level of the tree.
  final double indent;

  /// Icon to show for collapsed nodes.
  final IconData expanderIcon;

  /// Icon to show for expanded nodes.
  final IconData expandedIcon;

  @override
  State<DesktopTreeView<T>> createState() => _DesktopTreeViewState<T>();
}

class _DesktopTreeViewState<T> extends State<DesktopTreeView<T>> {
  Widget _buildNode(TreeNode<T> node, int level) {
    final theme = FluentTheme.of(context);
    final selected = widget.selectedItem == node.value;
    final hasChildren = node.children.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HoverButton(
          onPressed: () => widget.onSelectionChanged?.call(node.value),
          builder: (context, states) {
            return Container(
              decoration: BoxDecoration(
                color: selected
                    ? theme.accentColor.withOpacity(0.1)
                    : states.isHovered
                        ? theme.resources.controlFillColorSecondary
                        : theme.resources.controlFillColorDefault,
              ),
              child: Row(
                children: [
                  SizedBox(width: widget.indent * level),
                  if (hasChildren)
                    IconButton(
                      icon: Icon(
                        node.expanded
                            ? widget.expandedIcon
                            : widget.expanderIcon,
                        size: 12,
                      ),
                      onPressed: () {
                        widget.onNodeExpanded?.call(
                          node.value,
                          expanded: !node.expanded,
                        );
                      },
                    )
                  else
                    const SizedBox(width: 28), // Width of IconButton
                  if (node.icon != null) ...[
                    Icon(
                      selected ? (node.selectedIcon ?? node.icon!) : node.icon!,
                      size: 16,
                      color: selected ? theme.accentColor : null,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: widget.itemBuilder(
                      context,
                      node.value,
                      isSelected: selected,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        if (node.expanded)
          ...node.children.map((child) => _buildNode(child, level + 1)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.nodes.map((node) => _buildNode(node, 0)).toList(),
      ),
    );
  }
}
