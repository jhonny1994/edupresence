import 'package:edupresence_ui/src/theme/fluent_colors.dart';
import 'package:fluent_ui/fluent_ui.dart';

/// Fluent UI theme data
class FluentAppTheme {
  /// Light theme
  static FluentThemeData get light => FluentThemeData(
        brightness: Brightness.light,
        accentColor: AccentColor('accent', {
          'darkest': const Color(0xFF064474),
          'darker': const Color(0xFF085696),
          'dark': const Color(0xFF0A6EBD),
          'normal': FluentAppColors.accent,
          'light': const Color(0xFF3389D0),
          'lighter': const Color(0xFF5CA3DD),
          'lightest': const Color(0xFF85BDE9),
        }),
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: 4,
          primaryBorder: BorderSide(
            color: FluentAppColors.accent,
            width: 2,
          ),
        ),
        buttonTheme: ButtonThemeData(
          defaultButtonStyle: ButtonStyle(
            padding: WidgetStateProperty.resolveWith((states) {
              return const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              );
            }),
          ),
        ),
        navigationPaneTheme: NavigationPaneThemeData(
          backgroundColor: Colors.white,
          selectedIconColor: WidgetStateProperty.resolveWith(
            (states) => FluentAppColors.accent,
          ),
          unselectedIconColor: WidgetStateProperty.resolveWith(
            (states) => Colors.black.withOpacity(0.7),
          ),
          selectedTextStyle: WidgetStateProperty.resolveWith(
            (states) => const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          unselectedTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              color: Colors.black.withOpacity(0.7),
            ),
          ),
        ),
        tooltipTheme: const TooltipThemeData(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
        ),
        micaBackgroundColor: Colors.transparent,
      );

  /// Dark theme
  static FluentThemeData get dark => FluentThemeData(
        brightness: Brightness.dark,
        accentColor: AccentColor('accent', {
          'darkest': const Color(0xFF064474),
          'darker': const Color(0xFF085696),
          'dark': const Color(0xFF0A6EBD),
          'normal': FluentAppColors.darkAccent,
          'light': const Color(0xFF3389D0),
          'lighter': const Color(0xFF5CA3DD),
          'lightest': const Color(0xFF85BDE9),
        }),
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: 4,
          primaryBorder: BorderSide(
            color: FluentAppColors.darkAccent,
            width: 2,
          ),
        ),
        buttonTheme: ButtonThemeData(
          defaultButtonStyle: ButtonStyle(
            padding: WidgetStateProperty.resolveWith((states) {
              return const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              );
            }),
          ),
        ),
        navigationPaneTheme: NavigationPaneThemeData(
          backgroundColor: Colors.grey[150],
          selectedIconColor: WidgetStateProperty.resolveWith(
            (states) => FluentAppColors.darkAccent,
          ),
          unselectedIconColor: WidgetStateProperty.resolveWith(
            (states) => Colors.white.withOpacity(0.7),
          ),
          selectedTextStyle: WidgetStateProperty.resolveWith(
            (states) => const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          unselectedTextStyle: WidgetStateProperty.resolveWith(
            (states) => TextStyle(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
        tooltipTheme: const TooltipThemeData(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 4,
          ),
        ),
        micaBackgroundColor: Colors.transparent,
      );
}
