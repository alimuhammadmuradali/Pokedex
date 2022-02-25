import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/auth/auth_cubit/auth_cubit.dart';
import 'package:pokemon/auth/auth_model/auth_credentials.dart';
import 'package:pokemon/auth/repository/auth_repository.dart';
import 'package:pokemon/auth/form_sumission_status.dart';
import 'package:pokemon/auth/login/bloc/login_event.dart';
import 'package:pokemon/auth/login/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({required this.authRepo, required this.authCubit})
      : super(LoginState()) {
    on<LoginEmailChanged>(
        (event, emit) => emit(state.copyWith(email: event.email)));

    on<LoginPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));

    on<LoginSubmitted>(_onEvent);
  }

  void _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      final userId = await authRepo.login(
        state.email,
        state.password,
      );
      emit(state.copyWith(formStatus: SubmissionSuccess()));

      authCubit.launchSession(AuthCredentials(
        email: state.email,
        userId: userId,
      ));
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    }
  }
}
