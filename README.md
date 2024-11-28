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
  - [x] Models
  - [x] Repositories
  - [x] Providers
- [ ] edupresence_ui
  - [ ] Fluent UI Components
  - [ ] Material Components
  - [ ] Themes
- [ ] edupresence_supabase
  - [ ] Supabase client
  - [ ] Auth services
  - [ ] Database services

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

## Project Structure
```
edupresence/
├── packages/
│   ├── edupresence_core/      # Shared logic
│   ├── edupresence_ui/        # Shared UI components
│   └── edupresence_supabase/  # Supabase client
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

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Author

- [@jhonny1994](https://github.com/jhonny1994)