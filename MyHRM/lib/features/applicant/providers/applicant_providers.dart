import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/applicant/data/applicant_repository.dart';
import 'package:my_hrm/features/applicant/data/models/applicant.dart';

final applicantRepositoryProvider = Provider<ApplicantRepository>((ref) {
  return ApplicantRepository(ref.watch(apiClientProvider));
});

final applicantsProvider = FutureProvider<List<ApplicantResponse>>((ref) async {
  final repo = ref.watch(applicantRepositoryProvider);
  return repo.getAll();
});

final applicantSearchProvider = StateProvider<String>((ref) => '');

final filteredApplicantsProvider =
    FutureProvider<List<ApplicantResponse>>((ref) async {
  final keyword = ref.watch(applicantSearchProvider);
  final repo = ref.watch(applicantRepositoryProvider);
  if (keyword.isEmpty) return repo.getAll();
  return repo.search(keyword);
});

final applicantByIdProvider =
    FutureProvider.family<ApplicantResponse, int>((ref, id) async {
  final repo = ref.watch(applicantRepositoryProvider);
  return repo.getById(id);
});
