import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/interview/data/interview_repository.dart';
import 'package:my_hrm/features/interview/data/models/interview.dart';

final interviewRepositoryProvider = Provider<InterviewRepository>((ref) {
  return InterviewRepository(ref.watch(apiClientProvider));
});

final interviewsProvider = FutureProvider<List<InterviewResponse>>((ref) async {
  final repo = ref.watch(interviewRepositoryProvider);
  return repo.getAll();
});

final interviewByIdProvider =
    FutureProvider.family<InterviewResponse, int>((ref, id) async {
  final repo = ref.watch(interviewRepositoryProvider);
  return repo.getById(id);
});

final interviewsByApplicationProvider =
    FutureProvider.family<List<InterviewResponse>, int>(
        (ref, applicationId) async {
  final repo = ref.watch(interviewRepositoryProvider);
  return repo.getByApplication(applicationId);
});

final myInterviewsProvider = FutureProvider<List<InterviewResponse>>(
    (ref) async {
  final repo = ref.watch(interviewRepositoryProvider);
  return repo.getMy();
});
