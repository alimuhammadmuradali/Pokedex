import 'package:pokemon/auth/auth_model/auth_credentials.dart';

abstract class SessionState {}

class UnknownSessionState extends SessionState {}

class Unauthenticated extends SessionState {}

class Authenticated extends SessionState {
  final AuthCredentials user;

  Authenticated({required this.user});
}
