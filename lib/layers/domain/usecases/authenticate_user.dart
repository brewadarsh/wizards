import '../repositories/authentication_repo.dart';

final class AuthenticateUser {
  final AuthenticationRepo repo;

  const AuthenticateUser({required this.repo});
  Future<void> call() => repo.authenticate();
}
