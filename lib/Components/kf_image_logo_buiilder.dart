import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Commons/kf_functions.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Models/kf_tmdb_images_model.dart';

class KFImageLogoBuilder extends StatefulWidget {
  const KFImageLogoBuilder(
      {super.key,
      required this.placeHolder,
      required this.id,
      required this.imageHeight,
      required this.type});
  final Widget placeHolder;
  final double imageHeight;
  final String type;
  final int id;

  @override
  State<KFImageLogoBuilder> createState() => _KFImageLogoBuilderState();
}

class _KFImageLogoBuilderState extends State<KFImageLogoBuilder> {
  late Future<Map<String, File>?> _tasks;
  late String imageKey = "${widget.id}";

  Future<Map<String, File>?> _getAllTasks() async {
    final bool logoExists = await _logoExists();
    if (logoExists) {
      final image = await _getLogofromCache();
      if (image != null) {
        return {"image": image};
      } else {
        return null;
      }
    } else {
      log("Logo not found in the cache.Downloading...");

      final KFTMDBImagesModel? images = await _getImagesData();
      if (images != null) {
        List<Logos> logos = images.logos ?? [];
        if (logos.isNotEmpty) {
          final String logoPath = logos[0].filePath ?? "";
          final logoUrl = "$kfOriginalTMDBImageUrl$logoPath";

          final image = await _downloadLogo(logoUrl);

          if (image != null) {
            log("Logo was successfully downloaded");
            return {"image": image};
          } else {
            log("Logo for this data was not found");
            return null;
          }
        } else {
          log("Logos were found to be empty");
          return null;
        }
      } else {
        return null;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _tasks = _getAllTasks();
  }

  get logoKey => "${widget.id}";

  Future<File?> _downloadLogo(String logoUrl) async {
    log("Downloading logo from $logoUrl");
    final info =
        await DefaultCacheManager().downloadFile(logoUrl, key: logoKey);
    return info.file;
  }

  Future<bool> _logoExists() async {
    log("Checking logo existence ...");
    return await DefaultCacheManager().getFileFromCache(logoKey) != null;
  }

  Future<File?> _getLogofromCache() async {
    log("Retreaving logo from cache");
    final info = await DefaultCacheManager().getFileFromCache(logoKey);
    if (info != null) {
      return info.file;
    } else {
      return null;
    }
  }

  Future<KFTMDBImagesModel?> _getImagesData() async {
    try {
      final results = await fetchDataFromInternet(
          kfTMDBSearchImagesUrl(type: widget.type, id: "${widget.id}"));
      log("RESULTS STATUS CODE: ${results.statusCode}");
      if (results.statusCode == 200) {
        final json = jsonDecode(results.body);

        final imagesModel = KFTMDBImagesModel.fromJson(json);

        return imagesModel;
      } else {
        return null;
      }
    } catch (e) {
      log("CATCH $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, File>?>(
      future: _tasks,
      builder: (context, snapshot) {
        if (snapshot.data != null && snapshot.ready) {
          final Map<String, File>? data = snapshot.data;
          if (data?.isNotEmpty ?? false) {
            final File? image = data?["image"];
            if (image != null) {
              return _logoImage(image);
            }
          }
        }
        return widget.placeHolder;
      },
    );
  }

  Widget _logoImage(File file) => Container(
        width: double.infinity,
        height: widget.imageHeight,
        alignment: Alignment.bottomLeft,
        decoration:
            BoxDecoration(image: DecorationImage(image: FileImage(file))),
      );
}
