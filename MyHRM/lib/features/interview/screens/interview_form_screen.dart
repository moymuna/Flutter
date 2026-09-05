import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/interview/providers/interview_providers.dart';
import 'package:my_hrm/features/interview/data/models/interview.dart';
import 'package:my_hrm/features/application/providers/application_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/core/widgets/app_dropdown.dart';
import 'package:my_hrm/shared/enums.dart';

class InterviewFormScreen extends ConsumerStatefulWidget {
  const InterviewFormScreen({super.key, this.interviewId});
  final int? interviewId;

  @override
  ConsumerState<InterviewFormScreen> createState() =>
      _InterviewFormScreenState();
}

class _InterviewFormScreenState extends ConsumerState<InterviewFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();

  int? _selectedApplicationId;
  InterviewType _selectedInterviewType = InterviewType.IN_PERSON;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.interviewId != null) _loadInterview();
  }

  Future<void> _loadInterview() async {
    final interview =
        await ref.read(interviewByIdProvider(widget.interviewId!).future);
    _dateController.text = interview.interviewDate ?? '';
    _timeController.text = interview.interviewTime ?? '';
    _locationController.text = interview.location ?? '';
    _notesController.text = interview.notes ?? '';
    _selectedApplicationId = interview.applicationId;
    _selectedInterviewType = InterviewType.values.firstWhere(
      (t) => t.name == interview.interviewType,
      orElse: () => InterviewType.IN_PERSON,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(interviewRepositoryProvider);
      final dto = InterviewRequest(
        applicationId: _selectedApplicationId,
        interviewDate: _dateController.text,
        interviewTime: _timeController.text,
        interviewType: _selectedInterviewType.name,
        location: _locationController.text,
        notes: _notesController.text,
      );
      if (widget.interviewId == null) {
        await repo.schedule(dto);
      } else {
        await repo.update(widget.interviewId!, dto);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Interview saved successfully')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.interviewId != null;
    final applicationsAsync = ref.watch(applicationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Interview' : 'Schedule Interview'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            applicationsAsync.when(
              data: (apps) => DropdownButtonFormField<int>(
                initialValue: _selectedApplicationId,
                decoration: const InputDecoration(
                  labelText: 'Application',
                  border: OutlineInputBorder(),
                ),
                items: apps
                    .map((a) => DropdownMenuItem(
                          value: a.id,
                          child: Text(
                            '${a.applicantName} - ${a.jobPostTitle}',
                          ),
                        ))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _selectedApplicationId = v),
                validator: (v) => v == null ? 'Required' : null,
              ),
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Error loading applications'),
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _dateController,
              label: 'Interview Date',
              prefixIcon: Icons.calendar_today,
              keyboardType: TextInputType.datetime,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _timeController,
              label: 'Interview Time',
              prefixIcon: Icons.access_time,
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16),
            AppEnumDropdown<InterviewType>(
              label: 'Interview Type',
              values: InterviewType.values,
              displayName: (t) => t.displayName,
              selectedValue: _selectedInterviewType,
              onChanged: (v) => setState(() => _selectedInterviewType = v!),
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _locationController,
              label: 'Location',
              prefixIcon: Icons.location_on,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _notesController,
              label: 'Notes',
              prefixIcon: Icons.notes,
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            LoadingButton(
              label: isEdit ? 'Update' : 'Schedule',
              loading: _isLoading,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
