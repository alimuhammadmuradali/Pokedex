import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/auth/auth_model/auth_credentials.dart';
import 'package:pokemon/session/cubit/session_cubit.dart';

enum AuthState { login, signUp }

class AuthCubit extends Cubit<AuthState> {
  SessionCubit? sessionCubit;

  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  void showLogin() => emit(AuthState.login);
  void showSignUp() => emit(AuthState.signUp);
  void launchSession(AuthCredentials credentials) =>
      sessionCubit?.showSession(credentials);
}
