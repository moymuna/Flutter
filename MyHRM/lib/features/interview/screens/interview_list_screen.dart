import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/interview/providers/interview_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/shared/enums.dart';

class InterviewListScreen extends ConsumerWidget {
  const InterviewListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interviewsAsync = ref.watch(interviewsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interviews'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/interviews/new'),
          ),
        ],
      ),
      body: interviewsAsync.when(
        data: (interviews) => ListView.builder(
          itemCount: interviews.length,
          itemBuilder: (context, index) {
            final interview = interviews[index];
            return Card(
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              child: ListTile(
                title: Text(interview.applicantName ?? 'N/A'),
                subtitle: Text(interview.jobPostTitle ?? 'N/A'),
                trailing: StatusBadge(
                  label: interview.status?.replaceAll('_', ' ') ?? 'SCHEDULED',
                  color: _getStatusColor(interview.status),
                ),
                onTap: () => context.push('/interviews/${interview.id}'),
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
    final s = InterviewStage.values.firstWhere(
      (e) => e.name == status,
      orElse: () => InterviewStage.SCHEDULED,
    );
    switch (s) {
      case InterviewStage.SCHEDULED:
        return Colors.blue;
      case InterviewStage.COMPLETED:
        return Colors.green;
      case InterviewStage.CANCELLED:
        return Colors.red;
    }
  }
}
