import 'package:fluent_ui/fluent_ui.dart';

/// A determinate progress ring that shows progress around a circle.
class DesktopProgressRing extends StatelessWidget {
  const DesktopProgressRing({
    super.key,
    this.value,
    this.strokeWidth = 4.0,
    this.size = 20.0,
    this.backgroundColor,
    this.activeColor,
  });

  /// Value between 0.0 and 1.0. If null, shows an indeterminate progress ring.
  final double? value;

  /// The width of the progress ring stroke.
  final double strokeWidth;

  /// The size of the progress ring.
  final double size;

  /// The background color of the progress ring.
  final Color? backgroundColor;

  /// The color of the progress indicator.
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    
    return SizedBox(
      width: size,
      height: size,
      child: ProgressRing(
        value: value,
        strokeWidth: strokeWidth,
        activeColor: activeColor ?? theme.accentColor,
        backgroundColor: backgroundColor ?? theme.resources.controlStrokeColorDefault,
      ),
    );
  }
}

/// A determinate progress bar that shows progress along a line.
class DesktopProgressBar extends StatelessWidget {
  const DesktopProgressBar({
    super.key,
    this.value,
    this.height = 4.0,
    this.backgroundColor,
    this.activeColor,
  });

  /// Value between 0.0 and 1.0. If null, shows an indeterminate progress bar.
  final double? value;

  /// The height of the progress bar.
  final double height;

  /// The background color of the progress bar.
  final Color? backgroundColor;

  /// The color of the progress indicator.
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    
    return ProgressBar(
      value: value,
      activeColor: activeColor ?? theme.accentColor,
      backgroundColor: backgroundColor ?? theme.resources.controlStrokeColorDefault,
    );
  }
}

/// A custom progress indicator that shows both a ring and a label.
class DesktopLabeledProgress extends StatelessWidget {
  const DesktopLabeledProgress({
    required this.label,
    super.key,
    this.value,
    this.useRing = true,
    this.showPercentage = true,
    this.progressSize = 20.0,
    this.progressStrokeWidth = 4.0,
    this.backgroundColor,
    this.activeColor,
  });

  /// The label to display.
  final Widget label;

  /// Value between 0.0 and 1.0. If null, shows an indeterminate progress.
  final double? value;

  /// Whether to use a ring (true) or bar (false).
  final bool useRing;

  /// Whether to show the percentage value.
  final bool showPercentage;

  /// Size of the progress indicator.
  final double progressSize;

  /// Stroke width of the progress ring (if useRing is true).
  final double progressStrokeWidth;

  /// The background color of the progress indicator.
  final Color? backgroundColor;

  /// The color of the progress indicator.
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (useRing)
          DesktopProgressRing(
            value: value,
            size: progressSize,
            strokeWidth: progressStrokeWidth,
            backgroundColor: backgroundColor,
            activeColor: activeColor,
          )
        else
          SizedBox(
            width: progressSize * 2,
            child: DesktopProgressBar(
              value: value,
              height: progressStrokeWidth,
              backgroundColor: backgroundColor,
              activeColor: activeColor,
            ),
          ),
        const SizedBox(width: 8),
        label,
        if (showPercentage && value != null) ...[
          const SizedBox(width: 8),
          Text(
            '${(value! * 100).toStringAsFixed(0)}%',
            style: theme.typography.body?.copyWith(
              color: theme.resources.textFillColorSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
