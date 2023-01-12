import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Fragments/kf_error_screen_fragment.dart';
import 'package:movies/Components/kf_movie_detail_component.dart';
import 'package:movies/Components/kf_movie_information_builder.dart';
import 'package:movies/Fragments/kf_movie_not_found_fragment.dart';
import 'package:movies/Components/kf_sliver_app_bar_component.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';

import '../Utils/ad_helper.dart';

class KFMovieDetailScreen extends StatefulWidget {
  const KFMovieDetailScreen(
      {Key? key,
      required this.homeUrl,
      required this.type,
      this.year,
      required this.query})
      : super(key: key);
  final String homeUrl;
  final String query;
  final String type;
  final String? year;

  @override
  State<KFMovieDetailScreen> createState() => _KFMovieDetailScreenState();
}

class _KFMovieDetailScreenState extends State<KFMovieDetailScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController scrollController;
  late TabController tabController;

  late final String url = widget.homeUrl.startsWith('/')
      ? '$baseUrl${widget.homeUrl}'
      : widget.homeUrl;
  late final String query = widget.query;

  late final String? year = widget.year;

  String type = 'movie';

  int get id => kfmovieDetailSecondaryID;
  String get baseUrl => kfMoviesDetailBaseUrl;

  Future<void> _initializeDetails() async {
    final provider = context.read<KFProvider>();
    await Future.delayed(Duration.zero, () async {
      provider.initMovieDetails();
      provider.initializeMovieDetails(query: query, year: year, type: type);
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    scrollController = ScrollController();
    type = widget.type;

    tabController =
        TabController(length: _appbarInfoTabs().length, vsync: this);
    tabController.addListener(() => setState(() {}));

    await _initializeDetails();
    _createBannerAd();
    Future.delayed(
        Duration.zero, () => context.read<KFProvider>().initMovieDetails());
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    tabController.dispose();
  }

  BannerAd? _bannerAd;

  void _createBannerAd() {
    _bannerAd = BannerAd(
        size: AdSize.fullBanner,
        adUnitId: AdHelper.bannerAdUnitId,
        listener: AdHelper.bannerListener,
        request: const AdRequest())
      ..load();
  }

  @override
  Widget build(BuildContext context) {
    log("HOME URL: $url");

    return Consumer<KFProvider>(builder: (context, provider, child) {
      if (provider.didChangeType) {
        Future.delayed(
            Duration.zero,
            () => setState(
                  () {
                    type == 'movie' ? type = 'tv' : type = 'movie';
                  },
                ));
      }
      return provider.contentLoadError
          ? const KFErrorScreenComponent()
          : provider.notFound
              ? KFMovieNotFoundComponent(url: url)
              : Scaffold(
                   bottomNavigationBar: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        height: 52,
                          child: AdWidget(ad: _bannerAd!)),
                  backgroundColor: Colors.black,
                  body: FutureBuilder<bool>(
                      future: isNetworkAvailable(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data ?? false) {
                            return CustomScrollView(
                              controller: scrollController,
                              slivers: <Widget>[
                                _detailAppBar(),
                                KFMovieDetailComponent(
                                    isMovie: type == 'movie',
                                    homeUrl: url,
                                    year: year),
                                if (provider.tmdbSearchVideoLoaded)
                                  _informationAppBar(provider
                                      .kfTMDBSearchTVResultsById
                                      ?.numberOfEpisodes
                                      .toString()),
                                if (provider.tmdbSearchVideoLoaded)
                                  KFMovieInformationBuilder(
                                    isMovie: type == 'movie',
                                    controller: tabController,
                                    homeUrl: url,
                                  )
                              ],
                            );
                          }
                        }
                        return snapWidgetHelper(snapshot,
                            loadingWidget: const CircularProgressIndicator());
                      }));
    });
  }

  Widget _detailAppBar() => const KFSliverAppBarComponent(
        backgroundColor: Colors.black,
        pinned: true,
        snap: false,
        floating: true,
        expandedHeight: 50,
        elevation: 0.0,
        automaticallyImplyLeading: true,
      );

  Widget _informationAppBar(String? numberOfEpisodes) =>
      KFSliverAppBarComponent(
        backgroundColor: Colors.black,
        showTopMenu: false,
        automaticallyImplyLeading: false,
        pinned: true,
        actions: null,
        title: Column(
          children: [
            TabBar(
              isScrollable: true,
              labelStyle: boldTextStyle(),
              controller: tabController,
              padding: EdgeInsets.zero,
              indicatorColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: _appbarInfoTabs(numberOfEpisodes: numberOfEpisodes),
            ),
            Container(
              width: double.infinity,
              height: 1.5,
              color: Colors.white,
            )
          ],
        ),
      );

  List<Tab> _appbarInfoTabs({String? numberOfEpisodes}) => type == 'movie'
      ? const [
          Tab(
            text: "Related",
          ),
          Tab(
            text: "More Details",
          )
        ]
      : [
          Tab(
              text:
                  "Episodes ${numberOfEpisodes != null ? "($numberOfEpisodes)" : ""}"),
          const Tab(
            text: "Explore",
          ),
          const Tab(
            text: "More Details",
          )
        ];
}
