import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/leave/providers/leave_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/shared/enums.dart';

class LeaveListScreen extends ConsumerWidget {
  const LeaveListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leavesAsync = ref.watch(filteredLeavesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaves'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/leaves/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppSearchField(
              hint: 'Search leaves...',
              onChanged: (value) =>
                  ref.read(leaveSearchProvider.notifier).state = value,
            ),
          ),
          Expanded(
            child: leavesAsync.when(
              data: (leaves) => ListView.builder(
                itemCount: leaves.length,
                itemBuilder: (context, index) {
                  final leave = leaves[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ListTile(
                      title: Text(leave.employeeName ?? 'N/A'),
                      subtitle: Text(
                        '${leave.leaveTypeName ?? 'N/A'} | ${leave.startDate ?? ''} - ${leave.endDate ?? ''}',
                      ),
                      trailing: StatusBadge(
                        label: leave.status?.replaceAll('_', ' ') ?? 'PENDING',
                        color: _getStatusColor(leave.status),
                      ),
                      onTap: () => context.go('/leaves/${leave.id}'),
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
    final s = LeaveStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => LeaveStatus.PENDING,
    );
    switch (s) {
      case LeaveStatus.APPROVED:
        return Colors.green;
      case LeaveStatus.REJECTED:
        return Colors.red;
      case LeaveStatus.CANCELLED:
        return Colors.orange;
      case LeaveStatus.PENDING:
        return Colors.blue;
    }
  }
}
