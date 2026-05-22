import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

class SecureStorageService {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _keyToken        = 'access_token';
  static const _keyRefreshToken = 'refresh_token';
  static const _keySocietyId   = 'society_id';
  static const _keyUserId       = 'user_id';

  Future<void> saveToken(String token) =>
      _storage.write(key: _keyToken, value: token);
  Future<String?> getToken() => _storage.read(key: _keyToken);

  Future<void> saveRefreshToken(String token) =>
      _storage.write(key: _keyRefreshToken, value: token);
  Future<String?> getRefreshToken() => _storage.read(key: _keyRefreshToken);

  Future<void> saveSocietyId(String id) =>
      _storage.write(key: _keySocietyId, value: id);
  Future<String?> getSocietyId() => _storage.read(key: _keySocietyId);

  Future<void> saveUserId(String id) =>
      _storage.write(key: _keyUserId, value: id);
  Future<String?> getUserId() => _storage.read(key: _keyUserId);

  Future<void> clearAll() => _storage.deleteAll();
}
