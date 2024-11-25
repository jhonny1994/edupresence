import 'package:fluent_ui/fluent_ui.dart';

/// A widget that displays an attendance dashboard using Fluent UI styling
class FluentAttendanceDashboard extends StatelessWidget {
  /// Creates a new [FluentAttendanceDashboard] widget
  const FluentAttendanceDashboard({
    required this.attendanceData,
    required this.onSessionClose,
    this.onStudentTap,
    super.key,
  });

  /// The attendance data to display
  /// Should be a list of maps containing student information and attendance status
  final List<Map<String, dynamic>> attendanceData;

  /// Callback when a session is closed
  final void Function() onSessionClose;

  /// Optional callback when a student is tapped
  final void Function(String studentId)? onStudentTap;

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    final presentCount = attendanceData
        .where((record) => record['status'] == 'present')
        .length;
    final totalCount = attendanceData.length;
    final attendanceRate = totalCount > 0 ? (presentCount / totalCount) : 0.0;

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Attendance Dashboard',
                  style: theme.typography.subtitle,
                ),
                FilledButton(
                  child: const Text('Close Session'),
                  onPressed: onSessionClose,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Attendance summary
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              backgroundColor: theme.accentColor.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _StatCard(
                      label: 'Present',
                      value: presentCount.toString(),
                      theme: theme,
                    ),
                    _StatCard(
                      label: 'Total',
                      value: totalCount.toString(),
                      theme: theme,
                    ),
                    _StatCard(
                      label: 'Rate',
                      value: '${(attendanceRate * 100).toStringAsFixed(1)}%',
                      theme: theme,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Attendance list
          Expanded(
            child: ListView.builder(
              itemCount: attendanceData.length,
              itemBuilder: (context, index) {
                final record = attendanceData[index];
                final student = record['student'] as Map<String, dynamic>;
                final isPresent = record['status'] == 'present';

                return ListTile(
                  leading: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isPresent ? Colors.green : Colors.red,
                    ),
                  ),
                  title: Text(student['full_name'] as String),
                  subtitle: Text(student['email'] as String),
                  trailing: Text(
                    isPresent ? 'Present' : 'Absent',
                    style: theme.typography.body?.copyWith(
                      color: isPresent ? Colors.green : Colors.red,
                    ),
                  ),
                  onPressed: onStudentTap != null
                      ? () => onStudentTap!(student['id'] as String)
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.theme,
  });

  final String label;
  final String value;
  final FluentThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: theme.typography.title?.copyWith(
            color: theme.accentColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: theme.typography.body,
        ),
      ],
    );
  }
}
