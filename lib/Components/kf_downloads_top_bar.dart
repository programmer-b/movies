import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Fragments/kf_search_fragment.dart';
import '../Screens/account/view.dart';

class KFDownloadsTopBar extends StatelessWidget {
  const KFDownloadsTopBar(
      {super.key, required this.title, required this.canPop});
  final String title;
  final bool canPop;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: canPop
          ? const BackButton(
              color: Colors.white,
            )
          : null,
      title: Text(
        title,
        style: boldTextStyle(color: Colors.white, size: 21),
      ),
      actions: [
        IconButton(
            onPressed: () => const KFSearchFragment().launch(context),
            icon: const Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            )),
        IconButton(
            onPressed: () => const AccountPage().launch(context),
            icon: const Icon(
              Icons.account_circle,
              color: Colors.white,
              size: 35,
            ))
      ],
    );
  }
}
