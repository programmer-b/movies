import 'package:flutter/material.dart';
import 'package:movies/Models/kf_search_tv_by_id_model.dart';
import 'package:movies/Models/kf_tmdb_search_movie_by_id_model.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';

class KFMoreInfoBuild extends StatelessWidget {
  KFMoreInfoBuild({super.key, required this.isMovie});
  final bool isMovie;

  final List<String> _genres = [];
  final List<String> _productionCompanies = [];
  final List<String> _productionCountries = [];
  final List<String> _spokenLanguages = [];
  final List<String> _networks = [];

  @override
  Widget build(BuildContext context) {
    if (isMovie) {
      return Builder(
        builder: (context) {
          final KFTMDBSearchMovieByIdModel? data =
              context.watch<KFProvider>().kfTMDBSearchMovieResultsById;
          if (data != null) {
            for (var genre in data.genres ?? []) {
              _genres.add(genre.name);
            }

            final String? originalTitle = data.originalTitle ?? data.title;

            for (var company in data.productionCompanies ?? []) {
              _productionCompanies.add(company.name);
            }

            for (var country in data.productionCountries ?? []) {
              _productionCountries.add(country.name);
            }

            for (var language in data.spokenLanguages ?? []) {
              _spokenLanguages.add(language.englishName);
            }

            final double? popularity = data.popularity;
            final String? releaseDate = data.releaseDate;
            final int? budget = data.budget;
            final int? revenue = data.revenue;

            return Column(
              children: [
                if (_genres.isNotEmpty)
                  _tile(title: "Genres", subtitle: _genres.join(" , ")),
                if (originalTitle != null)
                  _tile(title: "Original Title", subtitle: originalTitle),
                if (_productionCompanies.isNotEmpty)
                  _tile(
                      title: "Production Companies",
                      subtitle: _productionCompanies.join(" , ")),
                if (_productionCountries.isNotEmpty)
                  _tile(
                      title: "Production Countries",
                      subtitle: _productionCountries.join(" , ")),
                if (_spokenLanguages.isNotEmpty)
                  _tile(
                      title: "Spoken Languages",
                      subtitle: _spokenLanguages.join(" , ")),
                if (popularity != null)
                  _tile(title: "Popularity", subtitle: popularity.toString()),
                if (releaseDate != null)
                  _tile(title: "Release Date", subtitle: releaseDate),
                if (budget != null && budget != 0)
                  _tile(title: "Budget", subtitle: "$budget"),
                if (revenue != null && revenue != 0)
                  _tile(title: "Revenue", subtitle: "$revenue")
              ],
            );
          }
          return Container();
        },
      ).paddingAll(5);
    } else {
      return Builder(
        builder: (context) {
          final KFTMDBSearchTvByIdModel? data =
              context.watch<KFProvider>().kfTMDBSearchTVResultsById;
          if (data != null) {
            for (var genre in data.genres ?? []) {
              _genres.add(genre.name);
            }

            final String? originalTitle = data.originalName ?? data.name;

            for (var company in data.productionCompanies ?? []) {
              _productionCompanies.add(company.name);
            }

            for (var country in data.productionCountries ?? []) {
              _productionCountries.add(country.name);
            }

            for (var language in data.spokenLanguages ?? []) {
              _spokenLanguages.add(language.englishName);
            }

            for (var network in data.networks ?? []) {
              _networks.add(network.name);
            }

            final double? popularity = data.popularity;
            final String? releaseDate = data.firstAirDate;

            return Column(
              children: [
                if (_genres.isNotEmpty)
                  _tile(title: "Genres", subtitle: _genres.join(" , ")),
                if (originalTitle != null)
                  _tile(title: "Original Title", subtitle: originalTitle),
                if (_productionCompanies.isNotEmpty)
                  _tile(
                      title: "Production Companies",
                      subtitle: _productionCompanies.join(" , ")),
                if (_productionCountries.isNotEmpty)
                  _tile(
                      title: "Production Countries",
                      subtitle: _productionCountries.join(" , ")),
                if (_spokenLanguages.isNotEmpty)
                  _tile(
                      title: "Spoken Languages",
                      subtitle: _spokenLanguages.join(" , ")),
                if (_networks.isNotEmpty)
                  _tile(title: "Networks", subtitle: _networks.join(" , ")),
                if (popularity != null)
                  _tile(title: "Popularity", subtitle: popularity.toString()),
                if (releaseDate != null)
                  _tile(title: "Release Date", subtitle: releaseDate),
              ],
            );
          }
          return Container();
        },
      ).paddingAll(5);
    }
  }

  Widget _divider() => Column(
        children: [
          3.height,
          const Divider(
            color: Colors.blueGrey,
          ),
          3.height
        ],
      );

  Widget _tile({required String title, required String subtitle}) => Column(
        children: [
          ListTile(
            style: ListTileStyle.list,
            title: Text(
              title,
              style: boldTextStyle(color: Colors.white),
            ),
            subtitle: Text(subtitle),
          ),
          _divider()
        ],
      );
}
