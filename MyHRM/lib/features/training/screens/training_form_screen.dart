import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/training/providers/training_providers.dart';
import 'package:my_hrm/features/training/data/models/training.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';

class TrainingFormScreen extends ConsumerStatefulWidget {
  const TrainingFormScreen({super.key, this.trainingId});
  final int? trainingId;
  @override
  ConsumerState<TrainingFormScreen> createState() => _TrainingFormScreenState();
}

class _TrainingFormScreenState extends ConsumerState<TrainingFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _locationController = TextEditingController();
  final _maxParticipantsController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.trainingId != null) _load();
  }

  Future<void> _load() async {
    final t = await ref.read(trainingByIdProvider(widget.trainingId!).future);
    _titleController.text = t.title ?? '';
    _descriptionController.text = t.description ?? '';
    _startDateController.text = t.startDate ?? '';
    _endDateController.text = t.endDate ?? '';
    _locationController.text = t.location ?? '';
    _maxParticipantsController.text = t.maxParticipants?.toString() ?? '';
    setState(() {});
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    _locationController.dispose();
    _maxParticipantsController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(trainingRepositoryProvider);
      final dto = TrainingRequest(
        title: _titleController.text,
        description: _descriptionController.text,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
        location: _locationController.text,
        maxParticipants: int.tryParse(_maxParticipantsController.text),
      );
      if (widget.trainingId == null) {
        await repo.create(dto);
      } else {
        await repo.update(widget.trainingId!, dto);
      }
      ref.invalidate(trainingsProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Training saved')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.trainingId != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Training' : 'New Training')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppTextField(
              controller: _titleController,
              label: 'Title',
              prefixIcon: Icons.title,
              validator: (v) => v == null || v.isEmpty ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _descriptionController,
              label: 'Description',
              prefixIcon: Icons.description,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _startDateController,
              label: 'Start Date',
              prefixIcon: Icons.calendar_today,
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _endDateController,
              label: 'End Date',
              prefixIcon: Icons.calendar_today,
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _locationController,
              label: 'Location',
              prefixIcon: Icons.location_on,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _maxParticipantsController,
              label: 'Max Participants',
              prefixIcon: Icons.people,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 24),
            LoadingButton(
              label: isEdit ? 'Update' : 'Create',
              loading: _isLoading,
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }
}
