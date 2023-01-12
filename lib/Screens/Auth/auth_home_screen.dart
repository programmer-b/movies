import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_keys.dart';
import 'package:movies/Screens/Auth/auth_provider.dart';
import 'package:movies/Screens/kf_home_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AuthHomeScreen extends StatefulWidget {
  const AuthHomeScreen({super.key, this.pLogin});
  final bool? pLogin;

  @override
  State<AuthHomeScreen> createState() => _AuthHomeScreenState();
}

class _AuthHomeScreenState extends State<AuthHomeScreen> {
  bool get authSkip => getBoolAsync(keyAuthSkip);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snap) {
            if (widget.pLogin ?? false) {
              provider.switchPage(provider.currentPage, pLogin: true);
              return provider.currentPage;
            } else {
              if (authSkip || snap.hasData) {
                WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                    const KFHomeScreen().launch(context, isNewTask: true));
              } else {
                return provider.currentPage;
              }
            }
            return _loadingWidget;
          });
    });
  }

  final Widget _loadingWidget = const Scaffold(
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );
}
