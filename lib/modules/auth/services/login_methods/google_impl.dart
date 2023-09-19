part of login_methods;

class GoogleLogin extends LoginMethod {
  final _googleClient = GoogleSignIn(scopes: ["email", "profile"]);

  @override
  Future<AuthCredential?> _getAuthCredential() async {
    final googleAccount = await _googleClient.signIn();
    if (googleAccount != null) {
      final tokens = await googleAccount.authentication;
      return GoogleAuthProvider.credential(
        accessToken: tokens.accessToken,
        idToken: tokens.idToken,
      );
    }

    return null;
  }
}
