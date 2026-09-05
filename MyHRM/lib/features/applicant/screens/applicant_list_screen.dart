import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:my_hrm/features/applicant/providers/applicant_providers.dart';
import 'package:my_hrm/core/widgets/app_text_field.dart';

class ApplicantListScreen extends ConsumerWidget {
  const ApplicantListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicantsAsync = ref.watch(filteredApplicantsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Applicants'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppSearchField(
              hint: 'Search applicants...',
              onChanged: (value) =>
                  ref.read(applicantSearchProvider.notifier).state = value,
            ),
          ),
          Expanded(
            child: applicantsAsync.when(
              data: (applicants) => ListView.builder(
                itemCount: applicants.length,
                itemBuilder: (context, index) {
                  final applicant = applicants[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          (applicant.fullName ?? 'A')[0].toUpperCase(),
                        ),
                      ),
                      title: Text(applicant.fullName ?? 'N/A'),
                      subtitle: Text(applicant.email ?? 'N/A'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () =>
                          context.push('/applicants/${applicant.id}'),
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
}
