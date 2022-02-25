import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/auth/auth_cubit/auth_cubit.dart';
import 'package:pokemon/auth/signup/screen/sign_up_view.dart';
import 'login/screen/login_view.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show login
          if (state == AuthState.login) MaterialPage(child: LoginView()),

          // Allow push animation
          if (state == AuthState.signUp) MaterialPage(child: SignUpView()),
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
