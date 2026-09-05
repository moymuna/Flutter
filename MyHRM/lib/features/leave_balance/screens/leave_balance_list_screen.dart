import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/leave_balance/providers/leave_balance_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';

class LeaveBalanceListScreen extends ConsumerWidget {
  const LeaveBalanceListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balancesAsync = ref.watch(leaveBalancesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Leave Balances')),
      body: balancesAsync.when(
        data: (balances) => ListView.builder(
          itemCount: balances.length,
          itemBuilder: (context, index) {
            final balance = balances[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                title: Text(
                  '${balance.employeeName ?? 'N/A'} - ${balance.leaveTypeName ?? 'N/A'}',
                ),
                subtitle: Text(
                  'Used: ${balance.usedDays ?? 0} / ${balance.totalDays ?? 0} | Remaining: ${balance.remainingDays ?? 0}',
                ),
                trailing: StatusBadge(
                  label: '${balance.year ?? ''}',
                  color: Colors.blue,
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
