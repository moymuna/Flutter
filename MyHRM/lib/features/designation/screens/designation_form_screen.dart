import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/designation/providers/designation_providers.dart';
import 'package:my_hrm/features/designation/data/models/designation.dart';
import 'package:my_hrm/features/department/providers/department_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/core/network/api_error_handler.dart';

class DesignationFormScreen extends ConsumerStatefulWidget {
  const DesignationFormScreen({super.key, this.designationId});

  final int? designationId;

  @override
  ConsumerState<DesignationFormScreen> createState() =>
      _DesignationFormScreenState();
}

class _DesignationFormScreenState extends ConsumerState<DesignationFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _levelCtrl = TextEditingController();

  bool _loading = false;
  String? _error;
  int? _departmentId;

  bool get isEditing => widget.designationId != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) _loadDesignation();
  }

  Future<void> _loadDesignation() async {
    final des = await ref
        .read(designationByIdProvider(widget.designationId!).future);
    _titleCtrl.text = des.title;
    _levelCtrl.text = des.level ?? '';
    _departmentId = des.departmentId;
    setState(() {});
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _levelCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final repo = ref.read(designationRepositoryProvider);
      final dto = DesignationRequest(
        title: _titleCtrl.text.trim(),
        level: _levelCtrl.text.trim().isEmpty ? null : _levelCtrl.text.trim(),
        departmentId: _departmentId,
      );

      if (isEditing) {
        await repo.update(widget.designationId!, dto);
      } else {
        await repo.create(dto);
      }

      if (!mounted) return;
      ref.invalidate(designationsProvider);
      ref.invalidate(filteredDesignationsProvider);
      context.pop();
    } catch (e) {
      setState(() => _error = apiErrorMessage(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final departmentsAsync = ref.watch(departmentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Designation' : 'New Designation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_error != null) ErrorBanner(message: _error!),
                  AppTextField(
                    label: 'Title',
                    controller: _titleCtrl,
                    prefixIcon: Icons.work_outline,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Level',
                    controller: _levelCtrl,
                    prefixIcon: Icons.layers_outlined,
                    hint: 'e.g. Senior, Junior, Mid',
                  ),
                  const SizedBox(height: 16),
                  departmentsAsync.when(
                    data: (departments) => DropdownButtonFormField<int>(
                      initialValue: _departmentId,
                      decoration: const InputDecoration(
                        labelText: 'Department',
                        prefixIcon:
                            Icon(Icons.account_tree_outlined, size: 20),
                      ),
                      items: departments.map((d) {
                        return DropdownMenuItem<int>(
                          value: d.id,
                          child: Text(d.departmentName),
                        );
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => _departmentId = val),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => Text('Error: $e'),
                  ),
                  const SizedBox(height: 32),
                  LoadingButton(
                    label:
                        isEditing ? 'Update Designation' : 'Create Designation',
                    loading: _loading,
                    icon: isEditing ? Icons.save : Icons.add,
                    onPressed: _save,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
