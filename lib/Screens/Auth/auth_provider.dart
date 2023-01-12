import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies/Screens/Auth/login/view.dart';

class AuthProvider extends ChangeNotifier {
  String? _passwordError;
  String? get passwordError => _passwordError;

  String? _emailError;
  String? get emailError => _emailError;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _success = false;
  bool get success => _success;

  bool _error = false;
  bool get error => _error;

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount? get user => _user;

  load() => EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      dismissOnTap: false,
      status: 'Loading ...');
  dismiss() => EasyLoading.dismiss();

  void init() {
    _passwordError = null;
    _emailError = null;
    _errorMessage = null;
    _error = false;
    _success = false;
    notifyListeners();
  }

  Future googleLogin() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    load();
    await FirebaseAuth.instance.signInWithCredential(credential);
    _success = true;
    dismiss();
    notifyListeners();
  }

  void determineError(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        _emailError = 'Your email is invalid.';
        break;
      case 'user-disabled':
        _passwordError = 'Your user account has been disabled';
        break;
      case 'user-not-found':
        _emailError = 'Couldn\'t find your email account. Try registering.';
        break;
      case 'wrong-password':
        _passwordError =
            'Wrong password. Try again or click Forgot password \nto reset it.';
        break;
      case 'email-already-in-use':
        _emailError = 'This email already exists. Try logging in.';
        break;
      case 'account-exists-with-different-credential':
      case 'invalid-credential':
      case 'operation-not-allowed':
      case 'weak-password':
        _passwordError = 'This password is too weak';
        break;
      case 'ERROR_MISSING_GOOGLE_AUTH_TOKEN':
      default:
        _errorMessage = "$exception";
        _error = true;
        break;
    }
    notifyListeners();
  }

  Future<UserCredential?> createAccount(
      {required String emailAddress, required String password}) async {
    UserCredential? credential;

    load();
    try {
      credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
      _success = true;
      return credential;
    } on FirebaseAuthException catch (e) {
      determineError(e);
      return null;
    } finally {
      dismiss();
      notifyListeners();
    }
  }

  Future<UserCredential?> signIn(
      {required String emailAddress, required String password}) async {
    UserCredential? credential;

    load();
    try {
      credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      _success = true;
      return credential;
    } on FirebaseAuthException catch (e) {
      determineError(e);
      return null;
    } finally {
      dismiss();
      notifyListeners();
    }
  }

  Future resetPassword({required String email}) async {
    load();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _success = true;
    } on FirebaseAuthException catch (e) {
      determineError(e);
    } finally {
      dismiss();
      notifyListeners();
    }
  }

  bool _pLogin = false;
  bool get pLogin => _pLogin;

  Widget _currentPage = LoginPage();
  Widget get currentPage => _currentPage;

  void switchPage(Widget value, {bool pLogin = false}) {
    _pLogin = pLogin;
    _currentPage = value;
    notifyListeners();
  }
}
