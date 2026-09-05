import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/employee/providers/employee_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/core/theme/app_theme.dart';
import 'package:my_hrm/shared/enums.dart';

class EmployeeListScreen extends ConsumerStatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  ConsumerState<EmployeeListScreen> createState() =>
      _EmployeeListScreenState();
}

class _EmployeeListScreenState extends ConsumerState<EmployeeListScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Color _statusColor(String? status) {
    final s = EmployeeStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => EmployeeStatus.ACTIVE,
    );
    switch (s) {
      case EmployeeStatus.ACTIVE:
        return AppColors.success;
      case EmployeeStatus.ON_LEAVE:
        return AppColors.warning;
      case EmployeeStatus.SUSPENDED:
        return AppColors.danger;
      case EmployeeStatus.RESIGNED:
      case EmployeeStatus.TERMINATED:
        return AppColors.secondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final employeesAsync = ref.watch(filteredEmployeesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employees'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/employees/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppSearchField(
              controller: _searchCtrl,
              hint: 'Search employees...',
              onChanged: (val) =>
                  ref.read(employeeSearchProvider.notifier).state = val,
            ),
          ),
          Expanded(
            child: employeesAsync.when(
              data: (employees) {
                if (employees.isEmpty) {
                  return const EmptyState(
                    icon: Icons.people_outline,
                    title: 'No employees found',
                    subtitle: 'Tap + to add a new employee',
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: employees.length,
                  itemBuilder: (context, index) {
                    final emp = employees[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              AppColors.primary.withValues(alpha: 0.1),
                          child: Text(
                            (emp.fullName ?? 'E')[0].toUpperCase(),
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(emp.fullName ?? 'Employee #${emp.id}'),
                        subtitle: Text(
                          '${emp.employeeCode ?? ''} · ${emp.designationTitle ?? emp.departmentName ?? ''}',
                        ),
                        trailing: StatusBadge(
                          label: emp.status?.replaceAll('_', ' ') ?? 'N/A',
                          color: _statusColor(emp.status),
                        ),
                        onTap: () =>
                            context.push('/employees/${emp.id}'),
                      ),
                    );
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }
}
