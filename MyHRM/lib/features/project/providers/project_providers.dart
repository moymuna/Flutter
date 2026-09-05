import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/project/data/project_repository.dart';
import 'package:my_hrm/features/project/data/models/project.dart';

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  return ProjectRepository(ref.watch(apiClientProvider));
});

final projectsProvider = FutureProvider<List<ProjectResponse>>((ref) async {
  final repo = ref.watch(projectRepositoryProvider);
  return repo.getAll();
});

final projectByIdProvider =
    FutureProvider.family<ProjectResponse, int>((ref, id) async {
  final repo = ref.watch(projectRepositoryProvider);
  return repo.getById(id);
});
