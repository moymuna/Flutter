import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/application/providers/application_providers.dart';
import 'package:my_hrm/core/widgets/common_widgets.dart';
import 'package:my_hrm/shared/enums.dart';

class ApplicationDetailScreen extends ConsumerWidget {
  const ApplicationDetailScreen({super.key, required this.applicationId});
  final int applicationId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appAsync = ref.watch(applicationByIdProvider(applicationId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Application Details'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) => _updateStatus(context, ref, value),
            itemBuilder: (context) => ApplicationStatus.values
                .map((s) => PopupMenuItem(
                      value: s.name,
                      child: Text(s.displayName),
                    ))
                .toList(),
          ),
        ],
      ),
      body: appAsync.when(
        data: (app) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      app.applicantName ?? 'N/A',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text('Applied for: ${app.jobPostTitle ?? 'N/A'}'),
                    const SizedBox(height: 8),
                    StatusBadge(
                      label: app.status?.replaceAll('_', ' ') ?? 'APPLIED',
                      color: _getStatusColor(app.status),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (app.coverLetter != null && app.coverLetter!.isNotEmpty)
              Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Cover Letter',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(app.coverLetter!),
                    ],
                  ),
                ),
              ),
            if (app.expectedSalary != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.attach_money),
                  title: const Text('Expected Salary'),
                  subtitle: Text('\$${app.expectedSalary!.toStringAsFixed(0)}'),
                ),
              ),
            if (app.appliedAt != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: const Text('Applied At'),
                  subtitle: Text(app.appliedAt!),
                ),
              ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Future<void> _updateStatus(
      BuildContext context, WidgetRef ref, String status) async {
    try {
      final repo = ref.read(applicationRepositoryProvider);
      await repo.updateStatus(applicationId, status);
      ref.invalidate(applicationByIdProvider(applicationId));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Status updated')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
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
