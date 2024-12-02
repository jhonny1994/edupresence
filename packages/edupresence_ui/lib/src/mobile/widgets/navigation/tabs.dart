import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MobileTabBar extends StatelessWidget implements PreferredSizeWidget {
  const MobileTabBar({
    required this.tabs,
    required this.controller,
    super.key,
    this.isScrollable = false,
    this.labelColor,
    this.unselectedLabelColor,
    this.indicatorColor,
    this.indicatorWeight = 2.0,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.padding,
    this.labelPadding,
    this.indicatorPadding,
  });

  final TabController controller;
  final Color? indicatorColor;
  final EdgeInsetsGeometry? indicatorPadding;
  final double indicatorWeight;
  final bool isScrollable;
  final Color? labelColor;
  final EdgeInsetsGeometry? labelPadding;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? padding;
  final List<Widget> tabs;
  final Color? unselectedLabelColor;
  final TextStyle? unselectedLabelStyle;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TabBar(
      tabs: tabs,
      controller: controller,
      isScrollable: isScrollable,
      labelColor: labelColor ?? theme.colorScheme.primary,
      unselectedLabelColor:
          unselectedLabelColor ?? theme.colorScheme.onSurface.withOpacity(0.64),
      indicatorColor: indicatorColor ?? theme.colorScheme.primary,
      indicatorWeight: indicatorWeight,
      labelStyle: labelStyle ??
          theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w500,
          ),
      unselectedLabelStyle: unselectedLabelStyle ?? theme.textTheme.titleSmall,
      padding: padding ?? EdgeInsets.zero,
      labelPadding: labelPadding,
      indicatorPadding: indicatorPadding ?? EdgeInsets.zero,
    );
  }
}

class MobileTabBarView extends StatelessWidget {
  const MobileTabBarView({
    required this.controller,
    required this.children,
    super.key,
    this.physics,
    this.dragStartBehavior = DragStartBehavior.start,
    this.viewportFraction = 1.0,
    this.clipBehavior = Clip.hardEdge,
  });

  final List<Widget> children;
  final Clip clipBehavior;
  final TabController controller;
  final DragStartBehavior dragStartBehavior;
  final ScrollPhysics? physics;
  final double viewportFraction;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: controller,
      physics: physics,
      dragStartBehavior: dragStartBehavior,
      viewportFraction: viewportFraction,
      clipBehavior: clipBehavior,
      children: children,
    );
  }
}
