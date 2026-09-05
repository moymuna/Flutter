import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/office/data/office_repository.dart';
import 'package:my_hrm/features/office/data/models/office.dart';

final officeRepositoryProvider = Provider<OfficeRepository>((ref) {
  return OfficeRepository(ref.watch(apiClientProvider));
});

final officesProvider = FutureProvider<List<OfficeResponse>>((ref) async {
  final repo = ref.watch(officeRepositoryProvider);
  return repo.getAll();
});

final officeSearchProvider =
    StateProvider<String>((ref) => '');

final filteredOfficesProvider = FutureProvider<List<OfficeResponse>>((ref) async {
  final keyword = ref.watch(officeSearchProvider);
  final repo = ref.watch(officeRepositoryProvider);
  if (keyword.isEmpty) return repo.getAll();
  return repo.search(keyword);
});

final officeByIdProvider =
    FutureProvider.family<OfficeResponse, int>((ref, id) async {
  final repo = ref.watch(officeRepositoryProvider);
  return repo.getById(id);
});
