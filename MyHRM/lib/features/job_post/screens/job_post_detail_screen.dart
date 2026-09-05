import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/job_post/providers/job_post_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/shared/enums.dart';

class JobPostDetailScreen extends ConsumerWidget {
  const JobPostDetailScreen({super.key, required this.jobPostId});
  final int jobPostId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobAsync = ref.watch(jobPostByIdProvider(jobPostId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Post Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/job-posts/$jobPostId/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _confirmDelete(context, ref),
          ),
        ],
      ),
      body: jobAsync.when(
        data: (job) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            job.title ?? 'Untitled',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        StatusBadge(
                          label: job.status ?? 'DRAFT',
                          color: _getStatusColor(job.status),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${job.departmentName ?? 'N/A'} • ${job.location ?? 'N/A'}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (job.description != null && job.description!.isNotEmpty)
              _buildSection(context, 'Description', job.description!),
            if (job.requirements != null && job.requirements!.isNotEmpty)
              _buildSection(context, 'Requirements', job.requirements!),
            if (job.responsibilities != null &&
                job.responsibilities!.isNotEmpty)
              _buildSection(context, 'Responsibilities', job.responsibilities!),
            if (job.salaryMin != null || job.salaryMax != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.attach_money),
                  title: const Text('Salary Range'),
                  subtitle: Text(
                    '\$${job.salaryMin?.toStringAsFixed(0) ?? '0'} - '
                    '\$${job.salaryMax?.toStringAsFixed(0) ?? '0'}',
                  ),
                ),
              ),
            if (job.deadline != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Deadline'),
                  subtitle: Text(job.deadline!),
                ),
              ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String content) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(content),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => ConfirmationDialog(
        title: 'Delete Job Post',
        message: 'Are you sure you want to delete this job post?',
        confirmLabel: 'Delete',
        onConfirm: () async {
          final repo = ref.read(jobPostRepositoryProvider);
          await repo.delete(jobPostId);
          if (context.mounted) {
            Navigator.pop(context);
            context.pop();
          }
        },
      ),
    );
  }

  Color _getStatusColor(String? status) {
    final s = JobStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => JobStatus.DRAFT,
    );
    switch (s) {
      case JobStatus.OPEN:
        return Colors.green;
      case JobStatus.CLOSED:
        return Colors.red;
      case JobStatus.DRAFT:
        return Colors.orange;
    }
  }
}
