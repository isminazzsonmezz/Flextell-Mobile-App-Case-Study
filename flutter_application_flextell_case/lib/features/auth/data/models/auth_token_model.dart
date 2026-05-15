class AuthTokenModel {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  AuthTokenModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });
}