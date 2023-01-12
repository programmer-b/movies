import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Database/kf_movie_database.dart';
import 'package:movies/Models/kf_movie_model.dart';
import 'package:movies/Models/kf_search_tv_by_id_model.dart';
import 'package:movies/Models/kf_tmdb_search_images_model.dart';
import 'package:movies/Models/kf_tmdb_search_model.dart';
import 'package:movies/Utils/kf_networking.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
// import 'package:path/path.dart';

import '../Commons/kf_functions.dart';
import '../Models/kf_omdb_search_model.dart';
import '../Models/kf_tmdb_search_movie_by_id_model.dart';
import '../Models/kf_tmdb_search_credits_model.dart';
import '../Models/kf_tmdb_search_videos_model.dart';
import '../Models/kf_tv_show_season_info_model.dart';

class KFProvider with ChangeNotifier {
  /// Here is a boolean value indicating when the app is loading
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// change loading state for the app
  void load() {
    _isLoading = true;
    notifyListeners();
  }

  /// A method to update the category in the home fragment
  int _selectedHomeCategory = 0;
  int get selectedHomeCategory => _selectedHomeCategory;

  void updateHomeCategory(index) {
    _selectedHomeCategory = index;
    notifyListeners();
  }

  bool _contentLoadError = false;
  bool get contentLoadError => _contentLoadError;

  Future<void> setError(error) async {
    await 500.milliseconds.delay;
    _contentLoadError = error;
    notifyListeners();
  }

  final List _downloadedMovieUrls = <String>[];
  List get downloadedMovieUrls => _downloadedMovieUrls;

  final List _downloadedTvUrls = <String>[];
  List get downloadedTvUrls => _downloadedTvUrls;

  bool _trailersLoaded = false;
  bool get trailersLoaded => _trailersLoaded;

  /// Future method that will fetch and
  /// stracture popular movies data, get their names in a List and
  /// then search them from the TMDB to get IDs
  /// We will then use this IDs to get the image backdrop
  /// of the particular  movie or tv show
  Future<void> stracturePopularMoviesAndSeriesData(
      {bool isTrailer = false}) async {
    if (isTrailer) {
      if (trailersLoaded) return;
      _trailersLoaded = true;
      notifyListeners();
    }
    final movies = await fetchMoviesAndSeries(kfPopularMoviesUrl);
    final series = await fetchMoviesAndSeries(kfPopularSeriesUrl);

    await _getPopularData(movies, type: 'movie', isTrailer: isTrailer);
    await _getPopularData(series, type: 'tv', isTrailer: isTrailer);
  }

  Future<void> _getPopularData(String data,
      {required String type, required bool isTrailer}) async {
    final document = parse(data);
    var dataCohot = document.getElementsByClassName('dflex')[1].children;

    for (var i = 0; isTrailer ? i < dataCohot.length : i < 10; i++) {
      log("$i");
      final dbValue = isTrailer
          ? null
          : await KFMovieDatabase.instance.readMovie(
              type == "movie" ? kfPopularMoviesIDs[i] : kfPopularSeriesIDs[i]);

      try {
        final query = dataCohot[i].getElementsByClassName('mtl')[0].innerHtml;
        final year = dataCohot[i].getElementsByClassName('hd hdy')[0].innerHtml;
        final homeUrl = dataCohot[i]
            .getElementsByTagName('a')[0]
            .attributes['href']
            .toString();

        final element = await fetchTheIDAndPosterFromTMDB(
            query: query, year: year, type: type, isTrailer: isTrailer);
        if (isTrailer) {
          ///fetch trailers diagonally [KFProvider]
          element.addAll({'homeUrl': homeUrl, 'query': query, 'year': year});
          trailers.add(element);

          notifyListeners();
          if (i == dataCohot.length - 1) {
            return;
          } else {
            continue;
          }
        }

        final movie = KFMovieModel(
            id: type == "movie" ? kfPopularMoviesIDs[i] : kfPopularSeriesIDs[i],
            genreGeneratedMovieData: '',
            tmdbID: element["id"] ?? 'null',
            year: year,
            backdropsPath: element["backdrop_path"],
            posterPath: element["poster_path"],
            overview: element["overview"],
            title: query,
            releaseDate: element["release_date"],
            homeUrl: homeUrl);

        element["id"] == null
            ? dbValue == null
                ? {
                    setError(true),
                    log(
                      "set error because $query failed to download",
                    )
                  }
                : null
            : dbValue == null
                ? await KFMovieDatabase.instance.create(movie)
                : await KFMovieDatabase.instance.update(movie);
      } catch (e) {
        if (dbValue == null) {
          setError(true);
          log("set error because popular $type at index $i failed to download",
              error: "ERROR $e");
        } else {
          continue;
        }
      }
    }
  }

  final List<Map<String, dynamic>> _trailers = [];
  List<Map<String, dynamic>> get trailers => _trailers;

  ///Here I will decrare a function that will initialize movie details
  ///It will take three parameters and out put various list models carrying
  ///information about the movie

  KFTMDBSearchModel? _kfTMDBsearchResults;
  KFTMDBSearchModel? get kfTMDBSearchResults => _kfTMDBsearchResults;

  KFOMDBSearchModel? _kfOMDBsearchResults;
  KFOMDBSearchModel? get kfOMDBSearchResults => _kfOMDBsearchResults;

  KFTMDBSearchMovieByIdModel? _kfTMDBSearchMovieResultsById;
  KFTMDBSearchMovieByIdModel? get kfTMDBSearchMovieResultsById =>
      _kfTMDBSearchMovieResultsById;

  KFTMDBSearchTvByIdModel? _kfTMDBSearchTVResultsById;
  KFTMDBSearchTvByIdModel? get kfTMDBSearchTVResultsById =>
      _kfTMDBSearchTVResultsById;

  KFTMDBSearchCreditsModel? _kfTMDBsearchCreditsResults;
  KFTMDBSearchCreditsModel? get kfTMDBsearchCreditsResults =>
      _kfTMDBsearchCreditsResults;

  final List<KFTMDBSearchImagesModel?> _kfTMDBSearchImagesResults = [];
  List<KFTMDBSearchImagesModel?> get kfTMDBSearchImagesResults =>
      _kfTMDBSearchImagesResults;

  KFTMDBSearchVideosModel? _kfTMDBsearchVideoResults;
  KFTMDBSearchVideosModel? get kfTMDBSearchVideoResults =>
      _kfTMDBsearchVideoResults;
  KFTVShowSeasonInfoModel? _kfEpisodes;
  KFTVShowSeasonInfoModel? get kfEpisodes => _kfEpisodes;

  bool _notFound = false;
  bool get notFound => _notFound;

  bool _tmdbSearchResultsLoaded = false;
  bool get tmdbSearchResultsLoaded => _tmdbSearchResultsLoaded;

  bool _tmdbSearchMoviesByIdLoaded = false;
  bool get tmdbSearchMoviesByIdLoaded => _tmdbSearchMoviesByIdLoaded;

  bool _tmdbSearchSeriesByIdLoaded = false;
  bool get tmdbSearchSeriesByIdLoaded => _tmdbSearchSeriesByIdLoaded;

  bool _tmdbSearchVideoLoaded = false;
  bool get tmdbSearchVideoLoaded => _tmdbSearchVideoLoaded;

  bool _omdbDataloaded = false;
  bool get omdbDataloaded => _omdbDataloaded;

  bool _didChangeType = false;
  bool get didChangeType => _didChangeType;

  void initMovieDetails() {
    log("initializing details");

    _kfTMDBsearchResults = null;
    _kfTMDBSearchMovieResultsById = null;
    _kfTMDBSearchTVResultsById = null;
    _kfTMDBsearchVideoResults = null;
    _kfOMDBsearchResults = null;
    _kfTMDBsearchCreditsResults = null;

    _tmdbSearchResultsLoaded = false;
    _notFound = false;
    _tmdbSearchMoviesByIdLoaded = false;
    _tmdbSearchSeriesByIdLoaded = false;
    _tmdbSearchVideoLoaded = false;
    _omdbDataloaded = false;
    _didChangeType = false;
    _seasonSelectionMode = false;

    _currentSeason = 1;

    notifyListeners();
  }

  Future<void> initializeMovieDetails(
      {required String query,
      required String? year,
      required String type}) async {
    log("searching for details...");

    final searchResults = await fetchTMDBSearchData(
      type: type,
      query: query,
      year: year,
    );

    if (searchResults == null) {
      log("SEARCH RESULTS IS NULL");
      _notFound = true;
    }
    _kfTMDBsearchResults = searchResults;
    _tmdbSearchResultsLoaded = true;

    notifyListeners();

    final int id = _kfTMDBsearchResults?.results?[0].id ?? 0;

    final isMovie = type == "movie";
    if (isMovie) {
      _kfTMDBSearchMovieResultsById =
          await fetchTMDBSearchMovieByIdData(id: "$id", type: type);
      if (_kfTMDBSearchMovieResultsById != null) {
        _tmdbSearchMoviesByIdLoaded = true;
        notifyListeners();
      } else {
        log("Movie by id data was found to be null");
      }
    } else {
      _kfTMDBSearchTVResultsById =
          await fetchTMDBSearchTvByIdData(id: "$id", type: type);
      await getEpisodes();
      if (_kfTMDBSearchTVResultsById != null) {
      } else {
        log("TV by id data was found to be null");
      }
      _tmdbSearchSeriesByIdLoaded = true;
      notifyListeners();
    }

    _kfTMDBsearchVideoResults =
        await fetchTMDBVideosData(id: "$id", type: type);
    if (_kfTMDBsearchVideoResults == null) {
      log("Video data was found to be null");
    }
    _tmdbSearchVideoLoaded = true;
    notifyListeners();

    _kfOMDBsearchResults =
        await fetchOMDBData(query: query, year: year, type: type);
    _omdbDataloaded = true;
    notifyListeners();

    _kfTMDBsearchCreditsResults =
        await fetchTMDBCreditdata(id: "$id", type: type);
    if (_kfTMDBsearchCreditsResults == null) {
      log("Credits not found");
    }
    notifyListeners();
  }

  Future<void> getEpisodes() async {
    final int id = kfTMDBSearchTVResultsById?.id ?? 0;

    if (id != 0) {
      _kfEpisodes = await fetchTVSeasonEpisodesInfo(
          id: "$id", currentSeason: "$_currentSeason");
    }
    notifyListeners();
  }

  int? _currentID;
  int? get currentID => _currentID;

  int? getCurrentID({required bool isMovie}) {
    _currentID = isMovie
        ? kfTMDBSearchMovieResultsById?.id
        : kfTMDBSearchTVResultsById?.id;
    return _currentID;
  }

  int? numberOfSeasonsOfTheCurrentTVShow() {
    return kfTMDBSearchTVResultsById?.numberOfSeasons;
  }

  //TV Shows seasons and episodes selection state management
  bool _seasonSelectionMode = false;
  bool get seasonSelectionMode => _seasonSelectionMode;

  void switchSelectionMode() {
    _seasonSelectionMode = !_seasonSelectionMode;
    notifyListeners();
  }

  int _currentSeason = 1;
  int get currentSeason => _currentSeason;

  void setCurrentSeason(int s) {
    _currentSeason = s;

    _kfEpisodes = null;

    notifyListeners();

    getEpisodes();
  }

  ///Here is video player configs and their state management

  Uri? _masterUrl;
  Uri? get masterUrl => _masterUrl;

  void initVideoConfigs() {
    _masterUrl = null;
    notifyListeners();
  }

  void masterUrlSet(Uri url) {
    _masterUrl = url;
    notifyListeners();
  }
}
