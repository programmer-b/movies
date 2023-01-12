import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Components/kf_image_builder.dart';
import 'package:movies/Components/kf_movie_details_actions.dart';
import 'package:movies/Components/kf_title_builder.dart';
import 'package:movies/Models/kf_tmdb_search_model.dart';
import 'package:nb_utils/nb_utils.dart' hide log;

import 'kf_optional_details.dart';

class KFMovieDetailComponent extends StatefulWidget {
  const KFMovieDetailComponent(
      {super.key,
      required this.isMovie,
      required this.homeUrl,
      required this.year});
  final bool isMovie;
  final String homeUrl;
  final String? year;

  @override
  State<KFMovieDetailComponent> createState() => _KFMovieDetailComponentState();
}

class _KFMovieDetailComponentState extends State<KFMovieDetailComponent> {
  KFTMDBSearchModel? searchedTMDBData;
  late bool isMovie;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    // searchedTMDBData = context.read<KFProvider>().kfTMDBSearchResults;
    isMovie = widget.isMovie;
  }

  int get id => kfmovieDetailSecondaryID;
  String get homeUrl => widget.homeUrl;
  String? get year => widget.year;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) =>
              _delegates(isMovie)[index].paddingSymmetric(horizontal: 5),
          childCount: _delegates(isMovie).length),
    );
  }

  List<Widget> _delegates(bool isMovie) => [
        const KFImageBuilder(),
        const KFTitleBuilder(),
        KFMovieDetailActions(
          isMovie,
          homeUrl: homeUrl,
          year: year,
        ),
        const KFOptionalDetailsBar(),
      ];
}
