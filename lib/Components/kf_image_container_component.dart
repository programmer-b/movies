import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_dimens.dart';
import 'package:movies/Screens/kf_movie_detail_screen.dart';
import 'package:movies/Utils/ad_helper.dart';
import 'package:nb_utils/nb_utils.dart' hide log;

import 'kf_common_components.dart';

class KFImageContainerComponent extends StatelessWidget {
  const KFImageContainerComponent(
      {Key? key,
      required this.urlImage,
      required this.homeUrl,
      this.trending = false,
      required this.type,
      required this.query,
      required this.year,
      this.customContraints,
      this.height,
      this.width})
      : assert(
            (customContraints == null && (width == null && height == null)) ||
                customContraints != null && (width != null && height != null)),
        super(key: key);

  final String urlImage;
  final String homeUrl;
  final String type;
  final String query;
  final String year;

  final bool? customContraints;
  final double? height;
  final double? width;

  final bool trending;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        showInterstitialAd(),
        KFMovieDetailScreen(
          homeUrl: homeUrl,
          query: query,
          year: year,
          type: type,
        ).launch(context),
        createInterstitialAd()
      },
      child: CachedNetworkImage(
        key: UniqueKey(),
        fadeInCurve: Curves.bounceIn,
        fadeInDuration: const Duration(microseconds: 50),
        imageUrl: urlImage,
        imageBuilder: (_, image) => Card(
          elevation: 5,
          child: Container(
            height: customContraints ?? false
                ? height
                : trending
                    ? trendingImageHeightDimen
                    : defaultGenreImageHeightDimen,
            width: customContraints ?? false
                ? width
                : trending
                    ? trendingImageWidthDimen
                    : defaultGenreImageWidthDimen,
            decoration: BoxDecoration(
                border: trending
                    ? null
                    : Border.all(
                        color: Colors.yellow,
                        width: 0.1,
                      ),
                image: DecorationImage(image: image, fit: BoxFit.fill),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
          ),
        ),
        placeholder: (context, url) => imagePlaceHolder(),
        errorWidget: (context, url, error) => imagePlaceHolder(),
      ),
    );
  }
}
