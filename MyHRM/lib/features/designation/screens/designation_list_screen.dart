import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/designation/providers/designation_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/core/theme/app_theme.dart';

class DesignationListScreen extends ConsumerStatefulWidget {
  const DesignationListScreen({super.key});

  @override
  ConsumerState<DesignationListScreen> createState() =>
      _DesignationListScreenState();
}

class _DesignationListScreenState extends ConsumerState<DesignationListScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final designationsAsync = ref.watch(filteredDesignationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Designations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/designations/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppSearchField(
              controller: _searchCtrl,
              hint: 'Search designations...',
              onChanged: (val) =>
                  ref.read(designationSearchProvider.notifier).state = val,
            ),
          ),
          Expanded(
            child: designationsAsync.when(
              data: (designations) {
                if (designations.isEmpty) {
                  return const EmptyState(
                    icon: Icons.work_outline,
                    title: 'No designations found',
                    subtitle: 'Tap + to add a new designation',
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: designations.length,
                  itemBuilder: (context, index) {
                    final des = designations[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              AppColors.warning.withValues(alpha: 0.1),
                          child: const Icon(Icons.work,
                              color: AppColors.warning),
                        ),
                        title: Text(des.title),
                        subtitle: Text(
                          '${des.level ?? 'N/A'}${des.departmentName != null ? ' · ${des.departmentName}' : ''}',
                        ),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () =>
                            context.push('/designations/${des.id}'),
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
