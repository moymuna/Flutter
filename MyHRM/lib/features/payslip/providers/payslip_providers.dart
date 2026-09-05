import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/payslip/data/payslip_repository.dart';
import 'package:my_hrm/features/payslip/data/models/payslip.dart';

final payslipRepositoryProvider = Provider<PayslipRepository>((ref) {
  return PayslipRepository(ref.watch(apiClientProvider));
});

final payslipsProvider = FutureProvider<List<PayslipResponse>>((ref) async {
  final repo = ref.watch(payslipRepositoryProvider);
  return repo.getAll();
});

final payslipByIdProvider =
    FutureProvider.family<PayslipResponse, int>((ref, id) async {
  final repo = ref.watch(payslipRepositoryProvider);
  return repo.getById(id);
});

final payslipsByEmployeeProvider =
    FutureProvider.family<List<PayslipResponse>, int>((ref, employeeId) async {
  final repo = ref.watch(payslipRepositoryProvider);
  return repo.getByEmployee(employeeId);
});
