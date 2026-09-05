import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/department/providers/department_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/core/theme/app_theme.dart';

class DepartmentListScreen extends ConsumerStatefulWidget {
  const DepartmentListScreen({super.key});

  @override
  ConsumerState<DepartmentListScreen> createState() =>
      _DepartmentListScreenState();
}

class _DepartmentListScreenState extends ConsumerState<DepartmentListScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final departmentsAsync = ref.watch(filteredDepartmentsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Departments'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/departments/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppSearchField(
              controller: _searchCtrl,
              hint: 'Search departments...',
              onChanged: (val) =>
                  ref.read(departmentSearchProvider.notifier).state = val,
            ),
          ),
          Expanded(
            child: departmentsAsync.when(
              data: (departments) {
                if (departments.isEmpty) {
                  return const EmptyState(
                    icon: Icons.account_tree_outlined,
                    title: 'No departments found',
                    subtitle: 'Tap + to add a new department',
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: departments.length,
                  itemBuilder: (context, index) {
                    final dept = departments[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              AppColors.success.withValues(alpha: 0.1),
                          child: const Icon(Icons.account_tree,
                              color: AppColors.success),
                        ),
                        title: Text(dept.departmentName),
                        subtitle: Text(
                          '${dept.code}${dept.officeName != null ? ' · ${dept.officeName}' : ''}',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () =>
                            context.push('/departments/${dept.id}'),
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
