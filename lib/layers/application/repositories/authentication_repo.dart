import '../../domain/repositories/authentication_repo.dart';
import '../services/authentication_service.dart';

class AuthenticationRepoIMPL implements AuthenticationRepo {
  /// The authentication service.
  final IAuthenticationService service;

  const AuthenticationRepoIMPL({required this.service});

  @override
  Future<void> authenticate() => service.authenticate();
}
