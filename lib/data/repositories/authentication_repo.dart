import '../../domain/repositories/authentication_repo.dart';
import '../services/authentication_service.dart';

class AuthenticationRepoIMPL implements AuthenticationRepo {
  /// The authentication service.
  final IAuthenticationService service;

  const AuthenticationRepoIMPL({required this.service});

  @override
  Future<bool> validateAccessToken() => service.validateAccessToken();

  @override
  Future<void> getAuthCode() => service.getAuthCode();

  @override
  Future<void> getAccessToken() => service.getAccessToken();
}
