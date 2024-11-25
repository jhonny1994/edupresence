import 'package:fluent_ui/fluent_ui.dart';

/// A Fluent UI styled loading indicator.
class FluentLoading extends StatelessWidget {
  /// Creates a Fluent UI styled loading indicator.
  const FluentLoading({
    super.key,
    this.message,
    this.size = 20.0,
    this.strokeWidth = 2.0,
    this.color,
  });

  /// The message to display below the loading indicator.
  final String? message;

  /// The size of the loading indicator.
  final double size;

  /// The stroke width of the loading indicator.
  final double strokeWidth;

  /// The color of the loading indicator.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final effectiveColor = color ?? theme.accentColor;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: ProgressRing(
            activeColor: effectiveColor,
            strokeWidth: strokeWidth,
          ),
        ),
        if (message != null) ...[
          const SizedBox(height: 8),
          Text(
            message!,
            style: theme.typography.caption?.copyWith(
              color: theme.resources.textFillColorSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
