import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/salary/providers/salary_providers.dart';

class SalaryListScreen extends ConsumerWidget {
  const SalaryListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final salariesAsync = ref.watch(salariesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Salaries')),
      body: salariesAsync.when(
        data: (salaries) => ListView.builder(
          itemCount: salaries.length,
          itemBuilder: (context, index) {
            final salary = salaries[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                title: Text(salary.employeeName ?? 'N/A'),
                subtitle: Text(
                  'Basic: \$${salary.basicSalary?.toStringAsFixed(0) ?? '0'} | '
                  'Total: \$${salary.totalSalary?.toStringAsFixed(0) ?? '0'}',
                ),
                trailing: Text(salary.salaryGradeName ?? ''),
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
