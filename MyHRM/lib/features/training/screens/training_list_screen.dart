import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/training/providers/training_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/shared/enums.dart';

class TrainingListScreen extends ConsumerWidget {
  const TrainingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trainingsAsync = ref.watch(trainingsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trainings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.go('/trainings/new'),
          ),
        ],
      ),
      body: trainingsAsync.when(
        data: (trainings) => ListView.builder(
          itemCount: trainings.length,
          itemBuilder: (context, index) {
            final training = trainings[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                title: Text(training.title ?? 'N/A'),
                subtitle: Text(
                  '${training.startDate ?? ''} - ${training.endDate ?? ''} | '
                  '${training.location ?? ''}',
                ),
                trailing: StatusBadge(
                  label: training.status ?? 'PENDING',
                  color: _getStatusColor(training.status),
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

  Color _getStatusColor(String? status) {
    final s = TrainingStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => TrainingStatus.PENDING,
    );
    switch (s) {
      case TrainingStatus.APPROVED:
        return Colors.green;
      case TrainingStatus.REJECTED:
        return Colors.red;
      case TrainingStatus.PENDING:
        return Colors.blue;
    }
  }
}
