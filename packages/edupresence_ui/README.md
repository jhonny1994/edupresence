# EduPresence UI

Shared UI components package for EduPresence, providing both Fluent UI (Windows) and Material Design (Mobile) components.

## Features

### Fluent UI Components
- Custom styled Fluent UI components for Windows
- Windows-specific navigation patterns
- Desktop-optimized layouts

### Material Components
- Material Design 3 components for mobile
- Mobile-specific navigation patterns
- Touch-optimized layouts

### Themes
- Consistent theming across platforms
- Dark/light mode support
- Brand color schemes

## Usage

Add to your `pubspec.yaml`:
```yaml
dependencies:
  edupresence_ui:
    path: ../edupresence_ui
```

## Example

```dart
// Windows UI (Fluent)
FluentApp(
  theme: FluentThemeData(
    accentColor: Colors.blue,
    brightness: Brightness.light,
  ),
  home: const HomePage(),
);

// Mobile UI (Material)
MaterialApp(
  theme: ThemeData(
    useMaterial3: true,
    colorScheme: lightColorScheme,
  ),
  home: const HomePage(),
);
```

## Platform-Specific Components

### Windows
- Navigation view
- Command bar
- Content dialogs
- Data grids

### Mobile
- Bottom navigation
- FAB
- Modal sheets
- List views
