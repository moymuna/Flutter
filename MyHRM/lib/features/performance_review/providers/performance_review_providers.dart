import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/performance_review/data/performance_review_repository.dart';
import 'package:my_hrm/features/performance_review/data/models/performance_review.dart';

final performanceReviewRepositoryProvider =
    Provider<PerformanceReviewRepository>((ref) {
  return PerformanceReviewRepository(ref.watch(apiClientProvider));
});

final performanceReviewsProvider =
    FutureProvider<List<PerformanceReviewResponse>>((ref) async {
  final repo = ref.watch(performanceReviewRepositoryProvider);
  return repo.getAll();
});

final performanceReviewByIdProvider =
    FutureProvider.family<PerformanceReviewResponse, int>((ref, id) async {
  final repo = ref.watch(performanceReviewRepositoryProvider);
  return repo.getById(id);
});
