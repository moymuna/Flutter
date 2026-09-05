import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/document/data/document_repository.dart';
import 'package:my_hrm/features/document/data/models/document.dart';

final documentRepositoryProvider = Provider<DocumentRepository>((ref) {
  return DocumentRepository(ref.watch(apiClientProvider));
});

final documentsProvider = FutureProvider<List<DocumentResponse>>((ref) async {
  final repo = ref.watch(documentRepositoryProvider);
  return repo.getAll();
});

final documentByIdProvider =
    FutureProvider.family<DocumentResponse, int>((ref, id) async {
  final repo = ref.watch(documentRepositoryProvider);
  return repo.getById(id);
});

final documentsByEmployeeProvider =
    FutureProvider.family<List<DocumentResponse>, int>((ref, employeeId) async {
  final repo = ref.watch(documentRepositoryProvider);
  return repo.getByEmployee(employeeId);
});
