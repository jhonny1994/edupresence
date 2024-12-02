import 'package:fluent_ui/fluent_ui.dart';

/// A breadcrumb item representing a single level in the navigation hierarchy.
class BreadcrumbItem {
  const BreadcrumbItem({
    required this.label,
    this.icon,
    this.onTap,
  });

  /// The label to display for this breadcrumb item.
  final String label;

  /// An optional icon to display before the label.
  final IconData? icon;

  /// Callback when this breadcrumb item is tapped.
  final VoidCallback? onTap;
}

/// A breadcrumb navigation component for desktop applications.
///
/// This component displays a hierarchical path of navigation items,
/// allowing users to understand their current location in the app
/// and navigate back to previous levels.
class DesktopBreadcrumb extends StatelessWidget {
  const DesktopBreadcrumb({
    required this.items,
    super.key,
    this.divider = const Icon(FluentIcons.chevron_right_small),
    this.maxItems,
  });

  /// The list of breadcrumb items to display.
  final List<BreadcrumbItem> items;

  /// The widget to use as a divider between items.
  final Widget divider;

  /// The maximum number of items to display before collapsing.
  /// If null, all items will be shown.
  final int? maxItems;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final effectiveItems = _getEffectiveItems();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(effectiveItems.length * 2 - 1, (index) {
          // Divider
          if (index.isOdd) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconTheme(
                data: IconThemeData(
                  size: 12,
                  color: theme.resources.textFillColorSecondary,
                ),
                child: divider,
              ),
            );
          }

          // Breadcrumb item
          final itemIndex = index ~/ 2;
          final item = effectiveItems[itemIndex];
          final isLast = itemIndex == effectiveItems.length - 1;

          return _BreadcrumbItemWidget(
            item: item,
            isLast: isLast,
          );
        }),
      ),
    );
  }

  List<BreadcrumbItem> _getEffectiveItems() {
    if (maxItems == null || items.length <= maxItems!) {
      return items;
    }

    // Show first item, ellipsis, and last few items
    final lastItemsCount = maxItems! - 1;
    final result = <BreadcrumbItem>[
      items.first,
      BreadcrumbItem(
        label: '...',
        onTap: () {
          // Could show a dropdown with all items here
        },
      ),
      ...items.skip(items.length - lastItemsCount),
    ];

    return result;
  }
}

class _BreadcrumbItemWidget extends StatelessWidget {
  const _BreadcrumbItemWidget({
    required this.item,
    required this.isLast,
  });

  final BreadcrumbItem item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    final textStyle = isLast
        ? theme.typography.bodyStrong?.copyWith(
            color: theme.resources.textFillColorPrimary,
          )
        : theme.typography.body?.copyWith(
            color: theme.accentColor,
          );

    return HoverButton(
      onPressed: isLast ? null : item.onTap,
      builder: (context, states) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.icon != null) ...[
              Icon(
                item.icon,
                size: 16,
                color: isLast
                    ? theme.resources.textFillColorPrimary
                    : theme.accentColor,
              ),
              const SizedBox(width: 8),
            ],
            Text(
              item.label,
              style: textStyle?.copyWith(
                decoration: (!isLast && states.isHovered)
                    ? TextDecoration.underline
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
