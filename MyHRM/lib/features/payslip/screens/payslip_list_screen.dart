import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/payslip/providers/payslip_providers.dart';

class PayslipListScreen extends ConsumerWidget {
  const PayslipListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final payslipsAsync = ref.watch(payslipsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Payslips')),
      body: payslipsAsync.when(
        data: (payslips) => ListView.builder(
          itemCount: payslips.length,
          itemBuilder: (context, index) {
            final payslip = payslips[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                title: Text(payslip.employeeName ?? 'N/A'),
                subtitle: Text(
                  '${payslip.year ?? 0}-${payslip.month ?? 0} | '
                  'Net: \$${payslip.netPay?.toStringAsFixed(0) ?? '0'}',
                ),
                trailing: const Icon(Icons.receipt),
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
