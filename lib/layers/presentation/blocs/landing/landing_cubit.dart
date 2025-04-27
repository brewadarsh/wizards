import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/authenticate_user.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  final AuthenticateUser authenticateUser;

  LandingCubit(this.authenticateUser) : super(LandingInitial());

  void authenticate() => authenticateUser();
}
