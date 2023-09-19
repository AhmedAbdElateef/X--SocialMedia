part of login_methods;

class FacebookLogin extends LoginMethod {
  final _facebookAuth = FacebookAuth.instance;

  @override
  Future<AuthCredential?> _getAuthCredential() async {
    final result = await _facebookAuth.login();
    if (result.status == LoginStatus.success) {
      return FacebookAuthProvider.credential(result.accessToken!.token);
    }

    return null;
  }
}
