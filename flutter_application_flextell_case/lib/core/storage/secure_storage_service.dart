import 'package:flutter_application_flextell_case/features/auth/data/models/auth_token_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  // Save tokens
  Future<void> saveTokens(AuthTokenModel token) async {
    await _storage.write(key: 'access_token', value: token.accessToken);
    await _storage.write(key: 'refresh_token', value: token.refreshToken);
    await _storage.write(key: 'expires_at', value: token.expiresAt.toIso8601String());
  }
 // Get token model
  Future<AuthTokenModel?> getTokens() async {
    final access = await _storage.read(key: 'access_token');
    final refresh = await _storage.read(key: 'refresh_token');
    final expires = await _storage.read(key: 'expires_at');

    if (access == null || refresh == null || expires == null) return null;

    return AuthTokenModel(
      accessToken: access,
      refreshToken: refresh,
      expiresAt: DateTime.parse(expires),
    );
  }

  // Get access token
  Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  // Get refresh token
  Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refresh_token');
  }

  // Clear tokens, for logout..
  Future<void> clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    await _storage.delete(key: 'expires_at');
  }

}