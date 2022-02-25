import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future<String> attemptAutoLogin() async {
    if (FirebaseAuth.instance.currentUser == null) {
      throw Exception('not signed in');
    }
    return FirebaseAuth.instance.currentUser!.uid;
  }

//return userid
  Future<String> login(String username, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);
      return userCredential.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//return userid
  Future<String> signUp(
    String username,
    String email,
    String password,
  ) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User u = user.user!;
      await u.updateDisplayName(username);
      await u.reload();
      return user.user!.uid;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message);
    }
    // await Future.delayed(const Duration(seconds: 3));
    // return 'abc';
  }

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
    // await Future.delayed(const Duration(seconds: 2));
  }
}
