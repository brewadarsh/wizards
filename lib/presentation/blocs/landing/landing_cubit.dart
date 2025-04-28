import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/authenticate_user.dart';
import '../../../domain/usecases/authorize_user.dart';
import '../../../domain/usecases/validate_token.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  final ValidateToken validateToken;
  final AuthorizeUser authorizeUser;
  final AuthenticateUser authenticateUser;

  LandingCubit({
    required this.validateToken,
    required this.authorizeUser,
    required this.authenticateUser,
  }) : super(LandingLoadingState());

  void triggerPostLogin() async {
    try {
      await validateToken();
      // TODO: emit state to navigate to the next page.
    } catch (error) {
      return triggerUserAuthorization();
    }
  }

  void triggerUserAuthentication() async {
    authenticateUser();
  }

  void triggerUserAuthorization() async {
    try {
      await authorizeUser();
    } catch (_) {
      return emit(LandingDefaultState());
    }
  }
}
