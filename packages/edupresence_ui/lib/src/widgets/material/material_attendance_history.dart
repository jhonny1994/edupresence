import 'package:flutter/material.dart';

/// A widget that displays attendance history using Material Design
class MaterialAttendanceHistory extends StatelessWidget {
  /// Creates a new [MaterialAttendanceHistory] widget
  const MaterialAttendanceHistory({
    required this.attendanceRecords,
    this.onRecordTap,
    super.key,
  });

  /// The attendance records to display
  final List<Map<String, dynamic>> attendanceRecords;

  /// Optional callback when a record is tapped
  final void Function(Map<String, dynamic> record)? onRecordTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return ListView.builder(
      itemCount: attendanceRecords.length,
      itemBuilder: (context, index) {
        final record = attendanceRecords[index];
        final session = record['attendance_session'] as Map<String, dynamic>;
        final classData = record['class'] as Map<String, dynamic>;
        final isPresent = record['status'] == 'present';
        final date = DateTime.parse(session['created_at'] as String);

        return Card(
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: InkWell(
            onTap: onRecordTap != null ? () => onRecordTap!(record) : null,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isPresent
                              ? colorScheme.primary
                              : colorScheme.error,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isPresent ? 'Present' : 'Absent',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: isPresent
                              ? colorScheme.primary
                              : colorScheme.error,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        _formatDate(date),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    classData['name'] as String,
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatTime(date),
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: theme.textTheme.bodySmall?.color,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          classData['location'] as String,
                          style: theme.textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
