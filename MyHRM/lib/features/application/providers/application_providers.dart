import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/application/data/application_repository.dart';
import 'package:my_hrm/features/application/data/models/application.dart';

final applicationRepositoryProvider = Provider<ApplicationRepository>((ref) {
  return ApplicationRepository(ref.watch(apiClientProvider));
});

final applicationsProvider =
    FutureProvider<List<ApplicationResponse>>((ref) async {
  final repo = ref.watch(applicationRepositoryProvider);
  return repo.getAll();
});

final applicationSearchProvider = StateProvider<String>((ref) => '');

final filteredApplicationsProvider =
    FutureProvider<List<ApplicationResponse>>((ref) async {
  final keyword = ref.watch(applicationSearchProvider);
  final repo = ref.watch(applicationRepositoryProvider);
  if (keyword.isEmpty) return repo.getAll();
  return repo.search(keyword);
});

final applicationByIdProvider =
    FutureProvider.family<ApplicationResponse, int>((ref, id) async {
  final repo = ref.watch(applicationRepositoryProvider);
  return repo.getById(id);
});

final applicationsByJobPostProvider =
    FutureProvider.family<List<ApplicationResponse>, int>((ref, jobPostId) async {
  final repo = ref.watch(applicationRepositoryProvider);
  return repo.getByJobPost(jobPostId);
});
