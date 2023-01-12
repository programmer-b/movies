import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies/Screens/Auth/auth_provider.dart';

class LoginProvider extends ChangeNotifier {
  final AuthProvider? authProvider;

  LoginProvider({this.authProvider});

  late String _email = '';
  late String _password = '';
  late bool _obscureText = true;

  String get email => _email;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  String get password => _password;

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  bool get obscureText => _obscureText;

  void setShowPass() {
    log("$_obscureText");
    _obscureText = !_obscureText;
    notifyListeners();
  }
}
