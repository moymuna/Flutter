import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/department/data/department_repository.dart';
import 'package:my_hrm/features/department/data/models/department.dart';

final departmentRepositoryProvider = Provider<DepartmentRepository>((ref) {
  return DepartmentRepository(ref.watch(apiClientProvider));
});

final departmentsProvider = FutureProvider<List<DepartmentResponse>>((ref) async {
  final repo = ref.watch(departmentRepositoryProvider);
  return repo.getAll();
});

final departmentSearchProvider = StateProvider<String>((ref) => '');

final filteredDepartmentsProvider =
    FutureProvider<List<DepartmentResponse>>((ref) async {
  final keyword = ref.watch(departmentSearchProvider);
  final repo = ref.watch(departmentRepositoryProvider);
  if (keyword.isEmpty) return repo.getAll();
  return repo.search(keyword);
});

final departmentByIdProvider =
    FutureProvider.family<DepartmentResponse, int>((ref, id) async {
  final repo = ref.watch(departmentRepositoryProvider);
  return repo.getById(id);
});
