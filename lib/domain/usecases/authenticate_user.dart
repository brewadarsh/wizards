import '../repositories/authentication_repo.dart';

class AuthenticateUser {
  final AuthenticationRepo repo;

  const AuthenticateUser({required this.repo});

  Future<void> call() => repo.getAuthCode();
}
