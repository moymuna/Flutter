import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/salary_grade/providers/salary_grade_providers.dart';

class SalaryGradeListScreen extends ConsumerWidget {
  const SalaryGradeListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gradesAsync = ref.watch(salaryGradesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Salary Grades'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/salary-grades/new'),
          ),
        ],
      ),
      body: gradesAsync.when(
        data: (grades) => ListView.builder(
          itemCount: grades.length,
          itemBuilder: (context, index) {
            final grade = grades[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                title: Text(grade.gradeName ?? 'N/A'),
                subtitle: Text(
                  'Range: \$${grade.minSalary?.toStringAsFixed(0) ?? '0'} - '
                  '\$${grade.maxSalary?.toStringAsFixed(0) ?? '0'}',
                ),
                trailing: Icon(
                  grade.isActive == true ? Icons.check_circle : Icons.cancel,
                  color: grade.isActive == true ? Colors.green : Colors.red,
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
