# EduPresence Supabase

Supabase integration package for EduPresence, providing database and authentication services.

## Features

### Supabase Client
- Configured Supabase client for the application
- Environment-based configuration
- Secure credential management

### Authentication Services
- User authentication flows
- Session management
- Role-based access control

### Database Services
- Table definitions and schemas
- Database access methods
- Real-time subscriptions support

## Configuration

Create a `.env` file in the package root:
```env
SUPABASE_URL=your_project_url
SUPABASE_ANON_KEY=your_anon_key
```

## Usage

Add to your `pubspec.yaml`:
```yaml
dependencies:
  edupresence_supabase:
    path: ../edupresence_supabase
```

## Example

```dart
// Access Supabase client
final supabase = ref.watch(supabaseClientProvider);

// Authenticate user
final response = await supabase.auth.signInWithPassword(
  email: email,
  password: password,
);

// Access database
final data = await supabase
  .from('users')
  .select()
  .eq('role', 'professor');
```
