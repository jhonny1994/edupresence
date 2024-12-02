import 'package:fluent_ui/fluent_ui.dart';

/// Severity level for the info bar.
enum InfoBarSeverity {
  info,
  success,
  warning,
  error,
}

/// A bar that displays information, warnings, errors, or success messages.
class DesktopInfoBar extends StatelessWidget {
  const DesktopInfoBar({
    required this.title,
    super.key,
    this.message,
    this.severity = InfoBarSeverity.info,
    this.isLong = false,
    this.onClose,
    this.action,
  });

  /// The title of the info bar.
  final String title;

  /// Optional additional message.
  final String? message;

  /// The severity level of the info bar.
  final InfoBarSeverity severity;

  /// Whether to show the info bar in a longer format.
  final bool isLong;

  /// Called when the close button is pressed.
  final VoidCallback? onClose;

  /// Optional action button.
  final Widget? action;

  IconData get _severityIcon {
    switch (severity) {
      case InfoBarSeverity.info:
        return FluentIcons.info;
      case InfoBarSeverity.success:
        return FluentIcons.completed;
      case InfoBarSeverity.warning:
        return FluentIcons.warning;
      case InfoBarSeverity.error:
        return FluentIcons.error_badge;
    }
  }

  Color _getSeverityColor(BuildContext context) {
    final theme = FluentTheme.of(context);
    switch (severity) {
      case InfoBarSeverity.info:
        return theme.accentColor;
      case InfoBarSeverity.success:
        return const Color(0xFF0F7B0F);
      case InfoBarSeverity.warning:
        return const Color(0xFFFFB900);
      case InfoBarSeverity.error:
        return const Color(0xFFE81123);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final severityColor = _getSeverityColor(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.resources.controlFillColorDefault,
        border: Border.all(color: severityColor),
        borderRadius: BorderRadius.circular(4),
      ),
      child: isLong
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(theme, severityColor),
                if (message != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 16, 12),
                    child: Text(
                      message!,
                      style: theme.typography.body,
                    ),
                  ),
                if (action != null)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40, 0, 16, 12),
                    child: action,
                  ),
              ],
            )
          : _buildHeader(theme, severityColor),
    );
  }

  Widget _buildHeader(FluentThemeData theme, Color severityColor) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Icon(
            _severityIcon,
            color: severityColor,
            size: 16,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: theme.typography.body?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (onClose != null) ...[
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(FluentIcons.chrome_close, size: 16),
              onPressed: onClose,
            ),
          ],
        ],
      ),
    );
  }
}
