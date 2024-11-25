import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MaterialAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MaterialAppBar({
    required this.title,
    super.key,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.elevation = 0,
    this.backgroundColor,
    this.systemOverlayStyle,
    this.centerTitle = true,
    this.bottom,
    this.toolbarHeight,
    this.leadingWidth,
    this.primary = true,
    this.shadowColor,
  });
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final double elevation;
  final Color? backgroundColor;
  final SystemUiOverlayStyle? systemOverlayStyle;
  final bool centerTitle;
  final Widget? bottom;
  final double? toolbarHeight;
  final double? leadingWidth;
  final bool primary;
  final bool? shadowColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      title: Text(
        title,
        style: theme.textTheme.titleLarge?.copyWith(
          color: colorScheme.onSurface,
        ),
      ),
      actions: actions,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      elevation: elevation,
      backgroundColor: backgroundColor ?? colorScheme.surface,
      systemOverlayStyle: systemOverlayStyle ??
          (theme.brightness == Brightness.dark
              ? SystemUiOverlayStyle.light
              : SystemUiOverlayStyle.dark),
      centerTitle: centerTitle,
      bottom: bottom != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(48),
              child: bottom!,
            )
          : null,
      toolbarHeight: toolbarHeight,
      leadingWidth: leadingWidth,
      primary: primary,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 2,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        toolbarHeight ?? kToolbarHeight + (bottom != null ? 48 : 0),
      );
}
