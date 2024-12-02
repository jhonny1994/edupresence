import 'package:edupresence_ui/src/mobile/widgets/buttons/button.dart';
import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:flutter/material.dart';

/// Mobile dialog result
enum MobileDialogResult {
  /// Confirm result
  confirm,

  /// Cancel result
  cancel,
}

/// Mobile dialog widget
class MobileDialog extends StatelessWidget {
  /// Creates a mobile dialog
  const MobileDialog({
    required this.title,
    required this.content,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.confirmVariant = MobileButtonVariant.primary,
    this.cancelVariant = MobileButtonVariant.secondary,
    this.width = 400,
    super.key,
  });

  /// The dialog's title
  final String title;

  /// The dialog's content
  final Widget content;

  /// The confirm button's text
  final String confirmText;

  /// The cancel button's text
  final String cancelText;

  /// The confirm button's variant
  final MobileButtonVariant confirmVariant;

  /// The cancel button's variant
  final MobileButtonVariant cancelVariant;

  /// The dialog's width
  final double width;

  /// Shows the dialog
  static Future<MobileDialogResult?> show({
    required BuildContext context,
    required String title,
    required Widget content,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    MobileButtonVariant confirmVariant = MobileButtonVariant.primary,
    MobileButtonVariant cancelVariant = MobileButtonVariant.secondary,
    double width = 400,
  }) {
    return showDialog<MobileDialogResult>(
      context: context,
      builder: (context) => MobileDialog(
        title: title,
        content: content,
        confirmText: confirmText,
        cancelText: cancelText,
        confirmVariant: confirmVariant,
        cancelVariant: cancelVariant,
        width: width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: width,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            content,
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MobileButton(
                  variant: cancelVariant,
                  onPressed: () {
                    Navigator.of(context).pop(MobileDialogResult.cancel);
                  },
                  child: Text(cancelText),
                ),
                const SizedBox(width: 8),
                MobileButton(
                  variant: confirmVariant,
                  onPressed: () {
                    Navigator.of(context).pop(MobileDialogResult.confirm);
                  },
                  child: Text(confirmText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
