import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/audit_log/data/audit_log_repository.dart';
import 'package:my_hrm/features/audit_log/data/models/audit_log.dart';

final auditLogRepositoryProvider = Provider<AuditLogRepository>((ref) {
  return AuditLogRepository(ref.watch(apiClientProvider));
});

final latestAuditLogsProvider =
    FutureProvider<List<AuditLogResponse>>((ref) async {
  final repo = ref.watch(auditLogRepositoryProvider);
  return repo.getLatest();
});

final auditLogByIdProvider =
    FutureProvider.family<List<AuditLogResponse>, Map<String, int>>(
        (ref, params) async {
  final repo = ref.watch(auditLogRepositoryProvider);
  return repo.getByEntity(
      params['type'] == 0 ? '' : 'entity', params['id']!);
});
