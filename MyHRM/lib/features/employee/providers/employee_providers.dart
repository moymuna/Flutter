import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/employee/data/employee_repository.dart';
import 'package:my_hrm/features/employee/data/models/employee.dart';

final employeeRepositoryProvider = Provider<EmployeeRepository>((ref) {
  return EmployeeRepository(ref.watch(apiClientProvider));
});

final employeesProvider = FutureProvider<List<EmployeeResponse>>((ref) async {
  final repo = ref.watch(employeeRepositoryProvider);
  return repo.getAll();
});

final employeeSearchProvider = StateProvider<String>((ref) => '');

final filteredEmployeesProvider =
    FutureProvider<List<EmployeeResponse>>((ref) async {
  final keyword = ref.watch(employeeSearchProvider);
  final repo = ref.watch(employeeRepositoryProvider);
  if (keyword.isEmpty) return repo.getAll();
  return repo.search(keyword);
});

final employeeByIdProvider =
    FutureProvider.family<EmployeeResponse, int>((ref, id) async {
  final repo = ref.watch(employeeRepositoryProvider);
  return repo.getById(id);
});

final employeeByUserIdProvider =
    FutureProvider.family<EmployeeResponse, int>((ref, userId) async {
  final repo = ref.watch(employeeRepositoryProvider);
  return repo.getByUserId(userId);
});

final employeesByDepartmentProvider =
    FutureProvider.family<List<EmployeeResponse>, int>(
        (ref, departmentId) async {
  final repo = ref.watch(employeeRepositoryProvider);
  return repo.getByDepartment(departmentId);
});

final employeeCountProvider = FutureProvider<int>((ref) async {
  final repo = ref.watch(employeeRepositoryProvider);
  return repo.count();
});

final employeeActiveCountProvider = FutureProvider<int>((ref) async {
  final repo = ref.watch(employeeRepositoryProvider);
  return repo.countActive();
});
