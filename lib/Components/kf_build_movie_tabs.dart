import 'package:flutter/material.dart';
import 'package:movies/Components/kf_tv_and_movie_explore_build.dart';
import 'package:movies/Components/kf_tv_and_movie_more_info_build.dart';

class KFBuildMovieTabs extends StatelessWidget {
  const KFBuildMovieTabs(
      {Key? key, required this.controller, required this.isMovie})
      : super(key: key);
  final TabController controller;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    if (controller.index == 0) {
      return _relatedBuild();
    } else {
      return _moreInfoBuild();
    }
  }

  Widget _relatedBuild() => SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => const KFTVAndMovieExploreBuild(),
            childCount: 1),
      );
  Widget _moreInfoBuild() => SliverList(
        delegate: SliverChildBuilderDelegate(
            (context, index) => KFTVAndMovieMoreInfoBuild(isMovie: isMovie),
            childCount: 1),
      );
}
