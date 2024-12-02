# EduPresence UI

UI package for the EduPresence application, providing a comprehensive set of UI components and theming support for both desktop (Fluent UI) and mobile (Material Design) platforms.

## Features

### Desktop Components (Fluent UI)
- [x] Navigation
  - [x] Navigation View
  - [x] Navigation Rail
  - [x] Breadcrumb
  - [x] Navigation Pane

- [x] Data Display
  - [x] Data Grid
  - [x] Tree View
  - [x] List View
  - [x] Info Bar

- [x] Forms
  - [x] Text Input
  - [x] Dropdown
  - [x] Checkbox
  - [x] Radio Button

- [x] Feedback
  - [x] Progress Ring
  - [x] Progress Bar
  - [x] Info Bar
  - [x] Dialog

### Mobile Components (Material)
- [x] Navigation
  - [x] App Bar
  - [x] Bottom Navigation Bar
  - [x] Navigation Drawer
  - [x] Tabs

- [x] Data Display
  - [x] Data Table
  - [x] List View
  - [x] Card
  - [x] Grid View

- [x] Forms
  - [x] Text Input
  - [x] Dropdown
  - [x] Checkbox
  - [x] Radio Button

- [x] Feedback
  - [x] Progress Indicator
  - [x] Dialog
  - [x] Snackbar
  - [x] Bottom Sheet

### Theming
- [x] Base Theme Interface
  - [x] Color Schemes
  - [x] Typography
  - [x] Spacing
  - [x] Animation Durations
  - [x] Elevation Levels

- [x] Material Theme
  - [x] Light/Dark Variants
  - [x] Component-specific Themes
  - [x] Custom Color Schemes

- [x] Fluent Theme
  - [x] Light/Dark Variants
  - [x] Component-specific Themes
  - [x] Custom Color Schemes

- [x] Theme Management
  - [x] Theme Mode Switching
  - [x] Theme Persistence
  - [x] Platform-specific Themes

## Getting Started

Add this package to your Flutter project:

```yaml
dependencies:
  edupresence_ui: 0.1.0
```

## Architecture

The package follows a platform-specific component architecture:

- **Desktop**: Fluent UI components for Windows
- **Mobile**: Material Design components for Android/iOS
- **Shared**: Common utilities and theme management

## Dependencies

- `fluent_ui`: For Windows desktop components
- `flutter_riverpod`: For state management
- `shared_preferences`: For theme persistence
- `window_manager`: For desktop window management

## Contributing

1. Ensure you have the latest Flutter SDK
2. Run tests: `flutter test`
3. Run analyzer: `flutter analyze`
4. Follow platform-specific design guidelines:
   - [Fluent Design](https://learn.microsoft.com/en-us/windows/apps/design/basics/)
   - [Material Design](https://m3.material.io/)
