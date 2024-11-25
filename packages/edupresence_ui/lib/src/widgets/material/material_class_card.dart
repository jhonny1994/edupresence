import 'package:flutter/material.dart';

/// A card widget for displaying class information using Material Design
class MaterialClassCard extends StatelessWidget {
  /// Creates a new [MaterialClassCard] widget
  const MaterialClassCard({
    required this.classData,
    this.onTap,
    this.onEnroll,
    this.isEnrolled = false,
    super.key,
  });

  /// The class data to display
  final Map<String, dynamic> classData;

  /// Callback when the card is tapped
  final VoidCallback? onTap;

  /// Callback when the enroll button is tapped
  final VoidCallback? onEnroll;

  /// Whether the student is enrolled in this class
  final bool isEnrolled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: colorScheme.primaryContainer,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    classData['name'] as String,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    classData['code'] as String,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onPrimaryContainer.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (classData['description'] != null) ...[
                    Text(
                      classData['description'] as String,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),
                  ],
                  Row(
                    children: [
                      Icon(
                        Icons.schedule,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          classData['schedule'] as String,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          classData['location'] as String,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  if (onEnroll != null) ...[
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: isEnrolled ? null : onEnroll,
                        child: Text(isEnrolled ? 'Enrolled' : 'Enroll'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
