import 'package:flutter/material.dart';

class MaterialSegmentedButton<T> extends StatelessWidget {
  const MaterialSegmentedButton({
    required this.segments,
    required this.selected,
    required this.onSelectionChanged,
    super.key,
    this.multiSelectionEnabled = false,
    this.emptySelectionAllowed = false,
    this.style,
    this.showSelectedIcon = true,
    this.selectedIcon = const Icon(Icons.check),
  });

  final List<ButtonSegment<T>> segments;
  final Set<T> selected;
  final void Function(Set<T>) onSelectionChanged;
  final bool multiSelectionEnabled;
  final bool emptySelectionAllowed;
  final ButtonStyle? style;
  final bool showSelectedIcon;
  final Widget selectedIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SegmentedButton<T>(
      segments: segments,
      selected: selected,
      onSelectionChanged: onSelectionChanged,
      multiSelectionEnabled: multiSelectionEnabled,
      emptySelectionAllowed: emptySelectionAllowed,
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.primaryContainer;
          }
          return colorScheme.surface;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return colorScheme.onPrimaryContainer;
          }
          return colorScheme.onSurface;
        }),
        side: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return BorderSide(color: colorScheme.primary);
          }
          return BorderSide(color: colorScheme.outline);
        }),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ).merge(style),
      showSelectedIcon: showSelectedIcon,
      selectedIcon: selectedIcon,
    );
  }
}

class MaterialSegmentedButtonItem<T> extends ButtonSegment<T> {
  MaterialSegmentedButtonItem({
    required super.value,
    required Widget super.label,
    super.icon,
    super.enabled,
  });
}
