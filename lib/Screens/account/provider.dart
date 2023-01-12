import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';

class AccountProvider extends ChangeNotifier {
  bool get loggedIn => FirebaseAuth.instance.currentUser != null;
}
