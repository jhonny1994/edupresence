# EduPresence Core

Core package for the EduPresence attendance tracking system, containing shared business logic, models, and data access layers.

## Features

### Models
- `User`: User model with role-based access (professor/student)
- `Class`: Class model for managing course information
- `AttendanceSession`: Model for tracking attendance sessions
- `AttendanceRecord`: Model for individual attendance records

### Repositories
- `UserRepository`: Manages user data and authentication
- `ClassRepository`: Handles class creation and management
- `AttendanceSessionRepository`: Controls attendance session lifecycle
- `AttendanceRecord Repository`: Manages individual attendance records

### Providers
All repositories are provided through Riverpod providers with `keepAlive: true` for persistent state management.

## Usage

Add to your `pubspec.yaml`:
```yaml
dependencies:
  edupresence_core:
    path: ../edupresence_core
```

## Example

```dart
// Access repositories through providers
final userRepo = ref.watch(userRepositoryProvider);
final classRepo = ref.watch(classRepositoryProvider);

// Create a new class
final newClass = await classRepo.createClass(
  Class(
    name: 'Flutter Development',
    professorId: currentUser.id,
  ),
);

// Start an attendance session
final session = await attendanceSessionRepo.createSession(
  AttendanceSession(
    classId: newClass.id,
    startTime: DateTime.now(),
  ),
);
```
