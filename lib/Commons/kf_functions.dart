import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Database/kf_movie_database.dart';
import 'package:movies/Models/kf_movie_model.dart';
import 'package:movies/Models/kf_tv_show_season_info_model.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:movies/Utils/kf_networking.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../Models/kf_omdb_search_model.dart';
import '../Models/kf_search_tv_by_id_model.dart';
import '../Models/kf_tmdb_search_movie_by_id_model.dart';
import '../Models/kf_tmdb_search_credits_model.dart';
import '../Models/kf_tmdb_search_images_model.dart';
import '../Models/kf_tmdb_search_model.dart';
import '../Models/kf_tmdb_search_videos_model.dart';
import 'kf_keys.dart';

Future<String> prepareFileDownloadPath({
  required String type,
  required String rootFileName,
  required String rootImageUrl,
  int? episodeIndex,
  String? episodeImageUrl,
}) async {
  if (type == 'tv' && (episodeIndex == null || episodeImageUrl == null)) {
    throw ArgumentError("Episode image or Episode index must not be null");
  }
  try {
    String rootPath = "";
    String episodePath = "";

    if (type == 'tv') {
      episodePath = "$rootFileName/episode$episodeIndex";
    }

    rootPath = rootFileName;

    final directoryRootPath = await localPath(path: rootPath);
    final directoryEpisodePath = await localPath(path: episodePath);

    await _storeString(
        path: "$directoryRootPath/$keyName.txt", value: rootFileName);

    await _storeString(path: "$directoryRootPath/$keyType.txt", value: type);

    await _storeString(
        path: "$directoryRootPath/$keyRootImageUrl.txt", value: rootImageUrl);

    if (type == 'tv') {
      await _storeString(
          path: "$directoryEpisodePath/$keyName.txt",
          value: "Episode $episodeIndex");
      await _storeString(
          path: "$directoryEpisodePath/$keyEpisodeImageUrl.txt",
          value: "Episode $episodeIndex");
      return directoryEpisodePath;
    }

    return directoryRootPath;
  } on Exception catch (_) {
    rethrow;
  }
}

Stream<List<FileSystemEntity>> fileStream(
    {Directory? yDir,
    bool changeCurrentPath = true,
    bool reverse = false,
    bool recursive = false,
    bool keepHidden = false}) async* {
  final directory = Directory(await localPath(path: ""));

  var dir = yDir ?? directory;
  var files = <FileSystemEntity>[];

  try {
    if (dir.listSync(recursive: recursive).isNotEmpty) {
      if (!keepHidden) {
        yield* dir.list(recursive: recursive).transform(
            StreamTransformer.fromHandlers(
                handleData: (FileSystemEntity data, sink) {
          files.add(data);
          sink.add(files);
        }));
      } else {
        yield* dir.list(recursive: recursive).transform(
            StreamTransformer.fromHandlers(
                handleData: (FileSystemEntity data, sink) {
          if (basename("$data").startsWith('.')) {
            files.add(data);
            sink.add(files);
          }
        }));
      }
    } else {
      yield [];
    }
  } on FileSystemException catch (e) {
    log("$e");
    yield [];
  }
}

Future<String?> downloadFile(
    {required String url,
    required String type,
    required String rootFileName,
    required rootImageUrl,
    int? episodeIndex,
    String? episodeImageUrl,
    int? seasonIndex}) async {
  String path = await prepareFileDownloadPath(
      type: type,
      rootFileName: rootFileName,
      rootImageUrl: rootImageUrl,
      episodeImageUrl: episodeImageUrl,
      episodeIndex: episodeIndex);
  if (type == 'tv') {
    if (episodeIndex == null ||
        seasonIndex == null ||
        episodeImageUrl == null) {
      throw ArgumentError("Argument error");
    }
  }

  final String? taskId = await FlutterDownloader.enqueue(
      url: url,
      savedDir: path,
      fileName: type == 'movie'
          ? rootFileName
          : "$rootFileName Season $seasonIndex Episode $episodeIndex");

  if (taskId != null) {
    await _storeString(path: "$path/$keyTaskId.txt", value: taskId);
    return taskId;
  }
  throw Exception("Failed to download");
}

// Future<String> getCustomPath(String type) async {
//   Directory rootDir = await getExternalStorageDirectory() ??
//       await getApplicationDocumentsDirectory();

//   String rootPath = rootDir.path;
//   String path = "$rootPath/$type";

//   return (await generateDir(path)).path;
// }

Future<Directory> generateDir(String path) async {
  if (await Directory(path).exists()) {
    return Directory(path);
  } else {
    final newDir = await Directory(path).create();
    return newDir;
  }
}

Future<String> localPath({required String path}) async {
  final Directory appDocDir = await getApplicationDocumentsDirectory();

  final Directory appDocDirFolder = path == ""
      ? Directory("${appDocDir.path}/$keyVideos")
      : Directory("${appDocDir.path}/$keyVideos/$path");

  if (await appDocDirFolder.exists()) {
    return appDocDirFolder.path;
  } else {
    final Directory appDocDirNewFolder =
        await appDocDirFolder.create(recursive: true);
    return appDocDirNewFolder.path;
  }
}

// Future<Uint8List> _downloadImage(String url) async {
//   final response = await http.get(Uri.parse(url));
//   final bytes = response.bodyBytes;
//   return bytes;
// }

// Future<File> _storeImage(List<int> bytes, {required String path}) async {
//   final file = File(path);
//   await file.writeAsBytes(bytes, flush: true);
//   return file;
// }

Future<File> _storeString({required String path, required String value}) async {
  final file = File(path);
  await file.writeAsString(value, flush: true);

  return file;
}

Future<String> readFileAsString(String path) async {
  final file = File(path);
  return await file.readAsString();
}

// Future<void> _deleteFile(String path) async {
//   bool exists = await directoryExists(filename: path);
//   if (exists) {
//     Directory(path).delete();
//   }
//   return;
// }

Future<bool> directoryExists({required String filename}) async {
  final pathName = await localPath(path: filename);

  bool fileExists = await File("$pathName/$filename").exists();
  bool exists = fileExists;
  return exists;
}

List<Map<String, String>> stractureData(
  String data, {
  bool stractureAllData = false,
  bool trending = false,
}) {
  final List<Map<String, String>> urls = [];

  final document = parse(data);

  final alldata =
      document.getElementsByClassName('dflex')[trending ? 0 : 1].children;

  for (int i = 0;
      stractureAllData || trending
          ? i < alldata.length
          : i < kfGenreHorizontalImages;
      i++) {
    final homeUrl = alldata[i].getElementsByTagName('a')[0].attributes['href'];
    final imageUrl =
        alldata[i].getElementsByTagName('img')[0].attributes['data-src'];
    final query = alldata[i].getElementsByClassName('mtl')[0].innerHtml;

    final yearElement = alldata[i].getElementsByClassName('hd hdy');
    final yearExists = yearElement.isNotEmpty;
    final year = yearExists ? yearElement[0].innerHtml : "";

    final map = {
      "imageUrl": imageUrl ?? '',
      "homeUrl": homeUrl ?? '',
      "year": year,
      "query": query
    };
    urls.insert(i, map);
  }

  return urls;
}

Stream<String> fetchData(int id) async* {
  final data = await KFMovieDatabase.instance.readMovie(id);
  yield data?.genreGeneratedMovieData ?? '';
}

Stream<KFMovieModel> fetchAllData(int id) async* {
  final data = await KFMovieDatabase.instance.readMovie(id);
  yield data ??
      const KFMovieModel(
          genreGeneratedMovieData: "null",
          tmdbID: 0,
          year: "null",
          backdropsPath: "null",
          posterPath: "null",
          releaseDate: "null",
          overview: "null",
          title: "null",
          homeUrl: "null");
}

Future<void> fetchDataAndStoreData(KFProvider provider) async {
  final moviesAndSeriesUrls = [
    ...trendingNowMovies,
    ...trendingNowSeries,
    ...movies,
    ...series,
  ];
  for (int i = 0; i < moviesAndSeriesUrls.length; i++) {
    final data = await fetchMoviesAndSeries(moviesAndSeriesUrls[i]['url']);
    final dbValue =
        await KFMovieDatabase.instance.readMovie(moviesAndSeriesUrls[i]['id']);
    if (data == '') {
      if (dbValue == null) {
        log("setting error because both local database and fetched data for ${moviesAndSeriesUrls[i]['url']} is null");
        provider.setError(true);
      } else {
        continue;
      }
    }

    final moviesData = KFMovieModel(
        id: moviesAndSeriesUrls[i]['id'],
        genreGeneratedMovieData: data,
        tmdbID: 0,
        year: "null",
        backdropsPath: "null",
        posterPath: "null",
        releaseDate: "null",
        overview: "null",
        title: "null",
        homeUrl: "null");

    data == ''
        ? dbValue == null
            ? {
                log("Setting error because: Failed: ${moviesAndSeriesUrls[i]['url']}"),
                provider.setError(true)
              }
            : null
        : dbValue == null
            ? await KFMovieDatabase.instance.create(moviesData)
            : await KFMovieDatabase.instance.update(moviesData);
  }
}

Future<Map<String, dynamic>> fetchTheIDAndPosterFromTMDB(
    {required String query,
    String year = '',
    required String type,
    required bool isTrailer}) async {
  try {
    Map<String, dynamic> dataMap = {"results": []};
    Response? data;

    num i = 0;

    while (dataMap["results"].isEmpty && i < 2) {
      final uri = Uri.parse(
          kfTMDBSearchMoviesORSeriesUrl(type: type, year: year, query: query));

      data = await http.get(uri);

      final List results = jsonDecode(data.body)["results"];
      if (results.isEmpty) {
        type == "movie" ? type = "tv" : type = "movie";
        i++;
      } else {
        dataMap["results"] = results;
      }
    }

    final rootObject = dataMap["results"][0];

    if (data?.statusCode == 200) {
      var id = rootObject["id"];

      KFTMDBSearchVideosModel? trailer;

      if (isTrailer) {
        trailer = await fetchTMDBVideosData(id: "$id", type: type);

        return {
          "id": id ?? 0,
          "type": type.toString(),
          "overview": rootObject["overview"].toString(),
          "release_date":
              rootObject["first_air_date"] ?? rootObject["release_date"],
          "trailer": trailer?.results?[0].key ?? ''
        };
      }

      String? backDropPath = rootObject["backdrop_path"];
      String? posterPath = rootObject["poster_path"];
      var overview = rootObject["overview"].toString();
      var releaseDate =
          rootObject["first_air_date"] ?? rootObject["release_date"];

      // /Precaching image so not to take too long at the home page

      final String imageUrl =
          "$kfOriginalTMDBImageUrl${backDropPath ?? posterPath}";
      String imageKey = basename(imageUrl);

      FileInfo? imageFile = await getImageFileFromCache(imageKey: imageKey);

      bool imageExists = imageFile != null;

      if (imageExists) {
      } else {
        DefaultCacheManager()
            .downloadFile(imageUrl, key: imageKey)
            .then((_) {});
      }

      return {
        "id": id ?? 0,
        "backdrop_path": backDropPath.toString(),
        "type": type.toString(),
        "poster_path": posterPath.toString(),
        "overview": overview,
        "release_date": releaseDate,
      };
    } else {
      log("failed to search for: $query because it got: $data");
      return {"id": null};
    }
  } catch (e) {
    log("failed to search for: $query because of $e");
    return {"id": null};
  }
}

Future<KFOMDBSearchModel?> fetchOMDBData(
    {required String query,
    required String? year,
    required String type}) async {
  final url =
      kfOMDBSearchMoviesOrSeriesUrl(query: query, year: year, type: type);
  final data = await fetchMoviesAndSeries(url);
  if (data != '') {
    return KFOMDBSearchModel.fromJson(jsonDecode(data));
  } else {
    return null;
  }
}

Future<KFTMDBSearchMovieByIdModel?> fetchTMDBSearchMovieByIdData(
    {required String id, String type = 'movie'}) async {
  final url = kfTMDBSearchByIdUrl(type: type, id: id);
  final data = await fetchMoviesAndSeries(url);
  if (data != '') {
    return KFTMDBSearchMovieByIdModel.fromJson(jsonDecode(data));
  } else {
    return null;
  }
}

Future<KFTMDBSearchTvByIdModel?> fetchTMDBSearchTvByIdData(
    {required String id, String type = 'tv'}) async {
  final url = kfTMDBSearchByIdUrl(type: type, id: id);
  final data = await fetchMoviesAndSeries(url);
  if (data != '') {
    return KFTMDBSearchTvByIdModel.fromJson(jsonDecode(data));
  } else {
    return null;
  }
}

Future<KFTMDBSearchCreditsModel?> fetchTMDBCreditdata(
    {required String id, required String type}) async {
  final url = kfTMDBSearchCreditsUrl(type: type, id: id);
  final data = await fetchMoviesAndSeries(url);
  if (data != '') {
    return KFTMDBSearchCreditsModel.fromJson(jsonDecode(data));
  } else {
    return null;
  }
}

Future<KFTMDBSearchImagesModel?> fetchTMDBImagesData(
    {required String id, required String type}) async {
  final url = kfTMDBSearchImagesUrl(id: id, type: type);
  final data = await fetchMoviesAndSeries(url);
  if (data != '') {
    return KFTMDBSearchImagesModel.fromJson(jsonDecode(data));
  } else {
    return null;
  }
}

Future<KFTMDBSearchVideosModel?> fetchTMDBVideosData(
    {required String id, required String type}) async {
  final url = kfTMDBSearchVideosUrl(id: id, type: type);
  final data = await fetchMoviesAndSeries(url);
  if (data != '') {
    return KFTMDBSearchVideosModel.fromJson(jsonDecode(data));
  } else {
    return null;
  }
}

Future<KFTMDBSearchModel?> fetchTMDBSearchData(
    {required String query,
    required String? year,
    required String type}) async {
  final url =
      kfTMDBSearchMoviesORSeriesUrl(type: type, year: year, query: query);
  log("SEARCHING FOR: $url");
  final data = await fetchMoviesAndSeries(url);
  if (data != '') {
    final json = jsonDecode(data);
    if (json['results'].isNotEmpty) {
      final results = KFTMDBSearchModel.fromJson(json);
      return results;
    } else {
      return null;
    }
  } else {
    return null;
  }

  ///Download images from TMDB
  ///using below function
}

Future<KFTVShowSeasonInfoModel?> fetchTVSeasonEpisodesInfo(
    {required String id, required String currentSeason}) async {
  final url = kfGetEpisodesUrl(id: id, currentSeason: currentSeason);
  log("SEARCHING FOR EPISODES: $url");
  final data = await fetchMoviesAndSeries(url);
  if (data != '') {
    final json = jsonDecode(data);
    final results = KFTVShowSeasonInfoModel.fromJson(json);
    return results;
  } else {
    return null;
  }

  ///Download images from TMDB
  ///using below function
}

// Future<String> localPath() async {
//   final directory = await getApplicationDocumentsDirectory();
//   return directory.path;
// }

// Future<File?> downloadImage({required String url}) async {
//   log("DOWNLOADING $url");
//   try {
//     final response = await http.get(Uri.parse(url));
//     final bytes = response.bodyBytes;
//     return _storeFiles(url, bytes);
//   } catch (exception) {
//     return null;
//   }
// }

// Future<File> _storeFiles(String url, List<int> bytes) async {
//   final filename = basename(url);
//   final dir = await getApplicationDocumentsDirectory();

//   final file = File('${dir.path}/$filename');
//   await file.writeAsBytes(bytes, flush: true);
//   return file;
// }

// String imageFileName({required String url}) {
//   String name = basename(url);
//   return name;
// }

// Future<File> getLocalImage({required String url}) async {
//   String filename = basename(url);
//   String dir = (await getApplicationDocumentsDirectory()).path;
//   File f = File('$dir/$filename');
//   return f;
// }

// Future<bool> directoryExists({required String url}) async {
//   String name = basename(url);
//   String path = await localPath();

//   bool fileExists = await File("$path/$name").exists();
//   bool exists = fileExists;
//   return exists;
// }

Map<String, double> getScreenContraints(context) {
  final double width = MediaQuery.of(context).size.width;
  final double height = MediaQuery.of(context).size.height;

  return {"height": height, "width": width};
}

Future<Response> fetchDataFromInternet(String url) async {
  try {
    final res = await http.get(Uri.parse(url));
    return res;
  } catch (e) {
    rethrow;
  }
}

Future<FileInfo?> getImageFileFromCache({required String imageKey}) async {
  FileInfo? imageFile = await DefaultCacheManager().getFileFromCache(imageKey);
  return imageFile;
}

// Future<String?> downloadFile(
//     {required String url, required String fileName}) async {
//   final status = await Permission.storage.request();

//   if (status.isGranted) {
//     final savedDir = await getCustomPath('movie');
//     return await FlutterDownloader.enqueue(
//         url: url, savedDir: savedDir, fileName: fileName);
//   } else {
//     return null;
//   }
// }

// Future<String> getCustomPath(String type) async {
//   Directory rootDir = (await getDownloadsDirectory())!;

//   String rootPath = rootDir.path;
//   String path = "$rootPath/$type";

//   return (await generateDir(path)).path;
// }

// Future<Directory> generateDir(String path) async {
//   if (await Directory(path).exists()) {
//     return Directory(path);
//   } else {
//     final newDir = await Directory(path).create();
//     return newDir;
//   }
// }
Future<String?> getGrbdurl(String url) async {
  var body = 'qdf=1';
  var headers = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Cookie': grdcookie
  };

  var response = await http.post(Uri.parse(url), body: body, headers: headers);

  if (response.ok) {
    // Successful POST request
    var data = response.body;
    // log('DATA ${data}');
    log(data.grdurl);
    return data;
  } else {
    // POST request failed
    log('Request failed with status: ${response.statusCode}');
  }
  return null;
}

Future<String?> getMasterurl(String url) async {
  var headers = {
    'Cookie': grdcookie,
  };
  var response = await http.get(Uri.parse(url), headers: headers);
  log('RESPONSE ${response.body}');

  if (response.ok) {
    return response.body;
  } else {
    log('request failed with status code: ${response.statusCode}');
  }
  return null;
}
