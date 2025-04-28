abstract interface class AuthenticationRepo {
  /// Validates the session's access token. If expired, this quietly calls the
  /// refreshes the token.
  ///
  /// Return true if the token is validated successfully.
  ///
  /// Throws [ErrorEntity.invalidToken] if no valid token is found in the session.
  Future<bool> validateAccessToken();

  /// Get the authentication code.
  Future<void> getAuthCode();

  /// Get the access token using PKCE.
  Future<void> getAccessToken();
}
