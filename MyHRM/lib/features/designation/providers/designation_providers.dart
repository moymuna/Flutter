import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/designation/data/designation_repository.dart';
import 'package:my_hrm/features/designation/data/models/designation.dart';

final designationRepositoryProvider = Provider<DesignationRepository>((ref) {
  return DesignationRepository(ref.watch(apiClientProvider));
});

final designationsProvider =
    FutureProvider<List<DesignationResponse>>((ref) async {
  final repo = ref.watch(designationRepositoryProvider);
  return repo.getAll();
});

final designationsByDepartmentProvider =
    FutureProvider.family<List<DesignationResponse>, int>(
        (ref, departmentId) async {
  final repo = ref.watch(designationRepositoryProvider);
  return repo.getByDepartment(departmentId);
});

final designationSearchProvider = StateProvider<String>((ref) => '');

final filteredDesignationsProvider =
    FutureProvider<List<DesignationResponse>>((ref) async {
  final keyword = ref.watch(designationSearchProvider);
  final repo = ref.watch(designationRepositoryProvider);
  if (keyword.isEmpty) return repo.getAll();
  return repo.search(keyword);
});

final designationByIdProvider =
    FutureProvider.family<DesignationResponse, int>((ref, id) async {
  final repo = ref.watch(designationRepositoryProvider);
  return repo.getById(id);
});
