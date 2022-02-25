import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/auth/auth_cubit/auth_cubit.dart';
import 'package:pokemon/auth/repository/auth_repository.dart';
import 'package:pokemon/auth/form_sumission_status.dart';
import 'package:pokemon/auth/signup/bloc/sign_up_bloc.dart';
import 'package:pokemon/auth/signup/bloc/sign_up_event.dart';
import 'package:pokemon/auth/signup/bloc/sign_up_state.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => SignUpBloc(
          authRepo: context.read<AuthRepository>(),
          authCubit: context.read<AuthCubit>(),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                logo(context),
                _signUpForm(),
              ],
            ),
            _showLoginButton(context),
          ],
        ),
      ),
    );
  }

  Widget logo(BuildContext context) {
    return Image.asset(
      'asset/pokedex.png',
      height: MediaQuery.of(context).size.width * 0.3,
      width: MediaQuery.of(context).size.width * 0.7,
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is SubmissionFailed) {
            _showAlertDialog(context, formStatus.exception.toString());
          }
        },
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                _usernameField(),
                const SizedBox(height: 20),
                _emailField(),
                const SizedBox(height: 20),
                _passwordField(),
                const SizedBox(height: 50),
                _signUpButton(),
              ],
            ),
          ),
        ));
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Username',
        ),
        validator: (value) =>
            state.isValidUsername ? null : 'Username is too short',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpUsernameChanged(username: value),
            ),
      );
    });
  }

  Widget _emailField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Email',
        ),
        validator: (value) => state.isValidEmail ? null : 'Invalid email',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpEmailChanged(email: value),
            ),
      );
    });
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
          icon: Icon(Icons.security),
          hintText: 'Password',
        ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password is too short',
        onChanged: (value) => context.read<SignUpBloc>().add(
              SignUpPasswordChanged(password: value),
            ),
      );
    });
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(builder: (context, state) {
      return state.formStatus is FormSubmitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  context.read<SignUpBloc>().add(SignUpSubmitted());
                }
              },
              child: const Text('Sign Up'),
            );
    });
  }

  Widget _showLoginButton(BuildContext context) {
    return SafeArea(
      child: TextButton(
        child: const Text('Already have an account? Sign in.'),
        onPressed: () => context.read<AuthCubit>().showLogin(),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, String message) {
    // ignore: avoid_single_cascade_in_expression_statements
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: true,
        title: 'Error',
        desc: message,
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }
}
