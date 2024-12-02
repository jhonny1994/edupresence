import 'dart:math' as math;

import 'package:fluent_ui/fluent_ui.dart';

/// A data point for the chart.
class ChartDataPoint {
  const ChartDataPoint({
    required this.x,
    required this.y,
    this.label,
    this.color,
  });

  /// The x value of the data point.
  final double x;

  /// The y value of the data point.
  final double y;

  /// Optional label for the data point.
  final String? label;

  /// Optional color for this data point.
  final Color? color;
}

/// A series of data points for the chart.
class ChartSeries {
  const ChartSeries({
    required this.name,
    required this.data,
    this.color,
  });

  /// The name of this series.
  final String name;

  /// The data points in this series.
  final List<ChartDataPoint> data;

  /// The color for this series.
  final Color? color;
}

/// A basic line chart component.
class DesktopLineChart extends StatelessWidget {
  const DesktopLineChart({
    required this.series,
    super.key,
    this.width = 300,
    this.height = 200,
    this.padding = const EdgeInsets.all(20),
    this.showLabels = true,
    this.showGrid = true,
    this.gridColor,
    this.strokeWidth = 2.0,
  });

  /// The data series to display.
  final List<ChartSeries> series;

  /// The width of the chart.
  final double width;

  /// The height of the chart.
  final double height;

  /// Padding around the chart.
  final EdgeInsets padding;

  /// Whether to show axis labels.
  final bool showLabels;

  /// Whether to show grid lines.
  final bool showGrid;

  /// The color of grid lines.
  final Color? gridColor;

  /// The width of the line strokes.
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    // Find data ranges
    var minX = double.infinity;
    var maxX = -double.infinity;
    var minY = double.infinity;
    var maxY = -double.infinity;

    for (final series in series) {
      for (final point in series.data) {
        minX = math.min(minX, point.x);
        maxX = math.max(maxX, point.x);
        minY = math.min(minY, point.y);
        maxY = math.max(maxY, point.y);
      }
    }

    // Add some padding to the ranges
    final xRange = maxX - minX;
    final yRange = maxY - minY;
    minX -= xRange * 0.05;
    maxX += xRange * 0.05;
    minY -= yRange * 0.05;
    maxY += yRange * 0.05;

    return SizedBox(
      width: width,
      height: height,
      child: CustomPaint(
        painter: _LineChartPainter(
          series: series,
          minX: minX,
          maxX: maxX,
          minY: minY,
          maxY: maxY,
          padding: padding,
          showLabels: showLabels,
          showGrid: showGrid,
          gridColor: gridColor ?? theme.resources.controlStrokeColorDefault,
          strokeWidth: strokeWidth,
          theme: theme,
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  const _LineChartPainter({
    required this.series,
    required this.minX,
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.padding,
    required this.showLabels,
    required this.showGrid,
    required this.gridColor,
    required this.strokeWidth,
    required this.theme,
  });

  final List<ChartSeries> series;
  final double minX;
  final double maxX;
  final double minY;
  final double maxY;
  final EdgeInsets padding;
  final bool showLabels;
  final bool showGrid;
  final Color gridColor;
  final double strokeWidth;
  final FluentThemeData theme;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final drawableRect = Rect.fromLTRB(
      rect.left + padding.left,
      rect.top + padding.top,
      rect.right - padding.right,
      rect.bottom - padding.bottom,
    );

    // Draw grid
    if (showGrid) {
      final gridPaint = Paint()
        ..color = gridColor
        ..strokeWidth = 0.5;

      // Vertical grid lines
      for (var i = 0; i <= 10; i++) {
        final x = drawableRect.left + (drawableRect.width * i / 10);
        canvas.drawLine(
          Offset(x, drawableRect.top),
          Offset(x, drawableRect.bottom),
          gridPaint,
        );
      }

      // Horizontal grid lines
      for (var i = 0; i <= 10; i++) {
        final y = drawableRect.top + (drawableRect.height * i / 10);
        canvas.drawLine(
          Offset(drawableRect.left, y),
          Offset(drawableRect.right, y),
          gridPaint,
        );
      }
    }

    // Draw series
    for (var i = 0; i < series.length; i++) {
      final seriesData = series[i];
      final paint = Paint()
        ..color = seriesData.color ?? theme.accentColor
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke;

      final path = Path();
      var first = true;

      for (final point in seriesData.data) {
        final x = drawableRect.left +
            ((point.x - minX) / (maxX - minX)) * drawableRect.width;
        final y = drawableRect.bottom -
            ((point.y - minY) / (maxY - minY)) * drawableRect.height;

        if (first) {
          path.moveTo(x, y);
          first = false;
        } else {
          path.lineTo(x, y);
        }
      }

      canvas.drawPath(path, paint);
    }

    // Draw labels
    if (showLabels) {
      final textStyle = theme.typography.caption?.copyWith(
        color: theme.resources.textFillColorPrimary,
      );
      final textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center,
      );

      // X-axis labels
      for (var i = 0; i <= 10; i++) {
        final value = minX + (maxX - minX) * i / 10;
        final x = drawableRect.left + (drawableRect.width * i / 10);

        textPainter
          ..text = TextSpan(
            text: value.toStringAsFixed(1),
            style: textStyle,
          )
          ..layout()
          ..paint(
            canvas,
            Offset(
              x - textPainter.width / 2,
              drawableRect.bottom + 4,
            ),
          );
      }

      // Y-axis labels
      for (var i = 0; i <= 10; i++) {
        final value = minY + (maxY - minY) * (10 - i) / 10;
        final y = drawableRect.top + (drawableRect.height * i / 10);

        textPainter
          ..text = TextSpan(
            text: value.toStringAsFixed(1),
            style: textStyle,
          )
          ..layout()
          ..paint(
            canvas,
            Offset(
              padding.left - textPainter.width - 4,
              y - textPainter.height / 2,
            ),
          );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter oldDelegate) {
    return series != oldDelegate.series ||
        minX != oldDelegate.minX ||
        maxX != oldDelegate.maxX ||
        minY != oldDelegate.minY ||
        maxY != oldDelegate.maxY ||
        padding != oldDelegate.padding ||
        showLabels != oldDelegate.showLabels ||
        showGrid != oldDelegate.showGrid ||
        gridColor != oldDelegate.gridColor ||
        strokeWidth != oldDelegate.strokeWidth ||
        theme != oldDelegate.theme;
  }
}
