import 'package:edupresence_ui/src/desktop/theme.dart';
import 'package:edupresence_ui/src/mobile/theme.dart';
import 'package:edupresence_ui/src/shared/theme/theme.dart';
import 'package:fluent_ui/fluent_ui.dart' as fluent;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Duration for theme animations
const _themeDuration = Duration(milliseconds: 300);

/// Animated theme builder for mobile platform
class AnimatedMobileTheme extends ConsumerWidget {
  /// Creates an animated theme builder for mobile
  const AnimatedMobileTheme({
    required this.child,
    this.duration = _themeDuration,
    super.key,
  });

  /// The child widget
  final Widget child;

  /// Animation duration
  final Duration duration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark =
        ref.watch(themeControllerProvider.notifier).isDarkMode(context);

    return AnimatedTheme(
      data: isDark ? MobileTheme.dark : MobileTheme.light,
      duration: duration,
      child: AnimatedDefaultTextStyle(
        style: (isDark ? MobileTheme.dark : MobileTheme.light)
            .textTheme
            .bodyMedium!,
        duration: duration,
        child: child,
      ),
    );
  }
}

/// Animated theme builder for desktop platform
class AnimatedDesktopTheme extends ConsumerWidget {
  /// Creates an animated theme builder for desktop
  const AnimatedDesktopTheme({
    required this.child,
    this.duration = _themeDuration,
    super.key,
  });

  /// The child widget
  final Widget child;

  /// Animation duration
  final Duration duration;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark =
        ref.watch(themeControllerProvider.notifier).isDarkMode(context);
    final theme = isDark ? DesktopTheme.dark : DesktopTheme.light;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: isDark ? 0.0 : 1.0, end: isDark ? 1.0 : 0.0),
      duration: duration,
      builder: (context, value, child) {
        return fluent.FluentTheme(
          data: theme,
          child: AnimatedDefaultTextStyle(
            style: theme.typography.body!,
            duration: duration,
            child: child!,
          ),
        );
      },
      child: child,
    );
  }
}

/// Theme transition type
enum ThemeTransitionType {
  /// Fade transition
  fade,

  /// Circular reveal transition
  circularReveal
}

/// Animated theme switcher that supports different transition types
class AnimatedThemeSwitcher extends ConsumerWidget {
  /// Creates an animated theme switcher
  const AnimatedThemeSwitcher({
    required this.child,
    this.duration = _themeDuration,
    this.type = ThemeTransitionType.fade,
    this.revealOrigin,
    super.key,
  });

  /// The child widget
  final Widget child;

  /// Animation duration
  final Duration duration;

  /// Transition type
  final ThemeTransitionType type;

  /// Origin point for circular reveal animation
  final Offset? revealOrigin;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark =
        ref.watch(themeControllerProvider.notifier).isDarkMode(context);

    switch (type) {
      case ThemeTransitionType.fade:
        return AnimatedSwitcher(
          duration: duration,
          child: Container(
            key: ValueKey(isDark),
            child: child,
          ),
        );
      case ThemeTransitionType.circularReveal:
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: duration,
          builder: (context, value, child) {
            return ShaderMask(
              shaderCallback: (bounds) {
                final origin = revealOrigin ??
                    Offset(
                      bounds.width / 2,
                      bounds.height / 2,
                    );
                return RadialGradient(
                  center: Alignment(
                    (origin.dx / bounds.width) * 2 - 1,
                    (origin.dy / bounds.height) * 2 - 1,
                  ),
                  radius: value * 5.0,
                  colors: const [Colors.transparent, Colors.black],
                  stops: const [0.0, 1.0],
                ).createShader(bounds);
              },
              child: child,
            );
          },
          child: child,
        );
    }
  }
}
