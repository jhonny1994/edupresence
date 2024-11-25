import 'package:fluent_ui/fluent_ui.dart';

class FluentTreeItem {
  const FluentTreeItem({
    required this.title,
    this.icon,
    this.children,
    this.onTap,
    this.selected = false,
  });
  final String title;
  final IconData? icon;
  final List<FluentTreeItem>? children;
  final VoidCallback? onTap;
  final bool selected;

  bool get hasChildren => children != null && children!.isNotEmpty;
}

class FluentTreeView extends StatefulWidget {
  const FluentTreeView({
    required this.items,
    super.key,
    this.initiallyExpanded = false,
    this.iconSize = 20,
    this.indentation = 20,
    this.itemHeight = 32,
  });

  final List<FluentTreeItem> items;
  final bool initiallyExpanded;
  final double iconSize;
  final double indentation;
  final double itemHeight;

  @override
  State<FluentTreeView> createState() => _FluentTreeViewState();
}

class _FluentTreeViewState extends State<FluentTreeView> {
  final Set<String> _expandedItems = {};

  @override
  void initState() {
    super.initState();
    if (widget.initiallyExpanded) {
      _expandAllItems(widget.items);
    }
  }

  void _expandAllItems(List<FluentTreeItem> items) {
    for (final item in items) {
      if (item.hasChildren) {
        _expandedItems.add(item.title);
        _expandAllItems(item.children!);
      }
    }
  }

  Widget _buildTreeItem(FluentTreeItem item, int depth) {
    final isExpanded = _expandedItems.contains(item.title);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        HoverButton(
          onPressed: () {
            if (item.hasChildren) {
              setState(() {
                if (isExpanded) {
                  _expandedItems.remove(item.title);
                } else {
                  _expandedItems.add(item.title);
                }
              });
            }
            item.onTap?.call();
          },
          builder: (context, states) {
            return Container(
              height: widget.itemHeight,
              padding: EdgeInsets.only(left: depth * widget.indentation),
              child: Row(
                children: [
                  if (item.hasChildren)
                    Icon(
                      isExpanded
                          ? FluentIcons.chevron_down
                          : FluentIcons.chevron_right,
                      size: widget.iconSize,
                    )
                  else
                    SizedBox(width: widget.iconSize),
                  const SizedBox(width: 4),
                  if (item.icon != null) ...[
                    Icon(item.icon, size: widget.iconSize),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      item.title,
                      style: item.selected
                          ? FluentTheme.of(context)
                              .typography
                              .body
                              ?.copyWith(fontWeight: FontWeight.bold)
                          : FluentTheme.of(context).typography.body,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        if (isExpanded && item.hasChildren)
          ...item.children!.map((child) => _buildTreeItem(child, depth + 1)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget.items.map((item) => _buildTreeItem(item, 0)).toList(),
    );
  }
}
