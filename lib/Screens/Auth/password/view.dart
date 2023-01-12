import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Commons/kf_keys.dart';
import 'package:movies/Screens/Auth/auth_provider.dart';
import 'package:movies/Screens/Auth/login/view.dart';
import 'package:movies/Screens/Auth/password/provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../../../Components/kf_text_field.dart';
import '../check_email/view.dart';

class PasswordPage extends StatelessWidget {
  PasswordPage({super.key});
  final passwordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return _buildPage(context);
  }

  Widget _buildPage(BuildContext context) {
    final provider = context.read<PasswordProvider>();
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
                onPressed: () => back(),
              ),
            ),
            body: SingleChildScrollView(
              child: Form(
                key: passwordFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Forgot password?',
                        style: boldTextStyle(size: 18, color: white),
                      ),
                    ),
                    15.height,
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Please enter your email address below and we will send you instructions to reset your password.',
                        style: primaryTextStyle(color: white),
                      ),
                    ),
                    15.height,
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
                    22.height,
                    ElevatedButton(
                        onPressed: () async {
                          auth.init();
                          if (passwordFormKey.currentState!.validate()) {
                            await auth.resetPassword(email: provider.email);
                            if (auth.error) {
                              EasyLoading.showError('Something went wrong.');
                            } else if (!auth.success) {
                              passwordFormKey.currentState!.validate();
                            } else {
                              auth.switchPage(const CheckEmailPage());
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1))),
                        child: Text(
                          "Submit",
                          style: boldTextStyle(color: Colors.black),
                        )).withSize(height: 50, width: double.infinity),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
