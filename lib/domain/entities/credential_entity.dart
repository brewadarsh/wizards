import 'dart:convert';

class CredentialEntity {
  /// The access token.
  final String accessToken;

  /// The access token type.
  final String accessTokenType;

  /// The refresh token.
  final String refreshToken;

  const CredentialEntity({
    required this.accessToken,
    required this.accessTokenType,
    required this.refreshToken,
  });

  /// Check if the token is expired or not.
  static bool isExpired(final String accessToken) {
    final List<String> tokenParts = accessToken.split(".");
    if (tokenParts.length != 3) return true;

    // Decode the base64 encoded payload.
    try {
      final String payload = tokenParts[1];
      final String normalized = base64.normalize(payload);
      final String decoded = utf8.decode(base64Url.decode(normalized));
      final Map<String, dynamic> payloadJson = json.decode(decoded);

      // Get the expiry time.
      final int exp = payloadJson["exp"];
      final DateTime expireAt = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isAfter(expireAt);
    } catch (_) {
      return false;
    }
  }
}
