import 'package:flutter/material.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class KFOptionalDetailsBar extends StatelessWidget {
  const KFOptionalDetailsBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<KFProvider>(
        builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Builder(
                  builder: (context) {
                    final originalCountriesList =
                        value.tmdbSearchMoviesByIdLoaded
                            ? value.kfTMDBSearchMovieResultsById
                                    ?.productionCountries ??
                                []
                            : value.kfTMDBSearchTVResultsById
                                    ?.productionCountries ??
                                [];
                    final originalCountry = originalCountriesList.isNotEmpty
                        ? value.tmdbSearchMoviesByIdLoaded
                            ? value.kfTMDBSearchMovieResultsById
                                    ?.productionCountries![0].name ??
                                ""
                            : value.kfTMDBSearchTVResultsById
                                    ?.productionCountries![0].name ??
                                ""
                        : "";
                    return value.omdbDataloaded && originalCountry != ""
                        ? Column(
                            children: [
                              Text(
                                "Country: $originalCountry",
                                style: boldTextStyle(color: Colors.white60),
                              ),
                              4.height,
                            ],
                          )
                        : Container();
                  },
                ),
                Builder(
                  builder: (context) {
                    final originalLanguage = value.tmdbSearchMoviesByIdLoaded
                        ? value.kfTMDBSearchMovieResultsById
                                ?.originalLanguage ??
                            ""
                        : value.kfTMDBSearchTVResultsById?.originalLanguage ??
                            "";
                    return value.omdbDataloaded && originalLanguage != ""
                        ? Text(
                            "Language: $originalLanguage",
                            style: boldTextStyle(color: Colors.white60),
                          )
                        : Container();
                  },
                )
              ],
            ).paddingSymmetric(horizontal: 8));
  }
}
