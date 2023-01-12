import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../Commons/kf_colors.dart';

class KFFileDownloader extends StatefulWidget {
  const KFFileDownloader(
      {super.key,
      required this.masterUrl,
      required this.path,
      required this.title});
  final String masterUrl;
  final String path;
  final String title;

  @override
  State<KFFileDownloader> createState() => _KFFileDownloaderState();
}

class _KFFileDownloaderState extends State<KFFileDownloader> {
  String get url => widget.masterUrl;
  String get path => widget.path;
  String get title => widget.title;

  String progressString = "";

  Future<void> _downloadFile() async {
    Dio dio = Dio();

    try {
      await dio.download(
        url,
        "$path/video.mp4",
        options: Options(
          followRedirects: true,
          maxRedirects: 100,
        ),
        onReceiveProgress: (count, total) => setState(() =>
            progressString = "${((count / total) * 100).toStringAsFixed(4)} %"),
      );
    } on Exception catch (e) {
      log("ERROR: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _downloadFile();
  }

  bool _downloadFinished = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: boldTextStyle(color: Colors.white, size: 21),
            textAlign: TextAlign.center,
          ),
          32.height,
          Text(
            'Downloading file ...',
            style: primaryTextStyle(color: Colors.white60),
          ),
          10.height,
          CircularPercentIndicator(
            animateFromLastPercent: true,
            radius: 80,
            onAnimationEnd: () => setState(() => _downloadFinished = true),
            // animation: true,
            percent: progressString.toDouble(),
            center: progressString == ""
                ? Text(
                    "Preparing",
                    style: primaryTextStyle(
                        color: Colors.white60, fontStyle: FontStyle.italic),
                  )
                : Text(
                    progressString,
                    style: primaryTextStyle(color: Colors.white),
                  ),
            progressColor: kfPrimaryTextColor,
          ),
          20.height,
          _downloadFinished
              ? Text(
                  'Your file has been downloaded. Press Okay to go back',
                  style: primaryTextStyle(color: Colors.white60),
                )
              : Text(
                  'Please do not close this screen until the file is downloaded.',
                  textAlign: TextAlign.center,
                  style: primaryTextStyle(color: Colors.white60),
                )
        ],
      ).center(),
    );
  }
}
