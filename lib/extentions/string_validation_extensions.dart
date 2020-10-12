extension StringValidation on String {
  static RegExp _alpha =
      RegExp(r'^[a-zA-Z- \u00c4-\u00e4-\u00d6-\u00f6-\u00dc-\u00fc]+$');
  static RegExp _numeric = RegExp(r'^-?[0-9]+$');
  static RegExp _alphanumeric = RegExp(r'^[a-zA-Z0-9- ]+$');
  static RegExp _float =
      RegExp(r'^(?:-?(?:[0-9]+))?(?:\.[0-9]*)?(?:[eE][\+\-]?(?:[0-9]+))?$');
  static RegExp _email = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp _postalCode = RegExp(r'^\d\d\d\d+$');
  static RegExp _idNumber = RegExp(
      r"(((\d{2}((0[13578]|1[02])(0[1-9]|[12]\d|3[01])|(0[13456789]|1[012])(0[1-9]|[12]\d|30)|02(0[1-9]|1\d|2[0-8])))|([02468][048]|[13579][26])0229))(( |-)(\d{4})( |-)(\d{3})|(\d{7}))");

  bool get isEmailAddress {
    return _email.hasMatch(this);
  }

  bool get isIDNumber {
    return _idNumber.hasMatch(this);
  }

  bool get isAlpha {
    return _alpha.hasMatch(this);
  }

  bool get isNumeric {
    return _numeric.hasMatch(this);
  }

  bool get isAlphaNumeric {
    return _alphanumeric.hasMatch(this);
  }

  bool get isPostalCode {
    return _postalCode.hasMatch(this);
  }

  bool get isFloat {
    return _float.hasMatch(this);
  }

  String capitalize() {
      return "${this[0].toUpperCase()}${this.substring(1)}";
    }
}
