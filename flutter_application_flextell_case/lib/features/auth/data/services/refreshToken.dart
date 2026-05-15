import 'package:dio/dio.dart';
import 'package:flutter_application_flextell_case/core/constants/app_constants.dart';
import 'package:flutter_application_flextell_case/features/auth/data/models/auth_token_model.dart';

class Refreshtoken {
  final Dio dio;

  Refreshtoken(this.dio);

  Future<AuthTokenModel> refreshToken(String refreshToken) async {

    final response = await dio.post(
      'https://dev.flextell.ai/oauth/token',
      data: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
        'client_id': AppConstants.clientId,
        'client_secret': AppConstants.clientSecret,
      },
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
      ),
    );

    final data = response.data;

    return AuthTokenModel(
      accessToken: data['access_token'],
      refreshToken: data['refresh_token'] ?? refreshToken,
      expiresAt: DateTime.now().add(
        Duration(seconds: data['expires_in']),
      ),
    );
  }
}