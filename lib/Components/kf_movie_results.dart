import 'dart:developer';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_awesome_bottom_sheet/flutter_awesome_bottom_sheet.dart';
import 'package:movies/Screens/kf_video_player_screen.dart';
import 'package:movies/Utils/kf_share.dart';
import 'package:nb_utils/nb_utils.dart' hide log;

class KFMovieResults extends StatefulWidget {
  const KFMovieResults(
      {super.key,
      required this.title,
      required this.masterUrl,
      required this.isDownloading});
  final String title;
  final String masterUrl;
  final bool isDownloading;

  @override
  State<KFMovieResults> createState() => _KFMovieResultsState();
}

class _KFMovieResultsState extends State<KFMovieResults> {
  final AwesomeBottomSheet _awesomeBottomSheet = AwesomeBottomSheet();

  Future<void> _launchDownLoadmanager() async {
    await 0.seconds.delay;
    String url = widget.masterUrl;
    String fileName = widget.title;

    try {
      final AndroidIntent intent = AndroidIntent(
        action: 'action_main',
        package: 'com.dv.adm',
        componentName: 'com.dv.adm.AEditor',
        arguments: <String, dynamic>{
          'android.intent.extra.TEXT': url,
          'com.android.extra.filename': "$fileName.mp4",
        },
      );
      await intent.launch();
    } on Exception catch (e) {
      log("Could not launch ADM", error: "$e");

      _awesomeBottomSheet.show(
        context: context,
        title: Text(
          "Install download manager",
          style: boldTextStyle(color: Colors.black),
        ),
        description: Text("To download this video, install download manager",
            style: primaryTextStyle(color: Colors.black54)),
        color: CustomSheetColor(
          mainColor: const Color.fromARGB(255, 253, 254, 255),
          accentColor: Colors.white38,
          iconColor: Colors.white,
        ),
        positive: AwesomeSheetAction(
          onPressed: () async {
            try {
              AndroidIntent intent = const AndroidIntent(
                action: 'action_view',
                data:
                    'https://play.google.com/store/apps/details?id=com.dv.adm',
              );
              await intent.launch();
            } on Exception catch (e) {
              toast("$e", gravity: ToastGravity.TOP, bgColor: Colors.red);
            }
          },
          title: 'INSTALL',
        ),
        negative: AwesomeSheetAction(
          onPressed: () {
            Navigator.of(context).pop();
          },
          title: 'CANCEL',
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isDownloading) {
      _launchDownLoadmanager();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              textAlign: TextAlign.center,
              style: boldTextStyle(
                color: Colors.white,
                size: 22,
              ),
              widget.title),
          10.height,
          Text(
              style: primaryTextStyle(
                color: Colors.white60,
              ),
              "Use the link below to download or watch from your download manager or browser."),
          10.height,
          TextFormField(
            readOnly: true,
            initialValue: widget.masterUrl,
            decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12))),
          ),
          20.height,
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: widget.masterUrl));
                toast("Url copied to clipboard");
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.copy,
                    color: Colors.black54,
                  ),
                  12.width,
                  Text(
                    "Copy Link",
                    style: boldTextStyle(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          8.height,
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () async {
                await KFShare.shareText(widget.masterUrl);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white30,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(1))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                  12.width,
                  Text(
                    "Share",
                    style: boldTextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          20.height,
          TextButton(
              onPressed: () => KFVideoPlayerScreen(masterUrl: widget.masterUrl)
                  .launch(context),
              child: Text(
                  style: primaryTextStyle(color: Colors.white54),
                  "Watch here instead?"))
        ],
      ).center().paddingAll(8),
    );
  }
}
