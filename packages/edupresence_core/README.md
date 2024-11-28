# EduPresence Core

Core package for the EduPresence application, containing domain models, repository interfaces, and shared business logic.

## Features

### Value Objects
- [x] EmailAddress - Email validation and handling
- [x] Password - Password validation with rules
- [x] UniqueId - UUID-based identifiers
- [x] NonEmptyString - String validation

### Domain Entities
- [x] User - User model with role management
- [x] Class - Class/Course management
- [x] AttendanceSession - Session tracking
- [x] AttendanceRecord - Individual attendance records

### Repository Interfaces
- [x] IAuthRepository - Authentication operations
- [x] IClassRepository - Class management
- [x] IAttendanceRepository - Attendance tracking

### Enums
- [x] UserRole - Professor/Student roles
- [x] SessionStatus - Attendance session states
- [x] AttendanceStatus - Student attendance states

### Error Handling
- [x] Value Failures - Input validation errors
- [x] Auth Failures - Authentication errors
- [x] Class Failures - Class management errors
- [x] Attendance Failures - Attendance tracking errors

## Getting Started

Add this package to your Flutter project:

```yaml
dependencies:
  edupresence_core: 0.1.0
```

## Architecture

The package follows Domain-Driven Design principles:

- **Entities**: Core business objects
- **Value Objects**: Type-safe wrappers for primitive types
- **Repository Interfaces**: Abstract data access
- **Failure Classes**: Type-safe error handling

## Dependencies

- `freezed`: For immutable data classes
- `dartz`: For functional error handling
- `uuid`: For unique identifiers
- `flutter_riverpod`: For dependency injection

## Contributing

1. Ensure you have the latest Flutter SDK
2. Run tests: `flutter test`
3. Run analyzer: `flutter analyze`
4. Generate code: `flutter pub run build_runner build`
