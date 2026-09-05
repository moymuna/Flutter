import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/salary_grade/data/salary_grade_repository.dart';
import 'package:my_hrm/features/salary_grade/data/models/salary_grade.dart';

final salaryGradeRepositoryProvider = Provider<SalaryGradeRepository>((ref) {
  return SalaryGradeRepository(ref.watch(apiClientProvider));
});

final salaryGradesProvider =
    FutureProvider<List<SalaryGradeResponse>>((ref) async {
  final repo = ref.watch(salaryGradeRepositoryProvider);
  return repo.getAll();
});

final activeSalaryGradesProvider =
    FutureProvider<List<SalaryGradeResponse>>((ref) async {
  final repo = ref.watch(salaryGradeRepositoryProvider);
  return repo.getActive();
});
