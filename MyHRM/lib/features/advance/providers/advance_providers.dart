import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/advance/data/advance_repository.dart';
import 'package:my_hrm/features/advance/data/models/advance.dart';

final advanceRepositoryProvider = Provider<AdvanceRepository>((ref) {
  return AdvanceRepository(ref.watch(apiClientProvider));
});

final advancesProvider = FutureProvider<List<AdvanceResponse>>((ref) async {
  final repo = ref.watch(advanceRepositoryProvider);
  return repo.getAll();
});

final advanceSearchProvider = StateProvider<String>((ref) => '');

final filteredAdvancesProvider =
    FutureProvider<List<AdvanceResponse>>((ref) async {
  final keyword = ref.watch(advanceSearchProvider);
  final repo = ref.watch(advanceRepositoryProvider);
  if (keyword.isEmpty) return repo.getAll();
  return repo.search(keyword);
});

final advanceByIdProvider =
    FutureProvider.family<AdvanceResponse, int>((ref, id) async {
  final repo = ref.watch(advanceRepositoryProvider);
  return repo.getById(id);
});

final advancePendingCountProvider = FutureProvider<int>((ref) async {
  final repo = ref.watch(advanceRepositoryProvider);
  return repo.countPending();
});
