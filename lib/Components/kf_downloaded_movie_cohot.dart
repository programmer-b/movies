import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Components/kf_image_play.dart';
import 'package:movies/Provider/flutter_downloader_provider.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';

class KFDownLoadedMovieCohot extends StatefulWidget {
  const KFDownLoadedMovieCohot({super.key, required this.movieParams});
  final Map<String, String> movieParams;

  @override
  State<KFDownLoadedMovieCohot> createState() => _KFDownLoadedMovieCohotState();
}

class _KFDownLoadedMovieCohotState extends State<KFDownLoadedMovieCohot> {
  late Map<String, String> params = widget.movieParams;

  int? progress;
  DownloadTaskStatus? status;

  String get taskId => params.taskId;
  String get rootImageUrl => params.rootImageUrl;
  String get name => params.name;
  String get type => params.type;

  @override
  void initState() {
    super.initState();
    _setInitialConfigs();
  }

  Future<void> _setInitialConfigs() async {
    final List<DownloadTask> tasks =
        (await FlutterDownloader.loadTasks()) ?? [];

    if (tasks.isNotEmpty) {
      for (var task in tasks) {
        if (task.taskId == taskId) {
          WidgetsBinding.instance
              .addPostFrameCallback((timeStamp) => setState(() {
                    progress = task.progress;
                    status = task.status;
                  }));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = context.watch<FlutterDownloaderProvider>().data;

    log("TASK ID: $taskId");

    if (data != null) {
      if (data[0] == taskId) setState(() => progress = data[2]);
    }

    log("DATA: $data");
    return _movieTile();
  }

  Widget _cacheImage(BuildContext context) => KFImagePlay(
        width: context.width() * 0.3,
        height: 70,
        path: rootImageUrl,
      );

  Widget _fileText() => Text(
        name,
        style: boldTextStyle(size: 16, color: Colors.white),
      );

  Widget _trailing(BuildContext context) {
    if (status == DownloadTaskStatus.enqueued) {
      Text("Pending",
          style: primaryTextStyle(
              color: Colors.white60, fontStyle: FontStyle.italic));
    }
    if (status == DownloadTaskStatus.running) {
      Text("Downloading $progress",
          style: primaryTextStyle(
              color: Colors.white60, fontStyle: FontStyle.italic));
    }
    if (status == DownloadTaskStatus.complete) {
      return Text("Downloaded",
          style: primaryTextStyle(
              color: Colors.white60, fontStyle: FontStyle.italic));
    }

    if (status == DownloadTaskStatus.failed) {
      return Text("Failed",
          style: primaryTextStyle(
              color: Colors.white60, fontStyle: FontStyle.italic));
    }
    if (status == DownloadTaskStatus.paused) {
      return Text("Pauesd",
          style: primaryTextStyle(
              color: Colors.white60, fontStyle: FontStyle.italic));
    }
    if (status == DownloadTaskStatus.canceled) {
      return Text("Canceled",
          style: primaryTextStyle(
              color: Colors.white60, fontStyle: FontStyle.italic));
    }
    return Container();
  }

  Widget _movieTile() => Builder(builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [_cacheImage(context), 10.width, _fileText()],
            ),
            _trailing(context)
          ],
        ).paddingSymmetric(vertical: 10, horizontal: 8);
        // return ListTile(
        //   leading: _cacheImage(context),
        //   title: _fileText(),
        //   // trailing: _trailing(),
        // );
      });

  // Widget _tvTile() => Builder(builder: (context) {
  //       return ListTile();
  //     });
}
