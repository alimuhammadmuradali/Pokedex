import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/auth/auth_cubit/auth_cubit.dart';
import 'package:pokemon/auth/auth_naviigator.dart';
import 'package:pokemon/splash_screen.dart';
import 'package:pokemon/session/cubit/session_cubit.dart';
import 'package:pokemon/session/cubit/session_state.dart';
import 'package:pokemon/session/session_view/bloc.dart';
import 'package:pokemon/session/session_view/session_view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(builder: (context, state) {
      return Navigator(
        pages: [
          // Show loading screen
          if (state is UnknownSessionState)
            const MaterialPage(child: SplashScreen()),

          // Show auth flow
          if (state is Unauthenticated)
            MaterialPage(
              child: BlocProvider(
                create: (context) =>
                    AuthCubit(sessionCubit: context.read<SessionCubit>()),
                child: const AuthNavigator(),
              ),
            ),

          // Show session flow
          if (state is Authenticated)
            MaterialPage(
              child: BlocProvider(
                  create: (context) => NavbarBloc(),
                  child: SessionView(id: state.user.userId)),
            )
        ],
        onPopPage: (route, result) => route.didPop(result),
      );
    });
  }
}
