import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/training/data/training_repository.dart';
import 'package:my_hrm/features/training/data/models/training.dart';

final trainingRepositoryProvider = Provider<TrainingRepository>((ref) {
  return TrainingRepository(ref.watch(apiClientProvider));
});

final trainingsProvider = FutureProvider<List<TrainingResponse>>((ref) async {
  final repo = ref.watch(trainingRepositoryProvider);
  return repo.getAll();
});

final trainingByIdProvider =
    FutureProvider.family<TrainingResponse, int>((ref, id) async {
  final repo = ref.watch(trainingRepositoryProvider);
  return repo.getById(id);
});
