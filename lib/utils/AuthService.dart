import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  AuthService();

  var _loginStatus;
  var _signup;

  bool get signup => _signup ?? false;

  checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _loginStatus = prefs.getBool('loginStatus');
    notifyListeners();
  }

  bool getLoginStatus() {
    checkLoginStatus();
    return _loginStatus ?? false;
  }

  setSignupState(bool state) {
    _signup = state;
    notifyListeners();
  }

  setLoginStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loginStatus', status);
    _loginStatus = status;
    notifyListeners();
  }

  Future logIn() {
    setLoginStatus(true);
    setSignupState(false);
    return Future.value(_loginStatus);
  }

  Future signUp() {
    setLoginStatus(true);
    setSignupState(false);
    return Future.value(_loginStatus);
  }

  Future logOut() {
    setLoginStatus(false);
    setSignupState(false);
    return Future.value(_loginStatus);
  }
}
