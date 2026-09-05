import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/interview/providers/interview_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/shared/enums.dart';

class InterviewDetailScreen extends ConsumerWidget {
  const InterviewDetailScreen({super.key, required this.interviewId});
  final int interviewId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final interviewAsync = ref.watch(interviewByIdProvider(interviewId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interview Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/interviews/$interviewId/edit'),
          ),
        ],
      ),
      body: interviewAsync.when(
        data: (interview) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      interview.applicantName ?? 'N/A',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(interview.jobPostTitle ?? 'N/A'),
                    const SizedBox(height: 8),
                    StatusBadge(
                      label: interview.status?.replaceAll('_', ' ') ?? 'SCHEDULED',
                      color: _getStatusColor(interview.status),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (interview.interviewDate != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Date'),
                  subtitle: Text(interview.interviewDate!),
                ),
              ),
            if (interview.interviewTime != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.access_time),
                  title: const Text('Time'),
                  subtitle: Text(interview.interviewTime!),
                ),
              ),
            if (interview.interviewType != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.videocam),
                  title: const Text('Type'),
                  subtitle: Text(interview.interviewType!),
                ),
              ),
            if (interview.location != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Location'),
                  subtitle: Text(interview.location!),
                ),
              ),
            if (interview.notes != null && interview.notes!.isNotEmpty)
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notes',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(interview.notes!),
                    ],
                  ),
                ),
              ),
            if (interview.result != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.assessment),
                  title: const Text('Result'),
                  subtitle: Text(interview.result!),
                ),
              ),
          ],
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
