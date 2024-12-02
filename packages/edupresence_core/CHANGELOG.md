## 0.1.0

Initial release with core functionality:

### Features
- Value Objects implementation (EmailAddress, Password, UniqueId, NonEmptyString)
- Domain Entities (User, Class, AttendanceSession, AttendanceRecord)
- Repository Interfaces (Auth, Class, Attendance)
- Enums (UserRole, SessionStatus, AttendanceStatus)
- Error Handling (Value, Auth, Class, Attendance Failures)

### Dependencies
- Added freezed for immutable classes
- Added dartz for functional error handling
- Added uuid for unique identifiers
- Added flutter_riverpod for dependency injection
