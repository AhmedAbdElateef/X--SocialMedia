part of login_methods;

class EmailLogin extends LoginMethod {
  final String userEmail;
  final String userPassword;

  EmailLogin({
    required this.userEmail,
    required this.userPassword,
  });

  @override
  Future<AuthCredential?> _getAuthCredential() async {
    return EmailAuthProvider.credential(
      email: userEmail,
      password: userPassword,
    );
  }
}
