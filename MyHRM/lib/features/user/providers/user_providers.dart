import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/shared/providers.dart';
import 'package:my_hrm/features/user/data/user_repository.dart';
import 'package:my_hrm/features/user/data/models/user.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository(ref.watch(apiClientProvider));
});

final usersProvider = FutureProvider<List<UserResponse>>((ref) async {
  final repo = ref.watch(userRepositoryProvider);
  return repo.getAll();
});

final userSearchProvider = StateProvider<String>((ref) => '');

final filteredUsersProvider = FutureProvider<List<UserResponse>>((ref) async {
  final keyword = ref.watch(userSearchProvider);
  final repo = ref.watch(userRepositoryProvider);
  if (keyword.isEmpty) return repo.getAll();
  return repo.getAll();
});

final userByIdProvider =
    FutureProvider.family<UserResponse, int>((ref, id) async {
  final repo = ref.watch(userRepositoryProvider);
  return repo.getById(id);
});
