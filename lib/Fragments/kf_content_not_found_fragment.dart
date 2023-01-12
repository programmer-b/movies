import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_colors.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Commons/kf_themes.dart';
import 'package:nb_utils/nb_utils.dart';

class KFContentNotFound extends StatefulWidget {
  const KFContentNotFound({super.key});

  @override
  State<KFContentNotFound> createState() => _KFContentNotFoundState();
}

class _KFContentNotFoundState extends State<KFContentNotFound> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Error occurred")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            kfContentRetreaveErrorMessage,
            style: boldTextStyle(color: kfPrimaryTextColor),
          ),
          8.height,
          ElevatedButton(
              style: kfButtonStyle(context),
              onPressed: () => finish(context),
              child: Text(
                "Okay",
                style: boldTextStyle(color: kfPrimaryTextColor),
                textAlign: TextAlign.center,
              )),
        ],
      ).center().paddingAll(8),
    );
  }
}
