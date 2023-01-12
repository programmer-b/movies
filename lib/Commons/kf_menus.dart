import 'package:movies/Fragments/HomeFragments/kf_browse_category_fragment.dart';
import 'package:movies/Fragments/HomeFragments/kf_movies_category_fragment.dart';
import 'package:movies/Fragments/HomeFragments/kf_tv_shows_category_fragment.dart';

const List<Map<String, dynamic>> kfTopAppBarMenu = [
  {"name": "Movies", "widget": KFMoviesCategoryFragment()},
  {"name": "TV Shows", "widget": KFTvShowsCategoryFragment()},
  {"name": "Browse", "widget": KFBrowseCategoryFragment()}
];
