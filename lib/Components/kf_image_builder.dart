import 'package:cached_network_image/cached_network_image.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:provider/provider.dart';

class KFImageBuilder extends StatelessWidget {
  const KFImageBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * 0.3;

    return Consumer<KFProvider>(
        builder: (context, value, child) => value.tmdbSearchResultsLoaded
            ? CachedNetworkImage(
                key: UniqueKey(),
                imageUrl:
                    "$kfOriginalTMDBImageUrl${value.kfTMDBSearchResults?.results?[0].backdropPath ?? value.kfTMDBSearchResults?.results?[0].posterPath}",
                height: height,
                width: width,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover)),
                  );
                },
                placeholder: (context, url) => _imagePlaceHolder(width, height),
                errorWidget: (context, url, error) =>
                    _imagePlaceHolder(width, height),
              )
            : _imagePlaceHolder(width, height));
  }

  Widget _imagePlaceHolder(double width, double height) => FadeShimmer(
        width: width,
        height: height,
        fadeTheme: FadeTheme.dark,
        radius: 18,
      );
}
