import 'dart:async';

import 'package:fluent_ui/fluent_ui.dart';

/// A text field with auto-completion suggestions.
class DesktopAutoCompleteTextField<T> extends StatefulWidget {
  const DesktopAutoCompleteTextField({
    required this.options,
    required this.onSelected,
    required this.displayStringForOption,
    super.key,
    this.controller,
    this.placeholder,
    this.prefix,
    this.suffix,
    this.maxOptions = 5,
    this.debounce = const Duration(milliseconds: 300),
    this.onChanged,
    this.enabled = true,
  });

  /// The list of options to choose from.
  final List<T> options;

  /// Called when an option is selected.
  final ValueChanged<T> onSelected;

  /// Function to convert an option to a display string.
  final String Function(T option) displayStringForOption;

  /// Optional controller for the text field.
  final TextEditingController? controller;

  /// Placeholder text when the field is empty.
  final String? placeholder;

  /// Widget to show before the text.
  final Widget? prefix;

  /// Widget to show after the text.
  final Widget? suffix;

  /// Maximum number of options to show.
  final int maxOptions;

  /// Delay before showing suggestions.
  final Duration debounce;

  /// Called when the text changes.
  final ValueChanged<String>? onChanged;

  /// Whether the field is enabled.
  final bool enabled;

  @override
  State<DesktopAutoCompleteTextField<T>> createState() =>
      _DesktopAutoCompleteTextFieldState<T>();
}

class _DesktopAutoCompleteTextFieldState<T>
    extends State<DesktopAutoCompleteTextField<T>> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<T> _filteredOptions = [];
  String _lastSearchTerm = '';
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();
    _debounceTimer?.cancel();
    _removeOverlay();
    super.dispose();
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus) {
      _filterOptions(_controller.text);
    } else {
      _removeOverlay();
    }
  }

  void _filterOptions(String query) {
    if (query == _lastSearchTerm) return;
    _lastSearchTerm = query;

    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounce, () {
      final options = widget.options
          .where((option) {
            final item = widget.displayStringForOption(option).toLowerCase();
            return item.contains(query.toLowerCase());
          })
          .take(widget.maxOptions)
          .toList();

      setState(() {
        _filteredOptions = options;
        if (options.isNotEmpty && _focusNode.hasFocus) {
          _showOverlay();
        } else {
          _removeOverlay();
        }
      });
    });
  }

  void _showOverlay() {
    if (_overlayEntry != null) {
      _removeOverlay();
    }

    final renderBox = context.findRenderObject()! as RenderBox;
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8),
          child: Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: _filteredOptions.map((option) {
                final label = widget.displayStringForOption(option);
                return HoverButton(
                  onPressed: () {
                    _controller.text = label;
                    widget.onSelected(option);
                    _removeOverlay();
                    _focusNode.unfocus();
                  },
                  builder: (context, states) {
                    final theme = FluentTheme.of(context);
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      color: states.isHovered
                          ? theme.resources.controlFillColorSecondary
                          : theme.resources.controlFillColorDefault,
                      child: Text(
                        label,
                        style: theme.typography.body,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextFormBox(
        controller: _controller,
        focusNode: _focusNode,
        placeholder: widget.placeholder,
        prefix: widget.prefix,
        suffix: widget.suffix,
        enabled: widget.enabled,
        onChanged: (value) {
          widget.onChanged?.call(value);
          _filterOptions(value);
        },
      ),
    );
  }
}
