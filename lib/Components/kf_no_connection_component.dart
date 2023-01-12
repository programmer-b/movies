import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_colors.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Commons/kf_themes.dart';
import 'package:nb_utils/nb_utils.dart';

class KFNoConnectionComponent extends StatefulWidget {
  const KFNoConnectionComponent({Key? key}) : super(key: key);

  @override
  State<KFNoConnectionComponent> createState() =>
      _KFNoConnectionComponentState();
}

class _KFNoConnectionComponentState extends State<KFNoConnectionComponent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "No connection",
          style: boldTextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                kfNoInternetConnectionMessage,
                style: boldTextStyle(color: kfPrimaryTextColor),
              ),
              10.height,
              ElevatedButton(
                  onPressed: () => finish(context),
                  style: kfButtonStyle(context),
                  child:
                      Text("Okay", style: boldTextStyle(color: Colors.black)))
            ],
          ),
        ),
      ),
    );
  }
}
