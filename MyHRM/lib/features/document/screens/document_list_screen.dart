import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/document/providers/document_providers.dart';

class DocumentListScreen extends ConsumerWidget {
  const DocumentListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documentsAsync = ref.watch(documentsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Documents')),
      body: documentsAsync.when(
        data: (documents) => ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            final doc = documents[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                leading: const Icon(Icons.description),
                title: Text(doc.title ?? 'N/A'),
                subtitle: Text(
                  '${doc.documentType ?? ''} | ${doc.employeeName ?? ''}',
                ),
                trailing: const Icon(Icons.chevron_right),
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
