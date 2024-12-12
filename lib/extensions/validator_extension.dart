extension ValidatorString on String {
  bool get validEmail {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(this);
  }

  bool get isValidName {
    const namePattern = r'^(?=.*[a-zA-Z])[a-zA-Z0-9_]{3,16}$';
    final regExp = RegExp(namePattern);
    return regExp.hasMatch(this);
  }

  bool get validMobileNumber {
    const phoneNumberPattern = r'^(?:[+0]9)?[0-9\s-()]*$';
    final regExp = RegExp(phoneNumberPattern);
    return regExp.hasMatch(this);
  }

  bool get isValidUsername {
    const usernamePattern = r'^(?!.*\.\.)(?!.*\.$)[^\W][\w.]{0,29}$';
    final regExp = RegExp(usernamePattern);
    return regExp.hasMatch(this);
  }
}
