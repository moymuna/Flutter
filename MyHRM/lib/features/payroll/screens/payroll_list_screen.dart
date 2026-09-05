import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/payroll/providers/payroll_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/shared/enums.dart';

class PayrollListScreen extends ConsumerWidget {
  const PayrollListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payrollsAsync = ref.watch(filteredPayrollsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Payrolls')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppSearchField(
              hint: 'Search payrolls...',
              onChanged: (value) =>
                  ref.read(payrollSearchProvider.notifier).state = value,
            ),
          ),
          Expanded(
            child: payrollsAsync.when(
              data: (payrolls) => ListView.builder(
                itemCount: payrolls.length,
                itemBuilder: (context, index) {
                  final payroll = payrolls[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ListTile(
                      title: Text(payroll.employeeName ?? 'N/A'),
                      subtitle: Text(
                        '${payroll.year ?? 0}-${payroll.month ?? 0} | '
                        'Net: \$${payroll.netPay?.toStringAsFixed(0) ?? '0'}',
                      ),
                      trailing: StatusBadge(
                        label: payroll.status ?? 'DRAFT',
                        color: _getStatusColor(payroll.status),
                      ),
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
    final s = PayrollStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => PayrollStatus.DRAFT,
    );
    switch (s) {
      case PayrollStatus.PAID:
        return Colors.green;
      case PayrollStatus.PROCESSED:
        return Colors.blue;
      case PayrollStatus.FAILED:
        return Colors.red;
      case PayrollStatus.DRAFT:
        return Colors.orange;
    }
  }
}
