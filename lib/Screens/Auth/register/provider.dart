import 'package:flutter/material.dart';
import 'package:movies/Screens/Auth/auth_provider.dart';

class RegisterProvider extends ChangeNotifier {
  final AuthProvider? authProvider;

  RegisterProvider({this.authProvider});

  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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

  String get confirmPassword => _confirmPassword;

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  bool get obscurePassword => _obscurePassword;

  void setObscurePassword() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  bool get obscureConfirmPassword => _obscureConfirmPassword;

  void setObscureConfirmPassword() {
    _obscureConfirmPassword = !_obscureConfirmPassword;
    notifyListeners();
  }
}
