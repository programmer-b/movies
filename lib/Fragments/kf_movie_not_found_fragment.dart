import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_colors.dart';
import 'package:nb_utils/nb_utils.dart' hide log;

import '../Commons/kf_strings.dart';
import '../Commons/kf_themes.dart';

class KFMovieNotFoundComponent extends StatefulWidget {
  const KFMovieNotFoundComponent({Key? key, required this.url})
      : super(key: key);
  final String url;

  @override
  State<KFMovieNotFoundComponent> createState() =>
      _KFMovieNotFoundComponentState();
}

class _KFMovieNotFoundComponentState extends State<KFMovieNotFoundComponent> {
  get kfPrimaryTextColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kfAppBarBgColor,
          title: const Text("Not found"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                kfContentNotFoundMessage,
                style: boldTextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              10.height,
              ElevatedButton(
                onPressed: () => finish(context),
                style: kfButtonStyle(context),
                child: Text(
                  "Okay",
                  style: boldTextStyle(color: Colors.black),
                ),
              )
            ],
          ).paddingSymmetric(horizontal: 15),
        ));
  }
}
