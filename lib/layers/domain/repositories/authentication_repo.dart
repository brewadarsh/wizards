abstract interface class AuthenticationRepo {
  /// Authenticate the user using OIDC.
  Future<void> authenticate();
}
