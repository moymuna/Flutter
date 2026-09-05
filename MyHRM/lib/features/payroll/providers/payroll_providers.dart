import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/payroll/data/payroll_repository.dart';
import 'package:my_hrm/features/payroll/data/models/payroll.dart';

final payrollRepositoryProvider = Provider<PayrollRepository>((ref) {
  return PayrollRepository(ref.watch(apiClientProvider));
});

final payrollsProvider = FutureProvider<List<PayrollResponse>>((ref) async {
  final repo = ref.watch(payrollRepositoryProvider);
  return repo.getAll();
});

final payrollSearchProvider = StateProvider<String>((ref) => '');

final filteredPayrollsProvider =
    FutureProvider<List<PayrollResponse>>((ref) async {
  final keyword = ref.watch(payrollSearchProvider);
  final repo = ref.watch(payrollRepositoryProvider);
  if (keyword.isEmpty) return repo.getAll();
  return repo.search(keyword);
});

final payrollByIdProvider =
    FutureProvider.family<PayrollResponse, int>((ref, id) async {
  final repo = ref.watch(payrollRepositoryProvider);
  return repo.getById(id);
});
