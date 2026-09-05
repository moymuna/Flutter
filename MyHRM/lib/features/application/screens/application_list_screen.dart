import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/application/providers/application_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';
import 'package:my_hrm/shared/enums.dart';

class ApplicationListScreen extends ConsumerWidget {
  const ApplicationListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicationsAsync = ref.watch(filteredApplicationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Applications'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppSearchField(
              hint: 'Search applications...',
              onChanged: (value) =>
                  ref.read(applicationSearchProvider.notifier).state = value,
            ),
          ),
          Expanded(
            child: applicationsAsync.when(
              data: (applications) => ListView.builder(
                itemCount: applications.length,
                itemBuilder: (context, index) {
                  final app = applications[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ListTile(
                      title: Text(app.applicantName ?? 'N/A'),
                      subtitle: Text(app.jobPostTitle ?? 'N/A'),
                      trailing: StatusBadge(
                        label: app.status?.replaceAll('_', ' ') ?? 'APPLIED',
                        color: _getStatusColor(app.status),
                      ),
                      onTap: () => context.push('/applications/${app.id}'),
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
    final s = ApplicationStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => ApplicationStatus.APPLIED,
    );
    switch (s) {
      case ApplicationStatus.APPLIED:
        return Colors.blue;
      case ApplicationStatus.SHORTLISTED:
        return Colors.green;
      case ApplicationStatus.INTERVIEW_SCHEDULED:
        return Colors.orange;
      case ApplicationStatus.INTERVIEWED:
        return Colors.teal;
      case ApplicationStatus.SELECTED:
        return Colors.green;
      case ApplicationStatus.REJECTED:
        return Colors.red;
      case ApplicationStatus.HIRED:
        return Colors.purple;
      case ApplicationStatus.UNDER_REVIEW:
        return Colors.indigo;
      case ApplicationStatus.ON_HOLD:
        return Colors.amber;
      case ApplicationStatus.WITHDRAWN:
        return Colors.grey;
    }
  }
}
