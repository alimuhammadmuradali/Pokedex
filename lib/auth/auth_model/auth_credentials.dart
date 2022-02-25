class AuthCredentials {
  String? email;
  String? password;
  final String userId;

  AuthCredentials({
    this.email,
    this.password,
    required this.userId,
  });
}

