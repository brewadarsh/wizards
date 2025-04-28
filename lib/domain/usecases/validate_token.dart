import '../repositories/authentication_repo.dart';

class ValidateToken {
  final AuthenticationRepo repo;

  const ValidateToken({required this.repo});

  Future<void> call() => repo.validateAccessToken();
}
