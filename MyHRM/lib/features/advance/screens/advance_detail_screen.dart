import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/advance/providers/advance_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/shared/enums.dart';

class AdvanceDetailScreen extends ConsumerWidget {
  const AdvanceDetailScreen({super.key, required this.advanceId});
  final int advanceId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final advanceAsync = ref.watch(advanceByIdProvider(advanceId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Advance Details'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => _handleAction(context, ref, value),
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'APPROVE', child: Text('Approve')),
              const PopupMenuItem(value: 'REJECT', child: Text('Reject')),
              const PopupMenuItem(value: 'PAY', child: Text('Mark Paid')),
            ],
          ),
        ],
      ),
      body: advanceAsync.when(
        data: (advance) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      advance.employeeName ?? 'N/A',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    StatusBadge(
                      label: advance.status?.replaceAll('_', ' ') ?? 'PENDING',
                      color: _getStatusColor(advance.status),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            _InfoTile(
              icon: Icons.attach_money,
              title: 'Amount',
              subtitle: '\$${advance.amount?.toStringAsFixed(0) ?? '0'}',
            ),
            _InfoTile(
              icon: Icons.attach_money,
              title: 'Recovered',
              subtitle: '\$${advance.recoveredAmount?.toStringAsFixed(0) ?? '0'}',
            ),
            _InfoTile(
              icon: Icons.attach_money,
              title: 'Remaining',
              subtitle: '\$${advance.remainingAmount?.toStringAsFixed(0) ?? '0'}',
            ),
            if (advance.reason != null && advance.reason!.isNotEmpty)
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Reason', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(advance.reason!),
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
      final repo = ref.read(advanceRepositoryProvider);
      switch (action) {
        case 'APPROVE':
          await repo.approve(advanceId);
          break;
        case 'REJECT':
          await repo.reject(advanceId);
          break;
        case 'PAY':
          await repo.pay(advanceId);
          break;
      }
      ref.invalidate(advanceByIdProvider(advanceId));
      ref.invalidate(advancesProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Advance $action')),
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
