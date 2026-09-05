import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/department/providers/department_providers.dart';
import 'package:my_hrm/features/department/data/models/department.dart';
import 'package:my_hrm/features/office/providers/office_providers.dart';
import 'package:my_hrm/features/employee/providers/employee_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/core/network/api_error_handler.dart';

class DepartmentFormScreen extends ConsumerStatefulWidget {
  const DepartmentFormScreen({super.key, this.departmentId});

  final int? departmentId;

  @override
  ConsumerState<DepartmentFormScreen> createState() =>
      _DepartmentFormScreenState();
}

class _DepartmentFormScreenState extends ConsumerState<DepartmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();

  bool _loading = false;
  String? _error;
  int? _officeId;
  int? _departmentHeadId;

  bool get isEditing => widget.departmentId != null;

  @override
  void initState() {
    super.initState();
    if (isEditing) _loadDepartment();
  }

  Future<void> _loadDepartment() async {
    final dept =
        await ref.read(departmentByIdProvider(widget.departmentId!).future);
    _nameCtrl.text = dept.departmentName;
    _codeCtrl.text = dept.code;
    _officeId = dept.officeId;
    _departmentHeadId = dept.departmentHeadId;
    setState(() {});
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _codeCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final repo = ref.read(departmentRepositoryProvider);
      final dto = DepartmentRequest(
        departmentName: _nameCtrl.text.trim(),
        code: _codeCtrl.text.trim(),
        officeId: _officeId,
        departmentHeadId: _departmentHeadId,
      );

      if (isEditing) {
        await repo.update(widget.departmentId!, dto);
      } else {
        await repo.create(dto);
      }

      if (!mounted) return;
      ref.invalidate(departmentsProvider);
      ref.invalidate(filteredDepartmentsProvider);
      context.pop();
    } catch (e) {
      setState(() => _error = apiErrorMessage(e));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final officesAsync = ref.watch(officesProvider);
    final employeesAsync = ref.watch(employeesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Department' : 'New Department'),
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
                    label: 'Department Name',
                    controller: _nameCtrl,
                    prefixIcon: Icons.account_tree_outlined,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: 'Department Code',
                    controller: _codeCtrl,
                    prefixIcon: Icons.code_outlined,
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  officesAsync.when(
                    data: (offices) => DropdownButtonFormField<int>(
                      initialValue: _officeId,
                      decoration: const InputDecoration(
                        labelText: 'Office',
                        prefixIcon: Icon(Icons.business_outlined, size: 20),
                      ),
                      items: offices.map((o) {
                        return DropdownMenuItem<int>(
                          value: o.id,
                          child: Text(o.officeName),
                        );
                      }).toList(),
                      onChanged: (val) => setState(() => _officeId = val),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => Text('Error: $e'),
                  ),
                  const SizedBox(height: 16),
                  employeesAsync.when(
                    data: (employees) => DropdownButtonFormField<int>(
                      initialValue: _departmentHeadId,
                      decoration: const InputDecoration(
                        labelText: 'Department Head',
                        prefixIcon: Icon(Icons.person_outlined, size: 20),
                      ),
                      items: employees.map((e) {
                        return DropdownMenuItem<int>(
                          value: e.id,
                          child: Text(e.fullName ?? 'Employee #${e.id}'),
                        );
                      }).toList(),
                      onChanged: (val) =>
                          setState(() => _departmentHeadId = val),
                    ),
                    loading: () => const LinearProgressIndicator(),
                    error: (e, _) => Text('Error: $e'),
                  ),
                  const SizedBox(height: 32),
                  LoadingButton(
                    label: isEditing ? 'Update Department' : 'Create Department',
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
