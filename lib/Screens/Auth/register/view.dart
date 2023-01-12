import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Screens/Auth/auth_provider.dart';
import 'package:movies/Screens/Auth/login/view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../Commons/kf_keys.dart';
import '../../../Commons/kf_strings.dart';
import '../../../Components/kf_divider.dart';
import '../../../Components/kf_text_field.dart';
import '../../kf_home_screen.dart';
import 'provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  final registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<RegisterProvider>();
    final providerWatch = context.watch<RegisterProvider>();

    final auth = context.read<AuthProvider>();

    back() => auth.switchPage(LoginPage());

    return WillPopScope(
      onWillPop: () async {
        back();
        return false;
      },
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        padding: const EdgeInsets.all(8),
        color: Colors.black,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              leading: BackButton(
                color: white,
                onPressed: () => auth.switchPage(LoginPage()),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: registerFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            style: boldTextStyle(color: white, size: 18),
                            'Register')),
                    32.height,
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
                      onChanged: (p0) =>
                          p0 == null ? null : provider.setPassword(p0),
                      prefixIcon: const Icon(Icons.password),
                      hintText: 'Password.',
                      obscureText: providerWatch.obscurePassword,
                      suffixIcon: IconButton(
                        onPressed: () => provider.setObscurePassword(),
                        icon: Icon(providerWatch.obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    12.height,
                    KFTextField(
                      validator: (p0) => p0 == null || p0 == ''
                          ? 'Confirm password is required.'
                          : keyConfirmPassword.authValidate(auth,
                              password: provider.password, confirmPassword: p0),
                      enableSuggestions: false,
                      textInputType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      onChanged: (p0) =>
                          p0 == null ? null : provider.setConfirmPassword(p0),
                      prefixIcon: const Icon(Icons.password),
                      hintText: 'Confirm password.',
                      obscureText: providerWatch.obscureConfirmPassword,
                      suffixIcon: IconButton(
                        onPressed: () => provider.setObscureConfirmPassword(),
                        icon: Icon(providerWatch.obscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off),
                      ),
                    ),
                    22.height,
                    ElevatedButton(
                        onPressed: () async {
                          auth.init();
                          if (registerFormKey.currentState!.validate()) {
                            await auth.createAccount(
                                emailAddress: provider.email.trim(),
                                password: provider.password.trim());
                            if (auth.error) {
                              EasyLoading.showError('Something went wrong.');
                            } else if (!auth.success) {
                              registerFormKey.currentState!.validate();
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
                          "Register",
                          style: boldTextStyle(color: Colors.black),
                        )).withSize(height: 50, width: double.infinity),
                    12.height,
                    const KFDivider(text: 'or'),
                    12.height,
                    ElevatedButton(
                        onPressed: () => back(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white30,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1))),
                        child: Text(
                          "Already have an account?",
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
                              "Sign up with with Google",
                              style: boldTextStyle(color: Colors.black),
                            ),
                          ],
                        )).withSize(height: 50, width: double.infinity),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
