import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:movies/Commons/kf_colors.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Components/kf_image_container_component.dart';
import 'package:movies/Components/kf_pagination_component.dart';
import 'package:movies/Database/kf_movie_database.dart';
import 'package:movies/Models/kf_movie_model.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:movies/Utils/kf_networking.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';

import '../Commons/kf_functions.dart';

class KFBrowserComponent extends StatefulWidget {
  const KFBrowserComponent({Key? key}) : super(key: key);

  @override
  State<KFBrowserComponent> createState() => _KFBrowserComponentState();
}

class _KFBrowserComponentState extends State<KFBrowserComponent> {
  String baseUrl = kfMoviesBaseUrl;
  String path = "-genre-Action";
  String page = "?p=";

  int _currentPage = 1;
  int get currentPage => _currentPage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final int _id = 53;
  int get id => _id;

  bool isMovie = true;
  Future<void> updateBaseUrl(value) async {
    await KFMovieDatabase.instance.delete(id);
    setState(() {
      isMovie = !isMovie;
      log("IS MOVIE: $isMovie");
      _currentPage = 1;
      baseUrl = value == 'Movies' ? kfMoviesBaseUrl : kfSeriesBaseUrl;
    });
    await _fetchAndStractureData('$baseUrl$path$page$_currentPage');
  }

  Future<void> updateGenere(String value) async {
    await KFMovieDatabase.instance.delete(id);
    for (int i = 0; i < genres.length; i++) {
      if (genres[i]['name'] == value) {
        setState(() {
          _currentPage = 1;
          path = genres[i]['path'] ?? "";
        });
        break;
      }
    }
    await _fetchAndStractureData('$baseUrl$path$page$currentPage');
  }

  Future<void> onPressedNextButton() async {
    await KFMovieDatabase.instance.delete(id);
    setState(() => _currentPage++);
    await _fetchAndStractureData('$baseUrl$path$page$currentPage');
  }

  Future<void> onPressedPrevButton() async {
    await KFMovieDatabase.instance.delete(id);
    setState(() => _currentPage--);
    await _fetchAndStractureData('$baseUrl$path$page$currentPage');
  }

  Future<void> _fetchAndStractureData(url) async {
    await 500.milliseconds.delay;
    setState(() => _isLoading = true);
    final data = await fetchMoviesAndSeries(url);
    setState(() => _isLoading = false);
    if (data == '') {
      await 1.seconds.delay;
      if (mounted) {
        log("setting error because failed to load $url");
        context.read<KFProvider>().setError(true);
      }
    }

    final moviesData = KFMovieModel(
        genreGeneratedMovieData: data,
        id: 53,
        tmdbID: 0,
        year: "null",
        backdropsPath: "null",
        posterPath: "null",
        releaseDate: "null",
        overview: "null",
        title: "null",
        homeUrl: "null");
    await KFMovieDatabase.instance.create(moviesData);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await KFMovieDatabase.instance.delete(id);
    _fetchAndStractureData(baseUrl + path);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        _header(width),
        8.height,
        SingleChildScrollView(
          child: StreamBuilder<String>(
              stream: fetchData(53),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data != '') {
                    final data = stractureData(snapshot.data ?? '',
                        stractureAllData: true);
                    final pgs = parse(snapshot.data)
                            .getElementById('pgs')
                            ?.getElementsByTagName('a') ??
                        [];
                    final hasNext = pgs.isNotEmpty
                        ? pgs[pgs.length - 1]
                            .firstChild
                            .toString()
                            .contains('Next')
                        : false;
                    log('LAST PAGE: $hasNext');
                    log('CURRENT PAGE: $currentPage');
                    return Wrap(
                      children: [
                        for (int i = 0; i < data.length; i++)
                          KFImageContainerComponent(
                            urlImage: 'https:${data[i]['imageUrl'] ?? ''}',
                            homeUrl: data[i]['homeUrl'] ?? '',
                            query: data[i]['query'] ?? '',
                            year: data[i]['year'] ?? '',
                            type: isMovie ? "movie" : "tv",
                            customContraints: true,
                            width: 90,
                            height: 140,
                          ),
                        KFPaginationComponent(
                          onPressedPrevButton: currentPage > 1
                              ? () => onPressedPrevButton()
                              : null,
                          onPressedNextButton:
                              hasNext ? () => onPressedNextButton() : null,
                          currentPage: currentPage,
                        )
                      ],
                    );
                  }
                }
                return _loadingWidget();
              }),
        )
      ],
    );
  }

  Widget _loadingWidget() => Center(
        child: Loader(
          valueColor: kfLoadingIndicatorValueColor,
        ),
      ).paddingSymmetric(vertical: 20);

  Widget _header(width) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_categoryDropdown(width), _genreDropdown(width)],
      ).paddingSymmetric(horizontal: 10);
  Widget _categoryDropdown(width) {
    List<String> showCategory = [];
    for (int i = 0; i < category.length; i++) {
      showCategory.insert(i, category[i]["name"] ?? "");
    }
    return SizedBox(
      width: width * (40 / 100),
      child: DropdownSearch<String>(
        popupProps: const PopupProps.menu(
          showSelectedItems: true,
        ),
        items: showCategory,
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Category",
          ),
        ),
        onChanged: (value) => updateBaseUrl(value),
        selectedItem: "Movies",
      ),
    );
  }

  Widget _genreDropdown(width) {
    List<String> showGenres = [];
    for (int i = 0; i < genres.length; i++) {
      showGenres.insert(i, genres[i]["name"] ?? "");
    }
    return SizedBox(
      width: width * (40 / 100),
      child: DropdownSearch<String>(
        popupProps: const PopupProps.menu(
          showSelectedItems: true,
        ),
        items: showGenres,
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: "Genre",
            hintText: "country in menu mode",
          ),
        ),
        onChanged: (value) => updateGenere(value ?? '-genre-Action'),
        selectedItem: "Action",
      ),
    );
  }
}
