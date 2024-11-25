import 'package:fluent_ui/fluent_ui.dart';

/// A form for creating or editing a class using Fluent UI styling
class FluentClassForm extends StatefulWidget {
  /// Creates a new [FluentClassForm] widget
  const FluentClassForm({
    this.initialData,
    required this.onSubmit,
    this.submitLabel = 'Save',
    super.key,
  });

  /// Initial data for editing an existing class
  final Map<String, dynamic>? initialData;

  /// Callback when the form is submitted
  final void Function(Map<String, dynamic> data) onSubmit;

  /// Label for the submit button
  final String submitLabel;

  @override
  State<FluentClassForm> createState() => _FluentClassFormState();
}

class _FluentClassFormState extends State<FluentClassForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _codeController;
  late final TextEditingController _scheduleController;
  late final TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.initialData?['name'] as String? ?? '',
    );
    _descriptionController = TextEditingController(
      text: widget.initialData?['description'] as String? ?? '',
    );
    _codeController = TextEditingController(
      text: widget.initialData?['code'] as String? ?? '',
    );
    _scheduleController = TextEditingController(
      text: widget.initialData?['schedule'] as String? ?? '',
    );
    _locationController = TextEditingController(
      text: widget.initialData?['location'] as String? ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _codeController.dispose();
    _scheduleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'code': _codeController.text,
        'schedule': _scheduleController.text,
        'location': _locationController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InfoLabel(
            label: 'Class Name',
            child: TextFormBox(
              controller: _nameController,
              placeholder: 'Enter class name',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a class name';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: 'Description',
            child: TextFormBox(
              controller: _descriptionController,
              placeholder: 'Enter class description',
              maxLines: 3,
            ),
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: 'Class Code',
            child: TextFormBox(
              controller: _codeController,
              placeholder: 'Enter class code',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a class code';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: 'Schedule',
            child: TextFormBox(
              controller: _scheduleController,
              placeholder: 'Enter class schedule',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a class schedule';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 16),
          InfoLabel(
            label: 'Location',
            child: TextFormBox(
              controller: _locationController,
              placeholder: 'Enter class location',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a class location';
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _handleSubmit,
            child: Text(widget.submitLabel),
          ),
        ],
      ),
    );
  }
}
