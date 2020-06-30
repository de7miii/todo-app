import 'package:email_validator/email_validator.dart';

String validateEmail(String email) => EmailValidator.validate(email) ? null : 'Invalid email address';

String validateName(String name) {
  if (name.isEmpty)
    return 'Invalid Name. Name Cannot be Empty';
  else
    return null;
}

String validatePassword(String password) {
  Pattern pattern = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(password))
    return 'Invalid Password, Password must contain one letter and one number.';
  else
    return null;
}

String validateConfirmationPassword(String password, String validationPassword){
  if (password != validationPassword)
    return 'Confirmation does not match password.';
  else
    return null;
}