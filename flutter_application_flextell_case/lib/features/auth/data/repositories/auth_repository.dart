import 'package:flutter/rendering.dart';
import 'package:flutter_application_flextell_case/core/storage/secure_storage_service.dart';
import 'package:flutter_application_flextell_case/features/auth/data/models/auth_token_model.dart';
import 'package:flutter_application_flextell_case/features/auth/data/services/auth_service.dart';
import 'package:flutter_application_flextell_case/features/auth/data/services/refreshToken.dart';

class AuthRepository {
  final AuthService service;
  final Refreshtoken refreshtokenservice;
  final SecureStorageService storage;

  AuthRepository(this.service, this.refreshtokenservice, this.storage);

  Future<AuthTokenModel> login() async {
    final token = await service.login();

    await storage.saveTokens(token);

    debugPrint('TOKENS SAVED');

    return token;
  }

  Future<AuthTokenModel> refreshToken() async {
    final refresh = await storage.getRefreshToken();

    final newToken = await refreshtokenservice.refreshToken(refresh!);

    await storage.saveTokens(newToken);

    return newToken;
  }
}
