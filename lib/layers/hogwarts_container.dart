import 'application/repositories/authentication_repo.dart';
import 'application/services/authentication_service.dart';
import 'core/utils/app_injector.dart';
import 'domain/repositories/authentication_repo.dart';
import 'domain/usecases/authenticate_user.dart';
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
    AppInjector.lazy<AuthenticateUser>(
      () => AuthenticateUser(repo: AppInjector.get<AuthenticationRepo>()),
    );
  }

  /// Inject the bloc.
  void _injectBlocs() {
    AppInjector.lazy<LandingCubit>(
      () => LandingCubit(AppInjector.get<AuthenticateUser>()),
    );
  }
}
