import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/storage/secure_storage.dart';
import 'auth_repository.dart';
import 'auth_model.dart';

// Watches whether user is logged in — drives router redirect
final authStateProvider = FutureProvider<UserModel?>((ref) async {
  final storage = ref.watch(secureStorageProvider);
  final token = await storage.getToken();
  if (token == null) return null;
  final userId = await storage.getUserId();
  if (userId == null) return null;
  return UserModel(id: userId, token: token);
});

// Notifier for login / logout actions
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<void>>(
  (ref) => AuthNotifier(ref),
);

class AuthNotifier extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;
  AuthNotifier(this._ref) : super(const AsyncData(null));

  Future<String?> sendOtp(String phone) async {
    state = const AsyncLoading();
    try {
      final repo = _ref.read(authRepositoryProvider);
      await repo.sendOtp(phone);
      state = const AsyncData(null);
      return null;
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      return e.toString();
    }
  }

  Future<String?> verifyOtp(String phone, String otp) async {
    state = const AsyncLoading();
    try {
      final repo = _ref.read(authRepositoryProvider);
      final response = await repo.verifyOtp(phone, otp);
      final storage = _ref.read(secureStorageProvider);
      await storage.saveToken(response.accessToken);
      await storage.saveRefreshToken(response.refreshToken);
      await storage.saveUserId(response.userId);
      await storage.saveSocietyId(response.societyId);
      state = const AsyncData(null);
      _ref.invalidate(authStateProvider);
      return null;
    } catch (e) {
      state = AsyncError(e, StackTrace.current);
      return e.toString();
    }
  }

  Future<void> logout() async {
    final storage = _ref.read(secureStorageProvider);
    await storage.clearAll();
    _ref.invalidate(authStateProvider);
  }
}
