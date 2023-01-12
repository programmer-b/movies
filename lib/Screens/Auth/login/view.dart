import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Screens/Auth/auth_provider.dart';
import 'package:movies/Screens/Auth/loading.dart';
import 'package:movies/Screens/Auth/register/view.dart';
import 'package:movies/Screens/kf_home_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../../../Components/kf_divider.dart';
import '../../../Components/kf_text_field.dart';
import '../../../Commons/kf_keys.dart';
import '../password/view.dart';
import 'provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final loginForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<LoginProvider>();
    final providerWatch = context.watch<LoginProvider>();

    final auth = context.read<AuthProvider>();

    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      padding: const EdgeInsets.all(8),
      color: Colors.black,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            actions: [
              TextButton(
                  onPressed: () async => await showDialog(
                          context: context, builder: (_) => const AuthLoading())
                      .then((value) async => await setValue(keyAuthSkip, true)
                          .then(
                              (value) => const KFHomeScreen().launch(context))),
                  child: Text(
                    'skip'.toUpperCase(),
                    style: primaryTextStyle(color: white),
                  ))
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: loginForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                        style: boldTextStyle(size: 18, color: white), 'Login'),
                  ),
                  15.height,
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: TextButton(
                      child: Text(
                        "Forgot password? ",
                        style: primaryTextStyle(color: Colors.lightBlue),
                      ),
                      onPressed: () => auth.switchPage(PasswordPage()),
                    ),
                  ),
                  KFTextField(
                    validator: (p0) => p0 == null || p0 == ''
                        ? 'Email is required.'
                        : keyEmail.authValidate(auth),
                    onChanged: (p0) =>
                        p0 == null ? null : provider.setEmail(p0),
                    prefixIcon: const Icon(Icons.alternate_email),
                    hintText: 'Email.',
                    textInputType: TextInputType.emailAddress,
                  ),
                  12.height,
                  KFTextField(
                    validator: (p0) => p0 == null || p0 == ''
                        ? 'Password is required.'
                        : keyPassword.authValidate(auth),
                    enableSuggestions: false,
                    textInputType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (p0) =>
                        p0 == null ? null : provider.setPassword(p0),
                    prefixIcon: const Icon(Icons.password),
                    hintText: 'Password.',
                    obscureText: provider.obscureText,
                    suffixIcon: IconButton(
                      onPressed: () => provider.setShowPass(),
                      icon: Icon(providerWatch.obscureText
                          ? Icons.visibility
                          : Icons.visibility_off),
                    ),
                  ),
                  22.height,
                  ElevatedButton(
                      onPressed: () async {
                        auth.init();
                        if (loginForm.currentState!.validate()) {
                          await auth.signIn(
                              emailAddress: provider.email.trim(),
                              password: provider.password.trim());
                          if (auth.error) {
                            EasyLoading.showError('Something went wrong');
                          } else if (!auth.success) {
                            loginForm.currentState!.validate();
                          }
                          if (auth.success) {
                            if (auth.pLogin) {
                              const KFHomeScreen().launch(context);
                            }
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1))),
                      child: Text(
                        "Get started",
                        style: boldTextStyle(color: Colors.black),
                      )).withSize(height: 50, width: double.infinity),
                  12.height,
                  const KFDivider(text: 'or'),
                  12.height,
                  ElevatedButton(
                      onPressed: () => auth.switchPage(RegisterPage()),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white30,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1))),
                      child: Text(
                        "Create an account",
                        style: boldTextStyle(color: white),
                      )).withSize(height: 50, width: double.infinity),
                  12.height,
                  const KFDivider(text: 'or'),
                  12.height,
                  ElevatedButton(
                      onPressed: () async {
                        await auth.googleLogin();
                        if (auth.error) {
                          EasyLoading.showError('Something went wrong.');
                        }
                        if (auth.success) {
                          if (auth.pLogin) {
                            const KFHomeScreen().launch(context);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(1))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            kfGoogleIconImageAsset,
                            height: 30,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                          12.width,
                          Text(
                            "Continue with with Google",
                            style: boldTextStyle(color: Colors.black),
                          ),
                        ],
                      )).withSize(height: 50, width: double.infinity),
                ],
              ),
            ),
          )),
    );
  }
}
