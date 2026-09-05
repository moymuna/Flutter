import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/leave_type/data/leave_type_repository.dart';
import 'package:my_hrm/features/leave_type/data/models/leave_type.dart';

final leaveTypeRepositoryProvider = Provider<LeaveTypeRepository>((ref) {
  return LeaveTypeRepository(ref.watch(apiClientProvider));
});

final leaveTypesProvider = FutureProvider<List<LeaveTypeResponse>>(
    (ref) async {
  final repo = ref.watch(leaveTypeRepositoryProvider);
  return repo.getAll();
});

final leaveTypeByIdProvider =
    FutureProvider.family<LeaveTypeResponse, int>((ref, id) async {
  final repo = ref.watch(leaveTypeRepositoryProvider);
  return repo.getById(id);
});
