import 'package:firebase_auth/firebase_auth.dart';
//------------------------------------------------

class ResetPasswordClient {
  final _auth = FirebaseAuth.instance;

  Future<void> requestPasswordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }
}
