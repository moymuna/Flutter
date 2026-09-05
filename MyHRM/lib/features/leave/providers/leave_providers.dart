import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/leave/data/leave_repository.dart';
import 'package:my_hrm/features/leave/data/models/leave.dart';

final leaveRepositoryProvider = Provider<LeaveRepository>((ref) {
  return LeaveRepository(ref.watch(apiClientProvider));
});

final leavesProvider = FutureProvider<List<LeaveResponse>>((ref) async {
  final repo = ref.watch(leaveRepositoryProvider);
  return repo.getAll();
});

final leaveSearchProvider = StateProvider<String>((ref) => '');

final filteredLeavesProvider = FutureProvider<List<LeaveResponse>>((ref) async {
  final keyword = ref.watch(leaveSearchProvider);
  final repo = ref.watch(leaveRepositoryProvider);
  if (keyword.isEmpty) return repo.getAll();
  return repo.search(keyword);
});

final leaveByIdProvider =
    FutureProvider.family<LeaveResponse, int>((ref, id) async {
  final repo = ref.watch(leaveRepositoryProvider);
  return repo.getById(id);
});

final leavesByStatusProvider =
    FutureProvider.family<List<LeaveResponse>, String>((ref, status) async {
  final repo = ref.watch(leaveRepositoryProvider);
  return repo.getByStatus(status);
});
