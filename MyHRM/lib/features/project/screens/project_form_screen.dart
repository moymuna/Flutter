import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/project/providers/project_providers.dart';
import 'package:my_hrm/features/project/data/models/project.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';

class ProjectFormScreen extends ConsumerStatefulWidget {
  const ProjectFormScreen({super.key, this.projectId});
  final int? projectId;
  @override
  ConsumerState<ProjectFormScreen> createState() => _ProjectFormScreenState();
}

class _ProjectFormScreenState extends ConsumerState<ProjectFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.projectId != null) _load();
  }

  Future<void> _load() async {
    final p = await ref.read(projectByIdProvider(widget.projectId!).future);
    _nameController.text = p.name ?? '';
    _descriptionController.text = p.description ?? '';
    _startDateController.text = p.startDate ?? '';
    _endDateController.text = p.endDate ?? '';
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(projectRepositoryProvider);
      final dto = ProjectRequest(
        name: _nameController.text,
        description: _descriptionController.text,
        startDate: _startDateController.text,
        endDate: _endDateController.text,
      );
      if (widget.projectId == null) {
        await repo.create(dto);
      } else {
        await repo.update(widget.projectId!, dto);
      }
      ref.invalidate(projectsProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Project saved')),
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
    final isEdit = widget.projectId != null;
    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Project' : 'New Project')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            AppTextField(
              controller: _nameController,
              label: 'Name',
              prefixIcon: Icons.folder,
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
