import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Commons/kf_functions.dart';
import '../Screens/kf_video_player_screen.dart';
import 'kf_movie_results.dart';

class LoadMst extends StatefulWidget {
  const LoadMst(
      {super.key,
      required this.url,
      // this.supportMultipleWindows = true,
      required this.isDownloading,
      required this.title,
      required this.rootImageUrl,
      required this.type});

  final String url;
  // final bool supportMultipleWindows;
  final bool isDownloading;
  final String title;
  final String rootImageUrl;
  final String type;

  @override
  State<LoadMst> createState() => _LoadMstState();
}

class _LoadMstState extends State<LoadMst> {
  late String url = widget.url;
  late bool isDownloading = widget.isDownloading;
  late String title = widget.title;
  late String rootImageUrl = widget.rootImageUrl;
  late String type = widget.type;
  late Future<String?> aa;

  Future<String?> get _aa async {
    var grdurl = await getGrbdurl(url);
    if (grdurl != null) {
      var masterUrl = await getMasterurl(grdurl.grdurl);
      return masterUrl;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    aa = _aa;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: black,
        body: FutureBuilder(
            future: aa,
            builder: (context, snap) {
              if (snap.ready) {
                if (snap.data == null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text('Something went wrong. Please retry'),
                      ).paddingAll(8),
                      12.height,
                      ElevatedButton.icon(
                        onPressed: () {
                          finish(context);

                          ///todo: retry
                        },
                        icon: Icon(
                          Icons.refresh,
                          color: Colors.black54,
                        ),
                        label: Text(
                          'Retry',
                          style: boldTextStyle(color: black),
                        ),
                        style: ElevatedButton.styleFrom(backgroundColor: white),
                      )
                    ],
                  );
                } else {
                  final uri = snap.data;
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    if (isDownloading) {
                      finish(context);
                      KFMovieResults(
                        masterUrl: "$uri",
                        title: title,
                        isDownloading: isDownloading,
                      ).launch(context);
                    } else {
                      finish(context);
                      KFVideoPlayerScreen(
                        masterUrl: "$uri",
                      ).launch(context);
                    }
                  });
                }
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SpinKitFadingCircle(color: white),
                  ),
                  12.height,
                  Text('Just a moment ...'),
                ],
              );
            }));
  }
}
