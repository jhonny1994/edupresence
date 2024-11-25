import 'package:fluent_ui/fluent_ui.dart';

class FluentCommandBarItem {
  const FluentCommandBarItem({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.enabled = true,
    this.tooltip,
    this.items,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool enabled;
  final String? tooltip;
  final List<FluentCommandBarItem>? items;

  bool get hasItems => items != null && items!.isNotEmpty;
}

class FluentCommandBar extends StatelessWidget {
  const FluentCommandBar({
    required this.items,
    super.key,
    this.compactItems = const [],
    this.overflowItems = const [],
    this.isCompact = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  final List<FluentCommandBarItem> items;
  final List<FluentCommandBarItem> compactItems;
  final List<FluentCommandBarItem> overflowItems;
  final bool isCompact;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    final primaryItems = items.map((item) {
      final button = Button(
        onPressed: item.enabled ? item.onPressed : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon),
            const SizedBox(width: 8),
            Text(item.label),
          ],
        ),
      );

      if (item.tooltip != null) {
        return Tooltip(
          message: item.tooltip,
          child: button,
        );
      }

      return button;
    }).toList();

    final secondaryItems = overflowItems.map((item) {
      final button = Button(
        onPressed: item.enabled ? item.onPressed : null,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon),
            const SizedBox(width: 8),
            Text(item.label),
          ],
        ),
      );

      if (item.tooltip != null) {
        return Tooltip(
          message: item.tooltip,
          child: button,
        );
      }

      return button;
    }).toList();

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        ...primaryItems,
        if (secondaryItems.isNotEmpty) ...[
          const SizedBox(width: 8),
          ...secondaryItems,
        ],
      ],
    );
  }
}
