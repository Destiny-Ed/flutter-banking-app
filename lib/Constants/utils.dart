///VALIDATE EMAIL
bool validateEmail(String? email) {
  bool _isEmailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email!);

  return _isEmailValid;
}