import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Provider/kf_provider.dart';

class KFTitleBuilder extends StatelessWidget {
  const KFTitleBuilder({Key? key}) : super(key: key);

  get kfPrimaryTextColor => null;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Consumer<KFProvider>(
        builder: (context, value, child) => SizedBox(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                value.tmdbSearchResultsLoaded
                    ? Text(
                        value.kfTMDBSearchResults?.results?[0].name ??
                            value.kfTMDBSearchResults?.results?[0]
                                .originalName ??
                            value.kfTMDBSearchResults?.results?[0].title ??
                            value.kfTMDBSearchResults?.results?[0]
                                .originalTitle ??
                            "",
                        style: boldTextStyle(
                          color: Colors.white,
                          size: 28,
                        ),
                      )
                    : _titlePlaceHolder(width),
                4.height,
                if (value.tmdbSearchResultsLoaded) _buildSmallDetails(value)
              ],
            )).paddingSymmetric(vertical: 10, horizontal: 8));
  }

  Widget _titlePlaceHolder(double width) => FadeShimmer(
        radius: 8,
        width: width,
        height: 28,
        fadeTheme: FadeTheme.dark,
      );

  Widget _buildSmallDetails(KFProvider value) => Row(
        children: [
          RichText(
            text: TextSpan(
                text: value.kfTMDBSearchResults?.results?[0].firstAirDate ??
                    value.kfTMDBSearchResults?.results?[0].releaseDate ??
                    ""),
          ),
          8.width,
          if (value.tmdbSearchMoviesByIdLoaded ||
              value.tmdbSearchSeriesByIdLoaded)
            Builder(builder: (context) {
              bool isAdult = false;

              if (value.tmdbSearchMoviesByIdLoaded) {
                isAdult =
                    value.kfTMDBSearchMovieResultsById?.adult.toString() ==
                        "true";
              } else {
                isAdult =
                    value.kfTMDBSearchTVResultsById?.adult.toString() == "true";
              }
              return Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                      color: Colors.white30,
                      borderRadius: BorderRadius.all(Radius.circular(4))),
                  child: Text(
                    isAdult ? "18+" : "16+",
                    style: primaryTextStyle(size: 14, color: Colors.white),
                  ));
            }),
          8.width,
          RichText(
              text: TextSpan(children: [
            TextSpan(
                text: value.kfTMDBSearchMovieResultsById?.runtime == null
                    ? value.kfTMDBSearchTVResultsById == null
                        ? ""
                        : "${value.kfTMDBSearchTVResultsById?.numberOfSeasons} Season${value.kfTMDBSearchTVResultsById?.numberOfSeasons == 1 ? "" : "s"}"
                    : "${value.kfTMDBSearchMovieResultsById?.runtime} min"),
            TextSpan(
                text: value.kfOMDBSearchResults?.imdbRating == null
                    ? ""
                    : " : IMDb ${value.kfOMDBSearchResults?.imdbRating ?? ""}")
          ])),
        ],
      );
}
