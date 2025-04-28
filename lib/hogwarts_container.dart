import 'data/repositories/authentication_repo.dart';
import 'data/services/authentication_service.dart';
import 'core/utils/app_injector.dart';
import 'domain/repositories/authentication_repo.dart';
import 'domain/usecases/authenticate_user.dart';
import 'domain/usecases/authorize_user.dart';
import 'domain/usecases/validate_token.dart';
import 'presentation/blocs/landing/landing_cubit.dart';

class HogwartsContainer {
  HogwartsContainer.inject() {
    _injectServices();
    _injectRepositories();
    _injectUsecases();
    _injectBlocs();
  }

  /// Inject the services.
  void _injectServices() {
    AppInjector.lazy<IAuthenticationService>(
      () => KeycloakAuthenticationService(),
    );
  }

  /// Inject the repositories.
  void _injectRepositories() {
    AppInjector.lazy<AuthenticationRepo>(
      () => AuthenticationRepoIMPL(
        service: AppInjector.get<IAuthenticationService>(),
      ),
    );
  }

  /// Inject the use-cases.
  void _injectUsecases() {
    AppInjector.lazy<ValidateToken>(
      () => ValidateToken(repo: AppInjector.get<AuthenticationRepo>()),
    );
    AppInjector.lazy<AuthenticateUser>(
      () => AuthenticateUser(repo: AppInjector.get<AuthenticationRepo>()),
    );
    AppInjector.lazy<AuthorizeUser>(
      () => AuthorizeUser(repo: AppInjector.get<AuthenticationRepo>()),
    );
  }

  /// Inject the bloc.
  void _injectBlocs() {
    AppInjector.lazy<LandingCubit>(
      () => LandingCubit(
        validateToken: AppInjector.get<ValidateToken>(),
        authorizeUser: AppInjector.get<AuthorizeUser>(),
        authenticateUser: AppInjector.get<AuthenticateUser>(),
      ),
    );
  }
}
