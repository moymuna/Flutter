import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/office/providers/office_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/core/theme/app_theme.dart';

class OfficeListScreen extends ConsumerStatefulWidget {
  const OfficeListScreen({super.key});

  @override
  ConsumerState<OfficeListScreen> createState() => _OfficeListScreenState();
}

class _OfficeListScreenState extends ConsumerState<OfficeListScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final officesAsync = ref.watch(filteredOfficesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Offices'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/offices/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppSearchField(
              controller: _searchCtrl,
              hint: 'Search offices...',
              onChanged: (val) =>
                  ref.read(officeSearchProvider.notifier).state = val,
            ),
          ),
          Expanded(
            child: officesAsync.when(
              data: (offices) {
                if (offices.isEmpty) {
                  return const EmptyState(
                    icon: Icons.business_outlined,
                    title: 'No offices found',
                    subtitle: 'Tap + to add a new office',
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: offices.length,
                  itemBuilder: (context, index) {
                    final office = offices[index];
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor:
                              AppColors.primary.withValues(alpha: 0.1),
                          child: const Icon(Icons.business,
                              color: AppColors.primary),
                        ),
                        title: Text(office.officeName),
                        subtitle: Text(office.officeCode),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: () =>
                            context.push('/offices/${office.id}'),
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
