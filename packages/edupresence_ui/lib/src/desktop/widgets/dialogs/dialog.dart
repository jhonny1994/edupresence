import 'package:edupresence_ui/src/desktop/widgets/buttons/button.dart';
import 'package:edupresence_ui/src/shared/colors.dart';
import 'package:fluent_ui/fluent_ui.dart';

/// Desktop dialog result
enum DesktopDialogResult {
  /// Confirm result
  confirm,

  /// Cancel result
  cancel,
}

/// Desktop dialog widget
class DesktopDialog extends StatelessWidget {
  /// Creates a desktop dialog
  const DesktopDialog({
    required this.title,
    required this.content,
    this.confirmText = 'Confirm',
    this.cancelText = 'Cancel',
    this.confirmVariant = DesktopButtonVariant.primary,
    this.cancelVariant = DesktopButtonVariant.secondary,
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
  final DesktopButtonVariant confirmVariant;

  /// The cancel button's variant
  final DesktopButtonVariant cancelVariant;

  /// The dialog's width
  final double width;

  /// Shows the dialog
  static Future<DesktopDialogResult?> show({
    required BuildContext context,
    required String title,
    required Widget content,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    DesktopButtonVariant confirmVariant = DesktopButtonVariant.primary,
    DesktopButtonVariant cancelVariant = DesktopButtonVariant.secondary,
    double width = 400,
  }) {
    return showDialog<DesktopDialogResult>(
      context: context,
      builder: (context) => DesktopDialog(
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
    return ContentDialog(
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
      ),
      content: SizedBox(
        width: width,
        child: content,
      ),
      actions: [
        DesktopButton(
          variant: cancelVariant,
          onPressed: () {
            Navigator.of(context).pop(DesktopDialogResult.cancel);
          },
          child: Text(cancelText),
        ),
        DesktopButton(
          variant: confirmVariant,
          onPressed: () {
            Navigator.of(context).pop(DesktopDialogResult.confirm);
          },
          child: Text(confirmText),
        ),
      ],
    );
  }
}
