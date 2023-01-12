import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Commons/kf_functions.dart';
import 'package:movies/Commons/kf_keys.dart';
import 'package:movies/Components/kf_downloaded_movie_cohot.dart';

class KFMovieListener extends StatefulWidget {
  const KFMovieListener({super.key, required this.fileSystemEntity});

  final FileSystemEntity fileSystemEntity;

  @override
  State<KFMovieListener> createState() => _KFMovieListenerState();
}

class _KFMovieListenerState extends State<KFMovieListener> {
  Future<Map<String, String>> get movieParams async {
    final String path = widget.fileSystemEntity.path;

    final String taskId = await readFileAsString("$path/$keyTaskId.txt");
    final String fileName = await readFileAsString("$path/$keyName.txt");
    final String type = await readFileAsString("$path/$keyType.txt");
    final String rootImageUrl =
        await readFileAsString("$path/$keyRootImageUrl.txt");

    return {
      keyTaskId: taskId,
      keyName: fileName,
      keyType: type,
      keyRootImageUrl: rootImageUrl
    };
  }

  late Future<Map<String, String>> params;

  @override
  void initState() {
    super.initState();
    params = movieParams;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
        future: params,
        builder: (context, snap) {
          if (snap.hasData && snap.ready) {
            final movieParams = snap.data ?? {};
            // log("MOVIE PARAMS: $movieParams");
            if (movieParams.isNotEmpty) {
              return KFDownLoadedMovieCohot(movieParams: movieParams);
            }
          }
          return Container();
        });
  }
}
