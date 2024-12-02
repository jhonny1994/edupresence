# EduPresence

A modern attendance tracking system built with Flutter, featuring a Windows desktop app for professors and a mobile app for students.

## Project Roadmap

### Phase 1: Setup & Infrastructure 
- [x] Initialize Monorepo with Melos
- [x] Setup GitHub repository
- [x] Configure base melos.yaml
- [x] Configure root pubspec.yaml
- [x] Setup CI/CD pipelines
- [x] Setup Supabase project

### Phase 2: Core Packages Development 
- [x] edupresence_core
  - [x] Value Objects
  - [x] Authentication Features
  - [x] Infrastructure Layer
  - [x] Error Handling
  - [x] Logging System
- [x] edupresence_ui
  - [x] Fluent UI Components
  - [x] Material Components
  - [x] Themes
- [x] edupresence_supabase
  - [x] Supabase Authentication
  - [x] Google Sign-In
  - [x] Email Verification
  - [x] Password Reset

### Phase 3: Apps Development
- [ ] Professor App (Windows)
  - [ ] Setup Windows project
  - [ ] Authentication screens
  - [ ] Class management UI
  - [ ] QR code generation
  - [ ] Attendance monitoring dashboard
- [ ] Student App (Android)
  - [ ] Setup Android project
  - [ ] Authentication screens
  - [ ] Class enrollment UI
  - [ ] QR code scanner
  - [ ] Attendance history view

### Phase 4: Platform & Distribution
- [ ] Windows App
  - [ ] MSIX configuration
  - [ ] Release builds
  - [ ] Auto-updates
  - [ ] GitHub releases
- [ ] Android App
  - [ ] App signing
  - [ ] Release builds
  - [ ] Play Store listing
  - [ ] CI/CD for mobile

## Tech Stack

- **Framework**: Flutter
- **State Management**: Riverpod
- **Backend**: Supabase
- **Project Structure**: Melos Monorepo
- **UI Components**: 
  - Windows: Fluent UI
  - Mobile: Material Design 3
- **Architecture**: Clean Architecture
- **Error Handling**: Functional Programming with dartz

## Project Structure
```
edupresence/
├── packages/
│   ├── edupresence_core/      # Domain & Application layers
│   ├── edupresence_ui/        # UI components & themes
│   └── edupresence_supabase/  # Infrastructure layer
│
└── apps/
    ├── professor/             # Windows app
    └── student/               # Mobile app
```

## Getting Started

### Prerequisites
- Flutter SDK
- Dart SDK
- Melos
- Android Studio / VS Code
- Windows development setup (for Professor app)
- Android development setup (for Student app)

### Installation

1. Clone the repository
```bash
git clone https://github.com/jhonny1994/edupresence.git
```

2. Install dependencies
```bash
melos bootstrap
```

### Configuration

1. Create a Supabase project at [supabase.com](https://supabase.com)
2. Copy the example env file and add your Supabase credentials:
```bash
cp .env.example .env
```

## Contributing

1. Ensure you have Flutter installed
2. Run tests: `flutter test`
3. Run analyzer: `flutter analyze`
4. Follow the project's architecture guidelines

## License

This project is licensed under the MIT License.