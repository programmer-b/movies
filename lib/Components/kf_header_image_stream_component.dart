import 'dart:io';

import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_colors.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Commons/kf_functions.dart';
import 'package:movies/Screens/kf_movie_detail_screen.dart';
import 'package:movies/Utils/ad_helper.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:path/path.dart';

import '../Commons/kf_strings.dart';

class KFHeaderImageStreamComponent extends StatelessWidget {
  const KFHeaderImageStreamComponent({
    super.key,
    required this.index,
    required this.isMovie,
  });

  final int index;
  final bool isMovie;

  @override
  Widget build(BuildContext context) {
    final imageIndex =
        isMovie ? kfPopularMoviesIDs[index] : kfPopularSeriesIDs[index];
    final double height = getScreenContraints(context).height * 0.30;

    return StreamBuilder(
        stream: fetchAllData(imageIndex),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final posterImageUrl =
                snapshot.data?.backdropsPath ?? snapshot.data?.posterPath;
            final title = snapshot.data?.title ?? "";
            final year = snapshot.data?.year ?? "";
            final type = isMovie ? "movie" : "tv";

            final homeUrl = snapshot.data?.homeUrl ?? "";

            if (posterImageUrl != "null") {
              final url = '$kfOriginalTMDBImageUrl$posterImageUrl';
              final imageKey = basename(url);

              return GestureDetector(
                onTap: () => {
                  showInterstitialAd(),
                  KFMovieDetailScreen(
                    homeUrl: homeUrl,
                    type: type,
                    query: title,
                    year: year,
                  ).launch(context),
                  createInterstitialAd()
                },
                child: Stack(
                  children: [
                    FutureBuilder(
                      future: getImageFileFromCache(imageKey: imageKey),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.connectionState == ConnectionState.done) {
                          final File? file = snapshot.data?.file;
                          if (file != null) {
                            return Container(
                                width: double.infinity,
                                height: height,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(file),
                                        fit: BoxFit.cover),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8))));
                          }
                        }
                        return FadeShimmer(
                          width: height * 16 / 9,
                          height: height,
                          baseColor: Colors.black,
                          highlightColor: Colors.black12,
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _placeHolder(title),
                    )
                  ],
                ),
              );
            }
          }
          return FadeShimmer(
            width: height * 16 / 9,
            height: height,
            baseColor: Colors.black,
            highlightColor: Colors.black12,
          );
        });
  }

  Widget _placeHolder(String title) => Center(
        child: Container(
            color: kfAppBarBgColor,
            width: double.infinity,
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            child: Text(
              title,
              style: boldTextStyle(
                color: kfPrimaryTextColor,
              ),
            )),
      );
}
