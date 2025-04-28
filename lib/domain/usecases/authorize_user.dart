import '../repositories/authentication_repo.dart';

class AuthorizeUser {
  final AuthenticationRepo repo;

  const AuthorizeUser({required this.repo});

  Future<void> call() => repo.getAccessToken();
}
