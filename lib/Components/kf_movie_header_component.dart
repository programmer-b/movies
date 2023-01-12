import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_functions.dart';
import 'package:movies/Components/kf_common_components.dart';
import 'package:movies/Components/kf_horrizontal_image_list_builder_component.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Commons/kf_strings.dart';

class KFMovieHeaderComponent extends StatefulWidget {
  const KFMovieHeaderComponent({Key? key, required this.isMovie})
      : super(key: key);
  final bool isMovie;

  @override
  State<KFMovieHeaderComponent> createState() => _KFMovieHeaderComponentState();
}

class _KFMovieHeaderComponentState extends State<KFMovieHeaderComponent> {
  late Stream<String> _stream;
  @override
  void initState() {
    super.initState();

    _stream = fetchData(widget.isMovie
        ? trendingNowMovies[0]['id']
        : trendingNowSeries[0]['id']);
  }

  @override
  Widget build(BuildContext context) {
    final isMovie = widget.isMovie;
    final provider = Provider.of<KFProvider>(context);
    return StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != '') {
              final trendingUrls =
                  stractureData(snapshot.data ?? '', trending: true);
              return Column(
                children: [
                  genreTitleWidget(
                      isMovie
                          ? trendingNowMovies[0]['display_title']
                          : trendingNowSeries[0]['display_title'],
                      isMovie: false,
                      trending: true),
                  6.height,
                  KFHorrizontalImageListBuilderComponent(
                      args: trendingUrls,
                      trending: true,
                      type: isMovie ? 'movie' : 'tv')
                ],
              );
            }
          }
          if (snapshot.hasError) {
            log("setting error because snapshot has error: ${snapshot.error}");

            provider.setError(true);
          }
          return loadingWidget(trending: true);
        });
  }
}
