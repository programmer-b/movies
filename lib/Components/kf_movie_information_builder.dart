import 'package:flutter/material.dart';
import 'package:movies/Components/kf_build_movie_tabs.dart';
import 'package:movies/Components/kf_build_tv_tabs.dart';

class KFMovieInformationBuilder extends StatefulWidget {
  const KFMovieInformationBuilder(
      {Key? key,
      required this.isMovie,
      required this.controller,
      required this.homeUrl})
      : super(key: key);
  final bool isMovie;
  final TabController controller;
  final String homeUrl;

  @override
  State<KFMovieInformationBuilder> createState() =>
      _KFMovieInformationBuilderState();
}

class _KFMovieInformationBuilderState extends State<KFMovieInformationBuilder> {
  late bool isMovie = widget.isMovie;
  late TabController controller = widget.controller;
  late ScrollController scrollController;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return isMovie
        ? KFBuildMovieTabs(controller: controller, isMovie: isMovie)
        : KFBuildTVTabs(
            controller: controller,
            isMovie: isMovie,
            homeUrl: widget.homeUrl,
          );
  }
}
