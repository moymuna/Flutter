import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/job_post/providers/job_post_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/shared/enums.dart';

class JobPostListScreen extends ConsumerWidget {
  const JobPostListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobPostsAsync = ref.watch(filteredJobPostsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/job-posts/new'),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppSearchField(
              hint: 'Search job posts...',
              onChanged: (value) =>
                  ref.read(jobPostSearchProvider.notifier).state = value,
            ),
          ),
          Expanded(
            child: jobPostsAsync.when(
              data: (jobPosts) => ListView.builder(
                itemCount: jobPosts.length,
                itemBuilder: (context, index) {
                  final job = jobPosts[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ListTile(
                      title: Text(job.title ?? 'Untitled'),
                      subtitle: Text(
                        '${job.departmentName ?? 'N/A'} • ${job.location ?? 'N/A'}',
                      ),
                      trailing: StatusBadge(
                        label: job.status ?? 'DRAFT',
                        color: _getStatusColor(job.status),
                      ),
                      onTap: () => context.push('/job-posts/${job.id}'),
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
