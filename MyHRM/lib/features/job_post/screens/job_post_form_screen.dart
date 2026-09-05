import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/job_post/providers/job_post_providers.dart';
import 'package:my_hrm/features/job_post/data/models/job_post.dart';
import 'package:my_hrm/features/department/providers/department_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/core/widgets/app_dropdown.dart';
import 'package:my_hrm/shared/enums.dart';

class JobPostFormScreen extends ConsumerStatefulWidget {
  const JobPostFormScreen({super.key, this.jobPostId});
  final int? jobPostId;

  @override
  ConsumerState<JobPostFormScreen> createState() => _JobPostFormScreenState();
}

class _JobPostFormScreenState extends ConsumerState<JobPostFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _requirementsController = TextEditingController();
  final _responsibilitiesController = TextEditingController();
  final _salaryMinController = TextEditingController();
  final _salaryMaxController = TextEditingController();
  final _locationController = TextEditingController();
  final _deadlineController = TextEditingController();

  EmploymentType _selectedEmploymentType = EmploymentType.FULL_TIME;
  ExperienceLevel _selectedExperienceLevel = ExperienceLevel.MID;
  JobStatus _selectedStatus = JobStatus.DRAFT;
  int? _selectedDepartmentId;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.jobPostId != null) _loadJobPost();
  }

  Future<void> _loadJobPost() async {
    final job =
        await ref.read(jobPostByIdProvider(widget.jobPostId!).future);
    _titleController.text = job.title ?? '';
    _descriptionController.text = job.description ?? '';
    _requirementsController.text = job.requirements ?? '';
    _responsibilitiesController.text = job.responsibilities ?? '';
    _salaryMinController.text = job.salaryMin?.toString() ?? '';
    _salaryMaxController.text = job.salaryMax?.toString() ?? '';
    _locationController.text = job.location ?? '';
    _deadlineController.text = job.deadline ?? '';
    _selectedEmploymentType = EmploymentType.values.firstWhere(
      (e) => e.name == job.employmentType,
      orElse: () => EmploymentType.FULL_TIME,
    );
    _selectedExperienceLevel = ExperienceLevel.values.firstWhere(
      (e) => e.name == job.experienceLevel,
      orElse: () => ExperienceLevel.MID,
    );
    _selectedStatus = JobStatus.values.firstWhere(
      (s) => s.name == job.status,
      orElse: () => JobStatus.DRAFT,
    );
    _selectedDepartmentId = job.departmentId;
    setState(() {});
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _requirementsController.dispose();
    _responsibilitiesController.dispose();
    _salaryMinController.dispose();
    _salaryMaxController.dispose();
    _locationController.dispose();
    _deadlineController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(jobPostRepositoryProvider);
      final dto = JobPostRequest(
        title: _titleController.text,
        description: _descriptionController.text,
        requirements: _requirementsController.text,
        responsibilities: _responsibilitiesController.text,
        salaryMin: _salaryMinController.text,
        salaryMax: _salaryMaxController.text,
        location: _locationController.text,
        employmentType: _selectedEmploymentType.name,
        experienceLevel: _selectedExperienceLevel.name,
        status: _selectedStatus.name,
        departmentId: _selectedDepartmentId,
        deadline: _deadlineController.text,
      );
      if (widget.jobPostId == null) {
        await repo.create(dto);
      } else {
        await repo.update(widget.jobPostId!, dto);
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Job post saved successfully')),
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
    final isEdit = widget.jobPostId != null;
    final departmentsAsync = ref.watch(departmentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Job Post' : 'New Job Post'),
      ),
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
              controller: _requirementsController,
              label: 'Requirements',
              prefixIcon: Icons.checklist,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _responsibilitiesController,
              label: 'Responsibilities',
              prefixIcon: Icons.list,
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _salaryMinController,
                    label: 'Min Salary',
                    prefixIcon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    controller: _salaryMaxController,
                    label: 'Max Salary',
                    prefixIcon: Icons.attach_money,
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _locationController,
              label: 'Location',
              prefixIcon: Icons.location_on,
            ),
            const SizedBox(height: 16),
            AppTextField(
              controller: _deadlineController,
              label: 'Deadline',
              prefixIcon: Icons.calendar_today,
              keyboardType: TextInputType.datetime,
            ),
            const SizedBox(height: 16),
            departmentsAsync.when(
              data: (depts) => DropdownButtonFormField<int>(
                initialValue: _selectedDepartmentId,
                decoration: const InputDecoration(
                  labelText: 'Department',
                  border: OutlineInputBorder(),
                ),
                items: [
                  const DropdownMenuItem<int>(
                    value: null,
                    child: Text('No Department'),
                  ),
                  ...depts                  .map((d) => DropdownMenuItem(
                        value: d.id,
                        child: Text(d.departmentName),
                      )),
                ],
                onChanged: (v) => setState(() => _selectedDepartmentId = v),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Error loading departments'),
            ),
            const SizedBox(height: 16),
            AppEnumDropdown<EmploymentType>(
              label: 'Employment Type',
              values: EmploymentType.values,
              displayName: (t) => t.displayName,
              selectedValue: _selectedEmploymentType,
              onChanged: (v) => setState(() => _selectedEmploymentType = v!),
            ),
            const SizedBox(height: 16),
            AppEnumDropdown<ExperienceLevel>(
              label: 'Experience Level',
              values: ExperienceLevel.values,
              displayName: (e) => e.displayName,
              selectedValue: _selectedExperienceLevel,
              onChanged: (v) => setState(() => _selectedExperienceLevel = v!),
            ),
            const SizedBox(height: 16),
            AppEnumDropdown<JobStatus>(
              label: 'Status',
              values: JobStatus.values,
              displayName: (s) => s.displayName,
              selectedValue: _selectedStatus,
              onChanged: (v) => setState(() => _selectedStatus = v!),
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
