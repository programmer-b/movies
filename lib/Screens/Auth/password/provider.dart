import 'package:flutter/cupertino.dart';

class PasswordProvider extends ChangeNotifier {
  String _email = '';
  String get email => _email;

  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }
}
