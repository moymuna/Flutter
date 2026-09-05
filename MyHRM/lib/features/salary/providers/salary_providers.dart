import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/salary/data/salary_repository.dart';
import 'package:my_hrm/features/salary/data/models/salary.dart';

final salaryRepositoryProvider = Provider<SalaryRepository>((ref) {
  return SalaryRepository(ref.watch(apiClientProvider));
});

final salariesProvider = FutureProvider<List<SalaryResponse>>((ref) async {
  final repo = ref.watch(salaryRepositoryProvider);
  return repo.getAll();
});

final salaryByIdProvider =
    FutureProvider.family<SalaryResponse, int>((ref, id) async {
  final repo = ref.watch(salaryRepositoryProvider);
  return repo.getById(id);
});

final salaryByEmployeeProvider =
    FutureProvider.family<SalaryResponse, int>((ref, employeeId) async {
  final repo = ref.watch(salaryRepositoryProvider);
  return repo.getByEmployee(employeeId);
});
