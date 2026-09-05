import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_hrm/auth/auth_repository.dart';
import 'package:my_hrm/shared/providers.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.watch(apiClientProvider),
    ref.watch(storageServiceProvider),
  );
});

class AuthController extends StateNotifier<AsyncValue<Map<String, dynamic>?>> {
  AuthController(this._ref) : super(const AsyncValue.loading()) {
    _restoreSession();
  }

  final Ref _ref;

  Future<void> _restoreSession() async {
    final storage = _ref.read(storageServiceProvider);
    final user = await storage.getUser();
    state = AsyncValue.data(user);
  }

  Future<void> login(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final repo = _ref.read(authRepositoryProvider);
      final res = await repo.login(LoginRequestDto(
        email: email,
        password: password,
      ));
      state = AsyncValue.data(res);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> logout() async {
    await _ref.read(authRepositoryProvider).logout();
    state = const AsyncValue.data(null);
  }
}

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<Map<String, dynamic>?>>(
        (ref) {
  return AuthController(ref);
});

final currentUserProvider = Provider<Map<String, dynamic>?>((ref) {
  return ref.watch(authControllerProvider).value;
});
