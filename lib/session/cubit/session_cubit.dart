import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/auth/auth_model/auth_credentials.dart';
import 'package:pokemon/auth/repository/auth_repository.dart';
import 'package:pokemon/session/cubit/session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;

  SessionCubit({required this.authRepo}) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final userId = await authRepo.attemptAutoLogin();
      emit(Authenticated(user: AuthCredentials(userId: userId)));
    } on Exception {
      emit(Unauthenticated());
    }
  }

  void showAuth() => emit(Unauthenticated());
  void showSession(AuthCredentials credentials) {
    emit(Authenticated(user: credentials));
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
