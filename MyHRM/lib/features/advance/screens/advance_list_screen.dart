import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/advance/providers/advance_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/shared/enums.dart';

class AdvanceListScreen extends ConsumerWidget {
  const AdvanceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advancesAsync = ref.watch(filteredAdvancesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Advances'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/advances/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppSearchField(
              hint: 'Search advances...',
              onChanged: (value) =>
                  ref.read(advanceSearchProvider.notifier).state = value,
            ),
          ),
          Expanded(
            child: advancesAsync.when(
              data: (advances) => ListView.builder(
                itemCount: advances.length,
                itemBuilder: (context, index) {
                  final advance = advances[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ListTile(
                      title: Text(advance.employeeName ?? 'N/A'),
                      subtitle: Text(
                        'Amount: \$${advance.amount?.toStringAsFixed(0) ?? '0'} | '
                        'Remaining: \$${advance.remainingAmount?.toStringAsFixed(0) ?? '0'}',
                      ),
                      trailing: StatusBadge(
                        label: advance.status?.replaceAll('_', ' ') ?? 'PENDING',
                        color: _getStatusColor(advance.status),
                      ),
                      onTap: () => context.go('/advances/${advance.id}'),
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String? status) {
    final s = AdvanceStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => AdvanceStatus.PENDING,
    );
    switch (s) {
      case AdvanceStatus.APPROVED:
        return Colors.green;
      case AdvanceStatus.PAID:
        return Colors.blue;
      case AdvanceStatus.SETTLED:
        return Colors.purple;
      case AdvanceStatus.REJECTED:
        return Colors.red;
      case AdvanceStatus.PENDING:
        return Colors.orange;
    }
  }
}
