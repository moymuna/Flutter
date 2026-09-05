import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/leave/providers/leave_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/shared/enums.dart';

class LeaveDetailScreen extends ConsumerWidget {
  const LeaveDetailScreen({super.key, required this.leaveId});
  final int leaveId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final leaveAsync = ref.watch(leaveByIdProvider(leaveId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Leave Details'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => _handleAction(context, ref, value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'APPROVE', child: Text('Approve')),
              const PopupMenuItem(value: 'REJECT', child: Text('Reject')),
              const PopupMenuItem(value: 'CANCEL', child: Text('Cancel')),
            ],
          ),
        ],
      ),
      body: leaveAsync.when(
        data: (leave) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leave.employeeName ?? 'N/A',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    StatusBadge(
                      label: leave.status?.replaceAll('_', ' ') ?? 'PENDING',
                      color: _getStatusColor(leave.status),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _InfoTile(icon: Icons.category, title: 'Type', subtitle: leave.leaveTypeName ?? 'N/A'),
            _InfoTile(icon: Icons.calendar_today, title: 'Start Date', subtitle: leave.startDate ?? 'N/A'),
            _InfoTile(icon: Icons.calendar_today, title: 'End Date', subtitle: leave.endDate ?? 'N/A'),
            _InfoTile(icon: Icons.timelapse, title: 'Days', subtitle: '${leave.totalDays ?? 0}'),
            if (leave.reason != null && leave.reason!.isNotEmpty)
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Reason', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(leave.reason!),
                    ],
                  ),
                ),
              ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Future<void> _handleAction(BuildContext context, WidgetRef ref, String action) async {
    try {
      final repo = ref.read(leaveRepositoryProvider);
      switch (action) {
        case 'APPROVE':
          await repo.approve(leaveId);
          break;
        case 'REJECT':
          await repo.reject(leaveId);
          break;
        case 'CANCEL':
          await repo.cancel(leaveId);
          break;
      }
      ref.invalidate(leaveByIdProvider(leaveId));
      ref.invalidate(leavesProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Leave $action')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
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

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
