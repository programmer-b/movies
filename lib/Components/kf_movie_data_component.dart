import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_functions.dart';
import 'package:movies/Components/kf_common_components.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Commons/kf_strings.dart';
import 'kf_horrizontal_image_list_builder_component.dart';

class KFMovieDataComponent extends StatefulWidget {
  const KFMovieDataComponent(
      {Key? key, required this.index, required this.isMovie})
      : super(key: key);

  final int index;
  final bool isMovie;

  @override
  State<KFMovieDataComponent> createState() => _KFMovieDataComponentState();
}

class _KFMovieDataComponentState extends State<KFMovieDataComponent> {
  late Stream<String> _stream;
  @override
  void initState() {
    super.initState();
    _stream = fetchData(widget.isMovie
        ? movies[widget.index]['id']
        : series[widget.index]['id']);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KFProvider>(context);
    return StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != '') {
              final args = stractureData(snapshot.data ?? '');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  genreTitleWidget(
                      widget.isMovie
                          ? movies[widget.index]['display_title']
                          : series[widget.index]['display_title'],
                      isMovie: widget.isMovie),
                  6.height,
                  KFHorrizontalImageListBuilderComponent(
                      args: args, type: widget.isMovie ? 'movie' : 'tv')
                ],
              );
            }
          }
          if (snapshot.hasError) {
            log("setting error because snapshot has error: ${snapshot.error}");
            provider.setError(true);
          }
          return loadingWidget();
        });
  }
}
