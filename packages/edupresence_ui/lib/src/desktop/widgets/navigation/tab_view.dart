import 'package:fluent_ui/fluent_ui.dart';

/// A tab item representing a single page in the tab view.
class DesktopTabItem {
  const DesktopTabItem({
    required this.label,
    required this.content,
    this.icon,
    this.closeIcon = FluentIcons.chrome_close,
    this.onClose,
  });

  /// The label to display in the tab.
  final String label;

  /// The content to display when this tab is selected.
  final Widget content;

  /// An optional icon to display before the label.
  final IconData? icon;

  /// The icon to display for closing the tab.
  final IconData closeIcon;

  /// Callback when the close button is pressed.
  final VoidCallback? onClose;
}

/// A tab view component for desktop applications.
///
/// This component displays multiple pages of content in tabs,
/// allowing users to switch between them and optionally close tabs.
class DesktopTabView extends StatelessWidget {
  const DesktopTabView({
    required this.currentIndex,
    required this.tabs,
    super.key,
    this.onChanged,
    this.header,
    this.footer,
    this.showCloseButton = true,
    this.tabWidthBehavior = TabWidthBehavior.equal,
    this.closeButtonVisibility = CloseButtonVisibilityMode.always,
  });

  /// The index of the currently selected tab.
  final int currentIndex;

  /// The list of tabs to display.
  final List<DesktopTabItem> tabs;

  /// Called when a different tab is selected.
  final ValueChanged<int>? onChanged;

  /// Optional widget to display above the tabs.
  final Widget? header;

  /// Optional widget to display below the content.
  final Widget? footer;

  /// Whether to show close buttons on tabs.
  final bool showCloseButton;

  /// How to size the width of tabs.
  final TabWidthBehavior tabWidthBehavior;

  /// When to show the close button.
  final CloseButtonVisibilityMode closeButtonVisibility;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Column(
      children: [
        if (header != null) header!,
        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: theme.resources.controlStrokeColorDefault,
              ),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(tabs.length, (index) {
                final tab = tabs[index];
                final selected = index == currentIndex;

                return _TabButton(
                  selected: selected,
                  showCloseButton: showCloseButton &&
                      (closeButtonVisibility ==
                              CloseButtonVisibilityMode.always ||
                          (closeButtonVisibility ==
                                  CloseButtonVisibilityMode.hover &&
                              selected)),
                  tabWidthBehavior: tabWidthBehavior,
                  onPressed: () => onChanged?.call(index),
                  onClose: tab.onClose,
                  icon: tab.icon,
                  closeIcon: tab.closeIcon,
                  label: tab.label,
                );
              }),
            ),
          ),
        ),
        Expanded(
          child: tabs[currentIndex].content,
        ),
        if (footer != null) footer!,
      ],
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.selected,
    required this.showCloseButton,
    required this.tabWidthBehavior,
    required this.label,
    this.onPressed,
    this.onClose,
    this.icon,
    this.closeIcon = FluentIcons.chrome_close,
  });

  final bool selected;
  final bool showCloseButton;
  final TabWidthBehavior tabWidthBehavior;
  final VoidCallback? onPressed;
  final VoidCallback? onClose;
  final IconData? icon;
  final IconData closeIcon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return HoverButton(
      onPressed: onPressed,
      builder: (context, states) {
        final showClose = showCloseButton && (states.isHovered || selected);

        return Container(
          constraints: BoxConstraints(
            minWidth: tabWidthBehavior == TabWidthBehavior.equal ? 120 : 80,
            maxWidth: tabWidthBehavior == TabWidthBehavior.equal ? 120 : 200,
          ),
          decoration: BoxDecoration(
            color: selected
                ? theme.resources.cardBackgroundFillColorDefault
                : states.isHovered
                    ? theme.resources.controlFillColorSecondary
                    : theme.resources.controlFillColorDefault,
            border: Border(
              bottom: BorderSide(
                color: selected
                    ? theme.accentColor
                    : theme.resources.controlStrokeColorDefault,
                width: selected ? 2 : 1,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: selected
                      ? theme.accentColor
                      : theme.resources.textFillColorPrimary,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  label,
                  style: (selected
                          ? theme.typography.bodyStrong
                          : theme.typography.body)
                      ?.copyWith(
                    color: selected
                        ? theme.accentColor
                        : theme.resources.textFillColorPrimary,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (showClose && onClose != null) ...[
                const SizedBox(width: 8),
                IconButton(
                  icon: Icon(closeIcon, size: 16),
                  onPressed: onClose,
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

/// Defines how tab widths should be calculated.
enum TabWidthBehavior {
  /// All tabs have equal width
  equal,

  /// Tab width is based on content
  sizeToContent,
}

/// Defines when the close button should be visible.
enum CloseButtonVisibilityMode {
  /// Always show the close button
  always,

  /// Show the close button only on hover
  hover,

  /// Never show the close button
  never,
}
