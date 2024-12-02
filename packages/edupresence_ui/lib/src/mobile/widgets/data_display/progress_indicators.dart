import 'package:flutter/material.dart';

/// A circular progress indicator with Material Design styling.
class MobileCircularProgressIndicator extends StatelessWidget {
  const MobileCircularProgressIndicator({
    super.key,
    this.value,
    this.backgroundColor,
    this.color,
    this.strokeWidth = 4.0,
    this.semanticsLabel,
    this.semanticsValue,
  });

  /// The value of the progress indicator, from 0.0 to 1.0.
  /// If null, the indicator is indeterminate.
  final double? value;

  /// The background color of the progress indicator.
  final Color? backgroundColor;

  /// The color of the progress indicator.
  final Color? color;

  /// The width of the line used to draw the circle.
  final double strokeWidth;

  /// The semantic label for this progress indicator.
  final String? semanticsLabel;

  /// The semantic value for this progress indicator.
  final String? semanticsValue;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: value,
      backgroundColor: backgroundColor,
      color: color,
      strokeWidth: strokeWidth,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
    );
  }
}

/// A linear progress indicator with Material Design styling.
class MobileLinearProgressIndicator extends StatelessWidget {
  const MobileLinearProgressIndicator({
    super.key,
    this.value,
    this.backgroundColor,
    this.color,
    this.minHeight,
    this.semanticsLabel,
    this.semanticsValue,
  });

  /// The value of the progress indicator, from 0.0 to 1.0.
  /// If null, the indicator is indeterminate.
  final double? value;

  /// The background color of the progress indicator.
  final Color? backgroundColor;

  /// The color of the progress indicator.
  final Color? color;

  /// The minimum height of the line.
  final double? minHeight;

  /// The semantic label for this progress indicator.
  final String? semanticsLabel;

  /// The semantic value for this progress indicator.
  final String? semanticsValue;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: value,
      backgroundColor: backgroundColor,
      color: color,
      minHeight: minHeight,
      semanticsLabel: semanticsLabel,
      semanticsValue: semanticsValue,
    );
  }
}

/// A progress indicator that shows both text and a linear progress bar.
class MobileProgressBar extends StatelessWidget {
  const MobileProgressBar({
    required this.value,
    super.key,
    this.label,
    this.backgroundColor,
    this.color,
    this.minHeight,
    this.semanticsLabel,
    this.semanticsValue,
  });

  /// The value of the progress indicator, from 0.0 to 1.0.
  final double value;

  /// Optional label to display above the progress bar.
  final String? label;

  /// The background color of the progress indicator.
  final Color? backgroundColor;

  /// The color of the progress indicator.
  final Color? color;

  /// The minimum height of the line.
  final double? minHeight;

  /// The semantic label for this progress indicator.
  final String? semanticsLabel;

  /// The semantic value for this progress indicator.
  final String? semanticsValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 4),
        ],
        MobileLinearProgressIndicator(
          value: value,
          backgroundColor: backgroundColor,
          color: color,
          minHeight: minHeight,
          semanticsLabel: semanticsLabel,
          semanticsValue: semanticsValue,
        ),
      ],
    );
  }
}
