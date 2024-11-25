import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

/// A widget that provides QR code scanning functionality
class MaterialQRScanner extends StatefulWidget {
  /// Creates a new [MaterialQRScanner] widget
  const MaterialQRScanner({
    required this.onDetect,
    this.aspectRatio = 1.0,
    this.fit = BoxFit.contain,
    this.overlayColor,
    this.overlayBorderRadius = 12.0,
    this.scannerHint = 'Position the QR code within the frame',
    super.key,
  });

  /// Callback function when a QR code is detected
  final void Function(String) onDetect;

  /// The aspect ratio of the scanner view
  final double aspectRatio;

  /// How to inscribe the camera preview into the space allocated during layout
  final BoxFit fit;

  /// The color of the scanning overlay
  final Color? overlayColor;

  /// The border radius of the scanning overlay
  final double overlayBorderRadius;

  /// The hint text shown below the scanner
  final String scannerHint;

  @override
  State<MaterialQRScanner> createState() => _MaterialQRScannerState();
}

class _MaterialQRScannerState extends State<MaterialQRScanner> {
  late MobileScannerController controller;
  bool isStarted = true;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final overlayColor = widget.overlayColor ?? theme.colorScheme.primary;

    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: widget.aspectRatio,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(widget.overlayBorderRadius),
                  child: MobileScanner(
                    controller: controller,
                    fit: widget.fit,
                    onDetect: (capture) {
                      final barcodes = capture.barcodes;
                      for (final barcode in barcodes) {
                        if (barcode.rawValue != null) {
                          widget.onDetect(barcode.rawValue!);
                          return;
                        }
                      }
                    },
                  ),
                ),
                // Scanning overlay
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: overlayColor.withOpacity(0.5),
                      width: 2,
                    ),
                    borderRadius:
                        BorderRadius.circular(widget.overlayBorderRadius),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Text(
                  widget.scannerHint,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        isStarted ? Icons.stop : Icons.play_arrow,
                        color: theme.colorScheme.primary,
                      ),
                      onPressed: () {
                        if (isStarted) {
                          controller.stop();
                        } else {
                          controller.start();
                        }
                        setState(() {
                          isStarted = !isStarted;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.flip_camera_ios,
                        color: theme.colorScheme.primary,
                      ),
                      onPressed: () => controller.switchCamera(),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.flash_on,
                        color: theme.colorScheme.primary,
                      ),
                      onPressed: () => controller.toggleTorch(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
