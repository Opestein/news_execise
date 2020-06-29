const String _kEmailRule = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$";

class FormValidators {
  bool validateEmail(String email) {
    final RegExp emailExp = new RegExp(_kEmailRule);
    if (email != null) email = email.trim();
    if (!emailExp.hasMatch(email) || email.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  bool validateUserName(String username) {
    if (username.isEmpty || username.length < 2) {
      return false;
    } else {
      return true;
    }
  }

  bool validatePhone(String phone) {
    if (phone.isEmpty || phone.length < 10) {
      return false;
    } else {
      return true;
    }
  }

  bool validatePassword(String password) {
    if (password.isEmpty || password.length < 6) {
      return false;
    } else {
      return true;
    }
  }

  bool validateSingleInput(String username) {
    if (username.isEmpty || username.length < 1) {
      return false;
    } else {
      return true;
    }
  }
}

/*class EmailValidator {
  final StreamTransformer<String,String> validateEmail =
  StreamTransformer<String,String>.fromHandlers(handleData: (email, sink){
    final RegExp emailExp = new RegExp(_kEmailRule);

    if (!emailExp.hasMatch(email) || email.isEmpty){
      sink.addError('Entre a valid email');
    } else {
      sink.add(email);
    }
  });
}*/
