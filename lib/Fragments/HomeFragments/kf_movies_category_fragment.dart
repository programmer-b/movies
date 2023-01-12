import 'package:flutter/material.dart';
import 'package:movies/Components/kf_movie_data_component.dart';
import 'package:movies/Components/kf_movie_header_component.dart';
import 'package:movies/Fragments/kf_header_carousel_fragment.dart';
import 'package:nb_utils/nb_utils.dart' hide log;

import '../../Commons/kf_strings.dart';

class KFMoviesCategoryFragment extends StatefulWidget {
  const KFMoviesCategoryFragment({Key? key}) : super(key: key);

  @override
  State<KFMoviesCategoryFragment> createState() =>
      _KFMoviesCategoryFragmentState();
}

class _KFMoviesCategoryFragmentState extends State<KFMoviesCategoryFragment> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Column(
            children: [
              if (index == 0) const KFHeaderCarouselFragment(isMovie: true),
              if (index == 0) const KFMovieHeaderComponent(isMovie: true),
              KFMovieDataComponent(index: index, isMovie: true)
            ],
          ).paddingSymmetric(horizontal: 7);
        },
        childCount: movies.length,
      ),
    );
  }
}
