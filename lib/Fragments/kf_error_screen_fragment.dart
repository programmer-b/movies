import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_colors.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Commons/kf_themes.dart';

class KFErrorScreenComponent extends StatefulWidget {
  const KFErrorScreenComponent({Key? key}) : super(key: key);

  @override
  State<KFErrorScreenComponent> createState() => _KFErrorScreenComponentState();
}

class _KFErrorScreenComponentState extends State<KFErrorScreenComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            kfContentLoadingError,
            style: boldTextStyle(color: kfPrimaryTextColor),
          ),
          10.height,
          ElevatedButton(
            onPressed: () => RestartAppWidget.init(context),
            style: kfButtonStyle(context),
            child: Text(
              "Retry",
              style: boldTextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    ));
  }
}
