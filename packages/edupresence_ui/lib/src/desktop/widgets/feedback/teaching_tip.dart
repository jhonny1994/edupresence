import 'package:fluent_ui/fluent_ui.dart';

/// Position of the teaching tip relative to its target.
enum TeachingTipPosition {
  top,
  bottom,
  left,
  right,
}

/// A teaching tip that provides contextual information about a UI element.
class DesktopTeachingTip extends StatelessWidget {
  const DesktopTeachingTip({
    required this.title,
    required this.child,
    super.key,
    this.message,
    this.position = TeachingTipPosition.bottom,
    this.onClose,
    this.action,
    this.icon,
    this.width = 320,
  });

  /// The widget that the teaching tip points to.
  final Widget child;

  /// The title of the teaching tip.
  final String title;

  /// Optional additional message.
  final String? message;

  /// Position of the teaching tip relative to the target.
  final TeachingTipPosition position;

  /// Called when the close button is pressed.
  final VoidCallback? onClose;

  /// Optional action button.
  final Widget? action;

  /// Optional icon to display.
  final IconData? icon;

  /// Width of the teaching tip.
  final double width;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);

    return FlyoutTarget(
      controller: FlyoutController()
        ..showFlyout<void>(
          builder: (context) {
            return FlyoutContent(
              constraints: BoxConstraints(maxWidth: width),
              color: theme.resources.controlFillColorDefault,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: 20),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: Text(
                          title,
                          style: theme.typography.subtitle?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (onClose != null)
                        IconButton(
                          icon: const Icon(FluentIcons.chrome_close, size: 16),
                          onPressed: () {
                            onClose?.call();
                            Navigator.of(context).pop();
                          },
                        ),
                    ],
                  ),
                  if (message != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      message!,
                      style: theme.typography.body,
                    ),
                  ],
                  if (action != null) ...[
                    const SizedBox(height: 16),
                    action!,
                  ],
                ],
              ),
            );
          },
        ),
      child: child,
    );
  }
}
