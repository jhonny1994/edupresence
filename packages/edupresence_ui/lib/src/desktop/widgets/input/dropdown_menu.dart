import 'package:fluent_ui/fluent_ui.dart';

/// A dropdown menu that allows users to select a single value from a list of options.
class DesktopDropdownMenu<T> extends StatefulWidget {
  const DesktopDropdownMenu({
    required this.items,
    required this.onChanged,
    super.key,
    this.value,
    this.placeholder,
    this.disabled = false,
    this.leadingIcon,
    this.displayStringForOption,
    this.width,
  });

  /// The currently selected value.
  final T? value;

  /// The list of items to display in the dropdown.
  final List<T> items;

  /// Called when the user selects an item.
  final ValueChanged<T?> onChanged;

  /// Text to display when no item is selected.
  final String? placeholder;

  /// Whether the dropdown is disabled.
  final bool disabled;

  /// Icon to display before the selected value.
  final IconData? leadingIcon;

  /// Function to convert an option to a display string.
  final String Function(T item)? displayStringForOption;

  /// Optional width for the dropdown button.
  final double? width;

  @override
  State<DesktopDropdownMenu<T>> createState() => _DesktopDropdownMenuState<T>();
}

class _DesktopDropdownMenuState<T> extends State<DesktopDropdownMenu<T>> {
  final FlyoutController _flyoutController = FlyoutController();

  String _getDisplayString(T item) {
    return widget.displayStringForOption?.call(item) ?? item.toString();
  }

  @override
  void dispose() {
    _flyoutController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return FlyoutTarget(
      controller: _flyoutController,
      child: HoverButton(
        onPressed: widget.disabled ? null : () => _flyoutController.showFlyout<void>(
          builder: (context) {
            return MenuFlyout(
              items: widget.items.map((item) {
                return MenuFlyoutItem(
                  text: Text(_getDisplayString(item)),
                  onPressed: () {
                    widget.onChanged(item);
                    Navigator.of(context).pop();
                  },
                  selected: widget.value == item,
                );
              }).toList(),
            );
          },
        ),
        builder: (context, states) {
          return Container(
            width: widget.width ?? 200,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: widget.disabled
                  ? theme.resources.controlFillColorDisabled
                  : states.isHovered
                      ? theme.resources.controlFillColorSecondary
                      : theme.resources.controlFillColorDefault,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: widget.disabled
                    ? theme.resources.controlFillColorDisabled
                    : states.isHovered
                        ? theme.resources.controlStrokeColorSecondary
                        : theme.resources.controlStrokeColorDefault,
              ),
            ),
            child: Row(
              children: [
                if (widget.leadingIcon != null) ...[
                  Icon(
                    widget.leadingIcon,
                    size: 16,
                    color: widget.disabled
                        ? theme.resources.textFillColorDisabled
                        : theme.resources.textFillColorPrimary,
                  ),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    widget.value != null
                        ? _getDisplayString(widget.value as T)
                        : widget.placeholder ?? '',
                    style: theme.typography.body?.copyWith(
                      color: widget.disabled
                          ? theme.resources.textFillColorDisabled
                          : theme.resources.textFillColorPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  FluentIcons.chevron_down,
                  size: 12,
                  color: widget.disabled
                      ? theme.resources.textFillColorDisabled
                      : theme.resources.textFillColorPrimary,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
