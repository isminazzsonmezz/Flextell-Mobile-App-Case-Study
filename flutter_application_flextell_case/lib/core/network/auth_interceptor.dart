import 'package:dio/dio.dart';
import 'package:flutter_application_flextell_case/core/storage/secure_storage_service.dart';
import 'package:flutter_application_flextell_case/features/auth/data/services/refreshToken.dart';

class AuthInterceptor extends Interceptor {
  final SecureStorageService storage;
  final Refreshtoken refreshtokenService;

  AuthInterceptor(this.storage, this.refreshtokenService);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    /*
    final tokens = await storage.getTokens();
    
    final accessToken =
        tokens?.accessToken;
    */
    final accessToken = await storage.getAccessToken();

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshToken = await storage.getRefreshToken();

      if (refreshToken != null) {
        final newToken = await refreshtokenService.refreshToken(refreshToken);

        await storage.saveTokens(newToken);

        final request = err.requestOptions;

        request.headers['Authorization'] = 'Bearer ${newToken.accessToken}';

        final response = await Dio().fetch(request);

        return handler.resolve(response);
      }
    }

    handler.next(err);
  }
}
