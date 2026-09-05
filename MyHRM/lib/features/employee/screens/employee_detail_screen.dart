import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/employee/providers/employee_providers.dart';
import 'package:my_hrm/core/theme/app_theme.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/shared/enums.dart';

class EmployeeDetailScreen extends ConsumerWidget {
  const EmployeeDetailScreen({super.key, required this.employeeId});

  final int employeeId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeeAsync = ref.watch(employeeByIdProvider(employeeId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Detail'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () =>
                context.push('/employees/$employeeId/edit'),
          ),
        ],
      ),
      body: employeeAsync.when(
        data: (emp) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor:
                                AppColors.primary.withValues(alpha: 0.1),
                            child: Text(
                              (emp.fullName ?? 'E')[0].toUpperCase(),
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  emp.fullName ?? 'N/A',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  emp.employeeCode ?? '',
                                  style: const TextStyle(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 4),
                          StatusBadge(
                            label: emp.status?.replaceAll('_', ' ') ?? 'N/A',
                            color: _statusColor(emp.status),
                          ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Info cards
                  _InfoCard(
                    title: 'Personal Information',
                    icon: Icons.person_outline,
                    children: [
                      _InfoRow(label: 'Email', value: emp.email),
                      _InfoRow(label: 'Gender', value: emp.gender),
                      _InfoRow(label: 'Date of Birth', value: emp.dateOfBirth),
                      _InfoRow(label: 'Blood Group', value: emp.bloodGroup),
                      _InfoRow(label: 'Role', value: emp.role),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _InfoCard(
                    title: 'Employment',
                    icon: Icons.work_outline,
                    children: [
                      _InfoRow(
                          label: 'Department', value: emp.departmentName),
                      _InfoRow(
                          label: 'Designation', value: emp.designationTitle),
                      _InfoRow(label: 'Office', value: emp.officeName),
                      _InfoRow(
                          label: 'Employment Type',
                          value: emp.employmentType),
                      _InfoRow(
                          label: 'Joining Date', value: emp.joiningDate),
                      _InfoRow(
                          label: 'Contract No', value: emp.contractNo),
                      _InfoRow(
                          label: 'Manager', value: emp.managerName),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (emp.presentAddress != null)
                    _InfoCard(
                      title: 'Present Address',
                      icon: Icons.home_outlined,
                      children: [
                        _InfoRow(
                            label: 'Address',
                            value: emp.presentAddress!.fullAddress),
                      ],
                    ),
                  if (emp.permanentAddress != null) ...[
                    const SizedBox(height: 12),
                    _InfoCard(
                      title: 'Permanent Address',
                      icon: Icons.home_outlined,
                      children: [
                        _InfoRow(
                            label: 'Address',
                            value: emp.permanentAddress!.fullAddress),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
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
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.title,
    required this.icon,
    required this.children,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: AppColors.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Divider(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, this.value});

  final String label;
  final String? value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(value ?? 'N/A'),
          ),
        ],
      ),
    );
  }
}
