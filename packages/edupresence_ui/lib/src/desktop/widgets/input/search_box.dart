import 'dart:async';
import 'package:fluent_ui/fluent_ui.dart';

/// A search box that allows users to enter search queries with optional suggestions.
class DesktopSearchBox extends StatefulWidget {
  const DesktopSearchBox({
    required this.onChanged,
    super.key,
    this.controller,
    this.placeholder = 'Search',
    this.suggestions = const [],
    this.onSuggestionSelected,
    this.debounce = const Duration(milliseconds: 300),
    this.width,
    this.autofocus = false,
    this.enabled = true,
    this.showClearButton = true,
  });

  /// Called when the search text changes.
  final ValueChanged<String> onChanged;

  /// Optional controller for the search field.
  final TextEditingController? controller;

  /// Placeholder text when the field is empty.
  final String placeholder;

  /// List of search suggestions.
  final List<String> suggestions;

  /// Called when a suggestion is selected.
  final ValueChanged<String>? onSuggestionSelected;

  /// Delay before calling onChanged.
  final Duration debounce;

  /// Optional width for the search box.
  final double? width;

  /// Whether to autofocus the search box.
  final bool autofocus;

  /// Whether the search box is enabled.
  final bool enabled;

  /// Whether to show the clear button when text is entered.
  final bool showClearButton;

  @override
  State<DesktopSearchBox> createState() => _DesktopSearchBoxState();
}

class _DesktopSearchBoxState extends State<DesktopSearchBox> {
  late TextEditingController _controller;
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode
      ..addListener(_onFocusChanged)
      ..canRequestFocus = widget.enabled;
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
    if (_focusNode.hasFocus && widget.suggestions.isNotEmpty) {
      _showOverlay();
    } else {
      _removeOverlay();
    }
  }

  void _onChanged(String value) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(widget.debounce, () {
      widget.onChanged(value);
      if (value.isNotEmpty && widget.suggestions.isNotEmpty) {
        _showOverlay();
      } else {
        _removeOverlay();
      }
    });
  }

  void _showOverlay() {
    _removeOverlay();

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
              children: widget.suggestions
                  .where(
                    (suggestion) => suggestion
                        .toLowerCase()
                        .contains(_controller.text.toLowerCase()),
                  )
                  .map(
                    (suggestion) => HoverButton(
                      onPressed: () {
                        _controller.text = suggestion;
                        widget.onSuggestionSelected?.call(suggestion);
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
                            suggestion,
                            style: theme.typography.body,
                          ),
                        );
                      },
                    ),
                  )
                  .toList(),
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
    final theme = FluentTheme.of(context);

    return CompositedTransformTarget(
      link: _layerLink,
      child: SizedBox(
        width: widget.width,
        child: TextBox(
          controller: _controller,
          focusNode: _focusNode,
          placeholder: widget.placeholder,
          enabled: widget.enabled,
          autofocus: widget.autofocus,
          onChanged: _onChanged,
          prefix: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(
              FluentIcons.search,
              size: 16,
              color: widget.enabled
                  ? theme.resources.textFillColorPrimary
                  : theme.resources.textFillColorDisabled,
            ),
          ),
          suffix: widget.showClearButton && _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(FluentIcons.clear, size: 16),
                  onPressed: widget.enabled
                      ? () {
                          _controller.clear();
                          widget.onChanged('');
                          _focusNode.unfocus();
                        }
                      : null,
                )
              : null,
          style: theme.typography.body?.copyWith(
            color: widget.enabled
                ? theme.resources.textFillColorPrimary
                : theme.resources.textFillColorDisabled,
          ),
          decoration: BoxDecoration(
            color: widget.enabled
                ? theme.resources.controlFillColorDefault
                : theme.resources.controlFillColorDisabled,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: _focusNode.hasFocus
                  ? theme.accentColor
                  : widget.enabled
                      ? theme.resources.controlStrokeColorDefault
                      : theme.resources.controlFillColorDisabled,
            ),
          ),
        ),
      ),
    );
  }
}
