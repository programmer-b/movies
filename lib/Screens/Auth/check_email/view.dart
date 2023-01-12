import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/Screens/Auth/auth_provider.dart';
import 'package:movies/Screens/Auth/login/view.dart';
import 'package:movies/Screens/Auth/password/view.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'provider.dart';

class CheckEmailPage extends StatelessWidget {
  const CheckEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => CheckEmailProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final auth = context.read<AuthProvider>();

    Future<void> launchURL(url) async {
      if (!await launchUrl(Uri.parse(url))) {
        throw 'Could not launch $url';
      }
    }

    login() => auth.switchPage(LoginPage());
    back() => auth.switchPage(PasswordPage());
    launchMail() => launchURL("https://mail.google.com/mail/u/0/#inbox");

    return WillPopScope(
      onWillPop: () async {
        login();
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: BackButton(
              onPressed: () => login(),
            ),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      FontAwesomeIcons.envelopeOpenText,
                      size: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Check your email',
                    style: boldTextStyle(size: 26, color: white),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'We have sent a password recover instructions to your email.',
                    textAlign: TextAlign.center,
                    style: primaryTextStyle(size: 19, color: white),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () => launchMail(),
                    style: ElevatedButton.styleFrom(backgroundColor: white),
                    child: Text(
                      'Open email app',
                      style: boldTextStyle(color: Colors.black),
                    ),
                  ).withSize(width: 200, height: 50),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                    child: Text(
                      'Skip, I\'ll confirm later.',
                      style: boldTextStyle(color: Colors.lightBlue),
                    ),
                    onPressed: () => login(),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: SizedBox(
            height: MediaQuery.of(context).size.height * 0.18,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                    style: primaryTextStyle(size: 15, color: white),
                    'Did not receive email? Check your spam '),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'filter, or',
                      style: primaryTextStyle(color: white),
                    ),
                    TextButton(
                      child: Text(
                        'try another email address',
                        style: primaryTextStyle(color: Colors.lightBlue),
                      ),
                      onPressed: () => back(),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
