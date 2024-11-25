# EduPresence

A modern attendance tracking system built with Flutter, featuring a Windows desktop app for professors and a mobile app for students.

## Project Roadmap

### Phase 1: Setup & Infrastructure ( Completed)
- [x] Initialize Monorepo with Melos
- [x] Setup GitHub repository
- [x] Configure base melos.yaml
- [x] Configure root pubspec.yaml
- [x] Setup CI/CD pipelines
- [x] Setup Supabase project

### Phase 2: Core Packages Development ( In Progress)
- [x] edupresence_core
  - [x] Models (User, Class, AttendanceSession, AttendanceRecord)
  - [x] Repositories (all with proper error handling and query chaining)
  - [x] Providers (Riverpod with keepAlive)
- [ ] edupresence_ui
  - [ ] Fluent UI Components
    - [ ] QR code display
    - [ ] Attendance dashboard
    - [ ] Class management forms
  - [ ] Material Components
    - [ ] QR scanner
    - [ ] Class enrollment cards
    - [ ] Attendance history views
  - [x] Themes
- [ ] edupresence_supabase
  - [x] Supabase client
  - [ ] Auth services
    - [ ] Password reset
    - [ ] Email verification
    - [ ] Session refresh
  - [ ] Database services
    - [ ] Real-time subscriptions
    - [ ] Enhanced error handling
    - [ ] Data validation

### Phase 3: Apps Development ( Next Focus)
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

### Phase 4: Platform & Distribution ( Planned)
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

## Next Steps

1. Create the professor app (Windows):
   ```bash
   flutter create --platforms=windows professor
   cd professor
   flutter pub add fluent_ui edupresence_core edupresence_ui
   ```

2. Create the student app (Android):
   ```bash
   flutter create --platforms=android student
   cd student
   flutter pub add edupresence_core edupresence_ui
   ```

3. Implement authentication flows in both apps

4. Set up the development environment for platform-specific testing

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
│   ├── edupresence_core/      # Shared logic ( Complete)
│   ├── edupresence_ui/        # Shared UI components ( Complete)
│   └── edupresence_supabase/  # Supabase client ( Complete)
│
└── apps/
    ├── professor/             # Windows app ( Next)
    └── student/               # Mobile app ( Next)
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