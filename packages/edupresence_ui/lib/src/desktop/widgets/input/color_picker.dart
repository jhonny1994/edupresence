import 'package:fluent_ui/fluent_ui.dart';

/// A color picker component for desktop applications.
class DesktopColorPicker extends StatefulWidget {
  const DesktopColorPicker({
    required this.color,
    required this.onColorChanged,
    super.key,
    this.showAlpha = true,
    this.showPreview = true,
    this.showHexInput = true,
  });

  /// The current color.
  final Color color;

  /// Called when the color changes.
  final ValueChanged<Color> onColorChanged;

  /// Whether to show alpha channel control.
  final bool showAlpha;

  /// Whether to show color preview.
  final bool showPreview;

  /// Whether to show hex color input.
  final bool showHexInput;

  @override
  State<DesktopColorPicker> createState() => _DesktopColorPickerState();
}

class _DesktopColorPickerState extends State<DesktopColorPicker> {
  late TextEditingController _hexController;
  late HSVColor _hsvColor;

  @override
  void initState() {
    super.initState();
    _hsvColor = HSVColor.fromColor(widget.color);
    _hexController = TextEditingController(
      text: '#${widget.color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
    );
  }

  @override
  void dispose() {
    _hexController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(DesktopColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.color != oldWidget.color) {
      _hsvColor = HSVColor.fromColor(widget.color);
      _hexController.text =
          '#${widget.color.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    }
  }

  void _handleHSVChanged(HSVColor color) {
    _hsvColor = color;
    final rgbColor = color.toColor();
    widget.onColorChanged(rgbColor);
    if (widget.showHexInput) {
      _hexController.text =
          '#${rgbColor.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
    }
  }

  void _handleHexChanged(String value) {
    if (value.length != 9) return; // Including #
    try {
      final color = Color(int.parse(value.substring(1), radix: 16));
      _hsvColor = HSVColor.fromColor(color);
      widget.onColorChanged(color);
    } catch (e) {
      // Invalid hex color
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Color preview
        if (widget.showPreview) ...[
          Container(
            width: 200,
            height: 40,
            decoration: BoxDecoration(
              color: _hsvColor.toColor(),
              border: Border.all(
                color: theme.resources.controlStrokeColorDefault,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],

        // HSV sliders
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hue slider
            Text(
              'Hue',
              style: theme.typography.body,
            ),
            const SizedBox(height: 8),
            Slider(
              value: _hsvColor.hue,
              max: 360,
              onChanged: (value) {
                _handleHSVChanged(
                  _hsvColor.withHue(value),
                );
              },
            ),
            const SizedBox(height: 16),

            // Saturation slider
            Text(
              'Saturation',
              style: theme.typography.body,
            ),
            const SizedBox(height: 8),
            Slider(
              value: _hsvColor.saturation,
              onChanged: (value) {
                _handleHSVChanged(
                  _hsvColor.withSaturation(value),
                );
              },
            ),
            const SizedBox(height: 16),

            // Value slider
            Text(
              'Value',
              style: theme.typography.body,
            ),
            const SizedBox(height: 8),
            Slider(
              value: _hsvColor.value,
              onChanged: (value) {
                _handleHSVChanged(
                  _hsvColor.withValue(value),
                );
              },
            ),

            // Alpha slider
            if (widget.showAlpha) ...[
              const SizedBox(height: 16),
              Text(
                'Alpha',
                style: theme.typography.body,
              ),
              const SizedBox(height: 8),
              Slider(
                value: _hsvColor.alpha,
                onChanged: (value) {
                  _handleHSVChanged(
                    _hsvColor.withAlpha(value),
                  );
                },
              ),
            ],
          ],
        ),

        // Hex input
        if (widget.showHexInput) ...[
          const SizedBox(height: 16),
          TextBox(
            controller: _hexController,
            placeholder: '#AARRGGBB',
            maxLength: 9,
            onChanged: _handleHexChanged,
          ),
        ],
      ],
    );
  }
}
