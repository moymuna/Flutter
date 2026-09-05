import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/features/audit_log/providers/audit_log_providers.dart';

class AuditLogListScreen extends ConsumerWidget {
  const AuditLogListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logsAsync = ref.watch(latestAuditLogsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Audit Log')),
      body: logsAsync.when(
        data: (logs) => ListView.builder(
          itemCount: logs.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: ListTile(
                leading: const Icon(Icons.history),
                title: Text(log.action ?? 'N/A'),
                subtitle: Text(
                  '${log.entityType ?? ''} #${log.entityId ?? ''} | '
                  'By: ${log.performedBy ?? 'N/A'}',
                ),
                trailing: Text(
                  log.timestamp ?? '',
                  style: const TextStyle(fontSize: 12),
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
}
