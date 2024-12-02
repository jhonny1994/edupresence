# EduPresence Supabase

Supabase implementation package for EduPresence, providing authentication and database services through Supabase backend.

## Features

### Authentication
- [x] Basic Authentication
  - [x] Email/Password Registration
  - [x] Email/Password Sign In
  - [x] Sign Out
  - [x] Real-time Auth State

- [x] Advanced Authentication
  - [x] Email Verification
  - [x] Password Reset
  - [x] Google Sign In
  - [x] Session Management

- [x] Security
  - [x] Token Management
  - [x] Secure Storage
  - [x] Error Handling
  - [x] Input Validation

### Database (Coming Soon)
- [ ] Class Management
  - [ ] Create/Edit Classes
  - [ ] Student Enrollment
  - [ ] Teacher Assignment
  - [ ] Class Scheduling

- [ ] Attendance
  - [ ] Real-time Tracking
  - [ ] Attendance Reports
  - [ ] Absence Management
  - [ ] Statistics

- [ ] Offline Support
  - [ ] Local Storage
  - [ ] Data Sync
  - [ ] Conflict Resolution
  - [ ] Background Updates

## Getting Started

Add this package to your Flutter project:

```yaml
dependencies:
  edupresence_supabase: 0.1.0
```

### Configuration

1. Create a Supabase project at [supabase.com](https://supabase.com)
2. Set up environment variables:
   ```bash
   # Copy the example env file
   cp .env.example .env
   
   # Add your Supabase credentials
   SUPABASE_URL=your_project_url
   SUPABASE_ANON_KEY=your_anon_key
   ```

## Architecture

The package follows Clean Architecture principles:

- **Domain**: Implements core interfaces
- **Infrastructure**: Supabase-specific implementations
- **Application**: Services and state management

### Directory Structure
```
lib/
├── src/
│   ├── auth/           # Authentication implementation
│   │   ├── providers/  # Auth providers
│   │   └── repository/ # Auth repository
│   ├── config/         # Supabase configuration
│   └── database/       # Database implementation (Coming Soon)
└── edupresence_supabase.dart
```

## Dependencies

- `supabase_flutter`: For Supabase integration
- `flutter_riverpod`: For state management
- `dartz`: For functional programming
- `flutter_secure_storage`: For secure data storage

## Contributing

1. Ensure you have Flutter installed
2. Run tests: `flutter test`
3. Run analyzer: `flutter analyze`
4. Follow Supabase best practices:
   - [Supabase Auth](https://supabase.com/docs/guides/auth)
   - [Supabase Database](https://supabase.com/docs/guides/database)
