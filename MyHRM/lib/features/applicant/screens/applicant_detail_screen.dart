import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/applicant/providers/applicant_providers.dart';

class ApplicantDetailScreen extends ConsumerWidget {
  const ApplicantDetailScreen({super.key, required this.applicantId});
  final int applicantId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final applicantAsync = ref.watch(applicantByIdProvider(applicantId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Applicant Details'),
      ),
      body: applicantAsync.when(
        data: (applicant) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      applicant.fullName ?? 'N/A',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(applicant.email ?? 'N/A'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (applicant.phone != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Phone'),
                  subtitle: Text(applicant.phone!),
                ),
              ),
            if (applicant.gender != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Gender'),
                  subtitle: Text(applicant.gender!),
                ),
              ),
            if (applicant.nationality != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.flag),
                  title: const Text('Nationality'),
                  subtitle: Text(applicant.nationality!),
                ),
              ),
            if (applicant.nidNumber != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.badge),
                  title: const Text('NID Number'),
                  subtitle: Text(applicant.nidNumber!),
                ),
              ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}
