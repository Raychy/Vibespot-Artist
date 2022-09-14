
///Ekeh Wisdom ekeh.wisdom@gmail.com
///c2019
///Sun Nov 24 2019

/// helper Regular expressions to validate email, oasswords etc
mixin ValidatorMixin {
 
  // Regular expression for valid email name@domain.com
  final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  // Regular expression for valid for a string containing atleast 8 characters, must contain a letter,
  // a number and a special character
  final RegExp _passwordRegExp = RegExp(
      r'^(?=.*[a-zA-Z])(?=.*[@$!%*?&])(?=.*\d)[A-Za-z\d@$!%*?&]{8,}$'); // ??
  // RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-].{5,25}');

  final RegExp _name = RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]');
  final RegExp _link = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)');

  RegExp _nigerianNumber = RegExp(r'^([0]?)(7|8|9)(0|1)\d{8}$');
  final RegExp _nigerianNumberFull = RegExp(r'^(234|0)(7|8|9)(0|1)\d{8}$');

  final RegExp _domain = RegExp(
      r'^[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)');
  final RegExp numberRegExp = RegExp(r'^\d+$'); // RegExp fto validate numbers
  final RegExp _phoneNumber =
      RegExp(r'^[0-9]{9,11}$'); // RegExp fto validate numbers
  // final RegExp _phoneNumber = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$'); // RegExp fto validate numbers

  //  final RegExp _cvvRegExp = RegExp(  r'^[0-9]{1}[0-9]{1}[0-9]{1}$',);
  final RegExp _pinRegExp = RegExp(
    r'^[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}$',
  );
  // final RegExp _otpRegExp = RegExp(
  //   r'^[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}}[0-9]{1}}[0-9]{1}$',
  // );
  final RegExp _atmNumberRegExp = RegExp(
      r'^[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}[0-9]{1}$');

  String? atmNumberValidator(String number) {
    number = number.replaceAll(' ', '');
    if (number.isEmpty) {
      return null;
    } else if (!_atmNumberRegExp.hasMatch(number)) {
      return 'Please enter a valid card number';
    } else
      return null;
  }

 

  String? pinValidator(
    String text,
  ) {
    if (text.isEmpty) {
      return '* 4 digit number required';
    } else if (!_pinRegExp.hasMatch(text)) {
      return '* 4 digit number required';
    } else
      return null;
  }

  String? otpValidator(String? text) {
    text = text?.trim() ?? '';
    if (text.isEmpty) {
      return '* Otp must be  6 digits';
    } else if (!numberRegExp.hasMatch(text) || text.length != 6) {
      return '* Otp must be  6 digits';
    } else
      return null;
  }

  String? emailValidator(String? email, [bool allowEmpty = false]) {
    String e = email?.trim() ?? '';
    if (e.isEmpty)
      return allowEmpty ? null : '* Please enter email';
    else if (!_emailRegExp.hasMatch(e))
      return '* Please enter a valid email adress';
    return null;
  }
 

  String? linkValidator(String link, [bool allowEmpty = true]) {
    String e = link.trim();
    if (e.isEmpty)
      return allowEmpty ? null : '* Please enter valid url';
    else if (!_link.hasMatch(e)) return '* Please Enter a valid url link';
    return null;
  }

  String? domainValidator(String? link, [bool allowEmpty = true]) {
    String e = link?.trim() ?? '';
    if (e.isEmpty)
      return allowEmpty ? null : '* Please enter valid domain';
    else if (!_domain.hasMatch(e)) return '* Please Enter a valid domain';
    return null;
  }

  String? passwordValidator(String? password) {
    String p = password?.trim() ?? '';
    if (p.isEmpty)
      return '* Please enter password';
    else if (p.length < 6) return '* Password must be atleast 6 characters';
    return null;
  }

  String? newpasswordValidator(String password) {
    // String p = password?.trim();
    if (password.isEmpty)
      return '* Please enter password';
    else if (password.length < 8)
      return '* Password must be atleast 8 characters';
    else if (!_passwordRegExp.hasMatch(password))
      return '* Password must contain a letter, number and a special character';
    return null;
  }

  String? confirmPasswordValidator(String password, String pass) {
    if (password != pass) return 'Passwords do not match';
    return null;
  }

  String? nameValidator(String? name,
      [bool allowEmpty = false, String? title]) {
    if (name?.isEmpty ?? true)
      return allowEmpty
          ? null
          : '* Please enter ${title != null ? title : 'name'}';
    else if (!_name.hasMatch(name!))
      return '* Please enter valid ${title != null ? title : 'name'}';
    return null;
  }

  String? phoneNumberValidator(String? number,
      [bool allowEmpty = false, bool restrictToNigeria = true]) {
    number = number?.replaceAll(' ', '') ?? '';
    if (number.isEmpty)
      return allowEmpty ? null : 'Please enter phone number';
    else if (!numberRegExp.hasMatch(number))
      return '* Phone number can only include numbers ';
    //  else if (number.length != 10) return '* Phone number must be 11 digits';
    else if (!_phoneNumber.hasMatch(number))
      return '* Please enter a valid phone number';
    else if (!_nigerianNumber.hasMatch(number))
      return 'Please enter a vailid Nigerian number';
    return null;
  }

  String? phoneNumberFullValidator(String? number,
      [bool allowEmpty = false, bool restrictToNigeria = true]) {
    number = number!.replaceAll(' ', '');
    if (number.isEmpty)
      return allowEmpty ? null : 'Please enter phone number';
    else if (!numberRegExp.hasMatch(number))
      return '* Phone number can only include numbers ';
    //  else if (number.length != 10) return '* Phone number must be 11 digits';
    // else if (!_phoneNumber.hasMatch(number))
    //   return '* Please enter a valid phone number';
    else if (!_nigerianNumberFull.hasMatch(number))
      return 'Please enter a vailid Nigerian number';
    return null;
  } 

  String? numberValidator(String number,
      {bool allowEmpty = false, String? text}) {
    if (number.isEmpty)
      return allowEmpty ? null : '* Please enter ${text ?? 'number'}';
    else if (!numberRegExp.hasMatch(number))
      return '* ${text ?? 'number'} can only include numbers ';
    else if (!_phoneNumber.hasMatch(number))
      return '* ${text ?? 'number'} must be between 9 and 12 numbers ';
    // else if (!_phoneNumber.hasMatch(number)) return 'Phone number can only include numbers and cannot be less than 11 characters';
    return null;
  }
 
}
