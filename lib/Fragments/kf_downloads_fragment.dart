import 'dart:developer';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Commons/kf_functions.dart';
import 'package:movies/Components/kf_downloads_top_bar.dart';
import 'package:movies/Components/kf_empty_dowloads_page.dart';
import 'package:movies/Components/kf_movie_listener.dart';
import 'package:movies/Provider/flutter_downloader_provider.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';

import '../Commons/kf_keys.dart';
import '../main.dart';

class KFDownloadsFragment extends StatefulWidget {
  const KFDownloadsFragment({Key? key}) : super(key: key);

  @override
  State<KFDownloadsFragment> createState() => _KFDownloadsFragmentState();
}

class _KFDownloadsFragmentState extends State<KFDownloadsFragment> {
  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(_port.sendPort, keyDownloadReport);
    _port.listen((dynamic data) {
      context.read<FlutterDownloaderProvider>().updateData(data);
    });
    FlutterDownloader.registerCallback(MyApp.downloadCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const KFDownloadsTopBar(title: "Downloads", canPop: false),
        StreamBuilder(
            stream: fileStream(),
            builder: (context, snap) {
              log("snap: ${snap.data?.isEmpty}");

              if (snap.data?.isNotEmpty ?? false) {
                final data = snap.data ?? [];
                return ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (context, index) => 10.height,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) =>
                      KFMovieListener(fileSystemEntity: data[index]),
                ).expand();
              } else if (snap.data?.isEmpty ?? true && snap.ready) {
                return const KFEmptyDownloadsPage();
              }
              return Container();
            })
      ],
    );
  }
}
