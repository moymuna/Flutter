import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/leave_type/providers/leave_type_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';

class LeaveTypeListScreen extends ConsumerWidget {
  const LeaveTypeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaveTypesAsync = ref.watch(leaveTypesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Types'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/leave-types/new'),
          ),
        ],
      ),
      body: leaveTypesAsync.when(
        data: (leaveTypes) => ListView.builder(
          itemCount: leaveTypes.length,
          itemBuilder: (context, index) {
            final lt = leaveTypes[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                title: Text(lt.name),
                subtitle: Text('${lt.daysPerYear ?? 0} days/year'),
                trailing: StatusBadge(
                  label: lt.isActive == true ? 'ACTIVE' : 'INACTIVE',
                  color: lt.isActive == true ? Colors.green : Colors.red,
                ),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
