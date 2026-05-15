import 'package:flutter/cupertino.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_application_flextell_case/core/constants/app_constants.dart';
import 'package:flutter_application_flextell_case/features/auth/data/models/auth_token_model.dart';

class AuthService {
  final FlutterAppAuth _appAuth = FlutterAppAuth();

  Future<AuthTokenModel> login() async {
    // for test..
    debugPrint('===== AUTH DEBUG START =====');
    debugPrint('ISSUER: ${AppConstants.issuer}');
    debugPrint('CLIENT_ID: ${AppConstants.clientId}');
    debugPrint('REDIRECT_URL: ${AppConstants.redirectUrl}');
    debugPrint('===== AUTH DEBUG END =====');

    try {
      final result = await _appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          AppConstants.clientId,
          AppConstants.redirectUrl,
          issuer: AppConstants.issuer,
          clientSecret: AppConstants.clientSecret,
          scopes: [
            'openid',
            'profile',
            'email',
            'offline_access',
            'customers:read',
          ],
        ),
      );

      debugPrint('AUTH RESPONSE: ${result.toString()}');

      if (result == null) {
        throw Exception('Authorization failed');
      }

      debugPrint('===== TOKEN DEBUG START =====');
      debugPrint('ACCESS TOKEN: ${result.accessToken}');
      debugPrint('REFRESH TOKEN: ${result.refreshToken}');
      debugPrint('===== TOKEN DEBUG END =====');

      return AuthTokenModel(
        accessToken: result.accessToken ?? '',

        refreshToken: result.refreshToken ?? '',

        expiresAt: result.accessTokenExpirationDateTime ?? DateTime.now(),
      );
    } catch (e, stackTrace) {
      debugPrint('LOGIN ERROR: $e');

      debugPrint('STACK TRACE: $stackTrace');

      throw Exception('Login failed: $e');
    }
  }
}
