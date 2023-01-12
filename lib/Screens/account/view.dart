import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_bottom_sheet/flutter_awesome_bottom_sheet.dart';
import 'package:movies/Screens/Auth/auth_home_screen.dart';
import 'package:movies/Screens/account/watch_list.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'provider.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AccountProvider(),
      builder: (context, child) => _buildPage(context),
    );
  }

  Widget _buildPage(BuildContext context) {
    final AwesomeBottomSheet awesomeBottomSheet = AwesomeBottomSheet();

    final provider = context.read<AccountProvider>();
    if (!provider.loggedIn) {
      WidgetsBinding.instance
          .addPostFrameCallback((timeStamp) => const AuthHomeScreen(
                pLogin: true,
              ).launch(context));
    }
    final String? email = FirebaseAuth.instance.currentUser?.email;
    final String? name = FirebaseAuth.instance.currentUser?.displayName;
    final String? photoUrl = FirebaseAuth.instance.currentUser?.photoURL;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          photoUrl == null
              ? const Icon(
                  Icons.account_circle,
                  size: 100,
                  color: Colors.white38,
                )
              : Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              CachedNetworkImageProvider(photoUrl.toString()))),
                ),
          name != null || name != ''
              ? Column(
                  children: [
                    Text(
                      name ?? '',
                      style: boldTextStyle(color: white),
                    ),
                    8.height
                  ],
                )
              : Container(),
          8.height,
          Text(
            email ?? '',
            style: boldTextStyle(color: white),
          ),
          56.height,
          ListTile(
            leading: const Icon(Icons.list_outlined),
            title: Text(
              'My Watch list',
              style: boldTextStyle(color: white),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => const KFWatchList().launch(context),
          ),
          ListTile(
            leading: const Icon(Icons.logout_outlined),
            title: Text(
              'Logout',
              style: boldTextStyle(color: white),
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () async {
              awesomeBottomSheet.show(
                context: context,
                title: Text(
                  "Logout",
                  style: boldTextStyle(color: Colors.black),
                ),
                description: Text("Are you sure yo wanna do this?",
                    style: primaryTextStyle(color: Colors.black54)),
                color: CustomSheetColor(
                  mainColor: const Color.fromARGB(255, 253, 254, 255),
                  accentColor: Colors.white38,
                  iconColor: Colors.white,
                ),
                positive: AwesomeSheetAction(
                  onPressed: () async => await FirebaseAuth.instance
                      .signOut()
                      .then((value) async =>
                          await SharedPreferences.getInstance().then(
                              (value) async => await value.clear().then(
                                  (value) => RestartAppWidget.init(context)))),
                  title: 'LOGOUT',
                ),
                negative: AwesomeSheetAction(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  title: 'CANCEL',
                ),
              );
            },
          )
        ],
      ).center().paddingAll(8),
    );
  }
}
