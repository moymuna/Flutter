import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/leave_balance/data/leave_balance_repository.dart';
import 'package:my_hrm/features/leave_balance/data/models/leave_balance.dart';

final leaveBalanceRepositoryProvider = Provider<LeaveBalanceRepository>((ref) {
  return LeaveBalanceRepository(ref.watch(apiClientProvider));
});

final leaveBalancesProvider =
    FutureProvider<List<LeaveBalanceResponse>>((ref) async {
  final repo = ref.watch(leaveBalanceRepositoryProvider);
  return repo.getAll();
});

final leaveBalanceByIdProvider =
    FutureProvider.family<LeaveBalanceResponse, int>((ref, id) async {
  final repo = ref.watch(leaveBalanceRepositoryProvider);
  return repo.getById(id);
});

final leaveBalanceByEmployeeProvider =
    FutureProvider.family<List<LeaveBalanceResponse>, int>(
        (ref, employeeId) async {
  final repo = ref.watch(leaveBalanceRepositoryProvider);
  return repo.getByEmployee(employeeId);
});
