import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/job_post/data/job_post_repository.dart';
import 'package:my_hrm/features/job_post/data/models/job_post.dart';

final jobPostRepositoryProvider = Provider<JobPostRepository>((ref) {
  return JobPostRepository(ref.watch(apiClientProvider));
});

final jobPostsProvider = FutureProvider<List<JobPostResponse>>((ref) async {
  final repo = ref.watch(jobPostRepositoryProvider);
  return repo.getAll();
});

final jobPostSearchProvider = StateProvider<String>((ref) => '');

final filteredJobPostsProvider =
    FutureProvider<List<JobPostResponse>>((ref) async {
  final keyword = ref.watch(jobPostSearchProvider);
  final repo = ref.watch(jobPostRepositoryProvider);
  if (keyword.isEmpty) return repo.getAll();
  return repo.search(keyword);
});

final jobPostByIdProvider =
    FutureProvider.family<JobPostResponse, int>((ref, id) async {
  final repo = ref.watch(jobPostRepositoryProvider);
  return repo.getById(id);
});

final jobPostsByStatusProvider =
    FutureProvider.family<List<JobPostResponse>, String>((ref, status) async {
  final repo = ref.watch(jobPostRepositoryProvider);
  return repo.getByStatus(status);
});
