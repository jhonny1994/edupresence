import 'package:fluent_ui/fluent_ui.dart';
import 'package:qr_flutter/qr_flutter.dart';

/// A widget that displays a QR code using Fluent UI styling
class FluentQRDisplay extends StatelessWidget {
  /// Creates a new [FluentQRDisplay] widget
  const FluentQRDisplay({
    required this.data,
    this.size = 200.0,
    this.backgroundColor,
    this.foregroundColor,
    this.label = 'Scan this QR code to mark attendance',
    super.key,
  });

  /// The data to encode in the QR code
  final String data;

  /// The size of the QR code
  final double size;

  /// The background color of the QR code
  final Color? backgroundColor;

  /// The foreground color of the QR code
  final Color? foregroundColor;

  /// The label text shown below the QR code
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return Card(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              QrImageView(
                data: data,
                size: size,
                backgroundColor:
                    backgroundColor ?? theme.scaffoldBackgroundColor,
                foregroundColor: foregroundColor ?? theme.accentColor,
                eyeStyle: QrEyeStyle(
                  eyeShape: QrEyeShape.square,
                  color: foregroundColor ?? theme.accentColor,
                ),
                dataModuleStyle: QrDataModuleStyle(
                  dataModuleShape: QrDataModuleShape.square,
                  color: foregroundColor ?? theme.accentColor,
                ),
                embeddedImage: const AssetImage('assets/images/app_icon.png'),
                embeddedImageStyle: const QrEmbeddedImageStyle(
                  size: Size(40, 40),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                label,
                style: theme.typography.body,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
