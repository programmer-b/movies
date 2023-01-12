class KFMovieModel {
  final int? id;
  final String? genreGeneratedMovieData;
  final int? tmdbID;
  final String? year;
  final String? backdropsPath;
  final String? posterPath;
  final String? releaseDate;
  final String? overview;
  final String? title;
  final String? homeUrl;

  const KFMovieModel({
    this.id,
    required this.genreGeneratedMovieData,
    required this.tmdbID,
    required this.year,
    required this.backdropsPath,
    required this.posterPath,
    required this.releaseDate,
    required this.overview,
    required this.title,
    required this.homeUrl
  });

  KFMovieModel copy(
          {int? id,
          String? genreGeneratedMovieData,
          int? tmdbID,
          String? year,
          String? backdropsPath,
          String? posterPath,
          String? releaseDate,
          String? overview,
          String? title,
          String? homeUrl}) =>
      KFMovieModel(
          id: id ?? this.id,
          genreGeneratedMovieData:
              genreGeneratedMovieData ?? this.genreGeneratedMovieData,
          tmdbID: tmdbID ?? this.tmdbID,
          year: year ?? this.year,
          backdropsPath: backdropsPath ?? this.backdropsPath,
          posterPath: posterPath ?? this.posterPath,
          releaseDate: releaseDate ?? this.releaseDate,
          overview: overview ?? this.overview,
          title: title ?? this.title,
          homeUrl: homeUrl ?? this.homeUrl,
          );

  static KFMovieModel fromJson(Map<String, Object?> json) => KFMovieModel(
        id: json[MovieFields.id] as int?,
        genreGeneratedMovieData:
            json[MovieFields.genreGeneratedMovieData] as String,
        tmdbID: json[MovieFields.tmdbID] as int,
        year: json[MovieFields.year] as String,
        backdropsPath: json[MovieFields.backdropsPath] as String,
        posterPath: json[MovieFields.posterPath] as String,
        releaseDate: json[MovieFields.releaseDate] as String,
        overview: json[MovieFields.overview] as String,
        title: json[MovieFields.title] as String, homeUrl: json[MovieFields.homeUrl] as String,
      );

  Map<String, Object?> toJson() => {
        MovieFields.id: id,
        MovieFields.genreGeneratedMovieData: genreGeneratedMovieData,
        MovieFields.tmdbID: tmdbID,
        MovieFields.year: year,
        MovieFields.backdropsPath: backdropsPath,
        MovieFields.posterPath: posterPath,
        MovieFields.releaseDate: releaseDate,
        MovieFields.overview: overview,
        MovieFields.title: title,
        MovieFields.homeUrl: homeUrl,
      };
}

class MovieFields {
  static final List<String> values = [
    id,
    genreGeneratedMovieData,
    tmdbID,
    year,
    backdropsPath,
    posterPath,
    releaseDate,
    overview,
    title,
    homeUrl
  ];

  static const String id = '_id';
  static const String genreGeneratedMovieData = 'genreGeneratedMovieData';
  static const String tmdbID = 'tmdbID';
  static const String year = 'year';
  static const String backdropsPath = 'backdropsPath';
  static const String posterPath = 'posterPath';
  static const String releaseDate = 'releaseDate';
  static const String overview = 'overview';
  static const String title = 'title';
  static const String homeUrl = 'homeUrl';
}

const String tableMovies = 'movies';
