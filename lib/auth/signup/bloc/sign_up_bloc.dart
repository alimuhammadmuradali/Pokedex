import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/auth/auth_cubit/auth_cubit.dart';
import 'package:pokemon/auth/auth_model/auth_credentials.dart';
import 'package:pokemon/auth/repository/auth_repository.dart';
import 'package:pokemon/auth/form_sumission_status.dart';
import 'package:pokemon/auth/signup/bloc/sign_up_event.dart';
import 'package:pokemon/auth/signup/bloc/sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SignUpBloc({required this.authRepo, required this.authCubit})
      : super(SignUpState()) {
    on<SignUpUsernameChanged>(
        (event, emit) => emit(state.copyWith(username: event.username)));
    on<SignUpEmailChanged>(
        (event, emit) => emit(state.copyWith(email: event.email)));
    on<SignUpPasswordChanged>(
        (event, emit) => emit(state.copyWith(password: event.password)));
    on<SignUpSubmitted>(_onEvent);
  }

  void _onEvent(SignUpEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(formStatus: FormSubmitting()));

    try {
      final userId = await authRepo.signUp(
        state.username,
        state.email,
        state.password,
      );

      emit(state.copyWith(formStatus: SubmissionSuccess()));

      authCubit
          .launchSession(AuthCredentials(email: state.email, userId: userId));
    } catch (e) {
      emit(state.copyWith(formStatus: SubmissionFailed(e as Exception)));
      emit(state.copyWith(formStatus: const InitialFormStatus()));
    }
  }
}
