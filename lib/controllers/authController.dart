// ignore: file_names
import 'package:get/get.dart';
import '../resources/auth_methods.dart';

class AuthController extends GetxController {
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  // String get email => _email;
  // String get password => _password;
  // String get confirmpassword => _confirmPassword;
  set setEmail(setEmail) {
    _email = setEmail;
    // print(_email);
    // update();
  }

  set setPassword(setPassword) {
    _password = setPassword;
    // print(_password);
    // update();
  }

  set setConfirmPassword(setConfirmPassword) {
    _confirmPassword = setConfirmPassword;
    // print(_confirmPassword);
    // update();
  }

  Future<String> get signup async {
    if (_email.isEmpty) {
      return 'Enter Email';
    }
    if (_password.isEmpty) {
      return "Enter Password";
    }
    if (_password.length < 6) {
      return "min characters for password is 6";
    }
    if (_confirmPassword.isEmpty) {
      return "Enter Confirmation Password";
    }
    if (_password != _confirmPassword) {
      return "passwords did not match";
    }

    return await AuthMethods().signup(email: _email, password: _password);
  }

  Future<String> get login async {
    if (_email.isEmpty) {
      return 'Enter Email';
    }
    if (_password.isEmpty) {
      return "Enter Password";
    }

    return await AuthMethods().login(email: _email, password: _password);
  }

  Future<void> get signout async {
    await AuthMethods().signOut();
    // update();
  }
}
