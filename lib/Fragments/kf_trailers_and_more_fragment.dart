import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:movies/Utils/ad_helper.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Screens/kf_movie_detail_screen.dart';

class KFTrailersAndMoreFragment extends StatefulWidget {
  const KFTrailersAndMoreFragment({Key? key}) : super(key: key);

  @override
  State<KFTrailersAndMoreFragment> createState() =>
      _KFTrailersAndMoreFragmentState();
}

class _KFTrailersAndMoreFragmentState extends State<KFTrailersAndMoreFragment> {
  padding() => const EdgeInsets.symmetric(vertical: 8, horizontal: 8);
  valid(Map<String, dynamic> data) => data.key == '' || data.key == null;

  _launchYoutube(key) =>
      launchUrl(Uri.parse("http://www.youtube.com/watch?v=$key"),
          mode: LaunchMode.externalApplication);

  _init() => WidgetsBinding.instance.addPostFrameCallback((timeStamp) => context
      .read<KFProvider>()
      .stracturePopularMoviesAndSeriesData(isTrailer: true));
  @override
  void initState() {
    _init();
    createBannerAd();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lData = context.watch<KFProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kToolbarHeight.floor().height,
        Container(
          padding: padding(),
          margin: const EdgeInsets.symmetric(horizontal: 8),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: Text(
            'Trending',
            style: boldTextStyle(color: Colors.black),
          ),
        ),
        lData.trailers.isEmpty
            ? Container(
                alignment: Alignment.center,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ).withSize(width: context.width(), height: 100)
            : ListView(
                padding: padding(),
                children: List<Widget>.generate(lData.trailers.length, (index) {
                  Map<String, dynamic> data = lData.trailers[index];
                  return valid(data)
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          padding: padding(),
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              border: Border.all(color: Colors.white38)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              6.height,
                              Text(
                                      style:
                                          boldTextStyle(color: white, size: 17),
                                      data.query.toString())
                                  .onTap(() => KFMovieDetailScreen(
                                        homeUrl: data.homeUrl,
                                        type: data.type,
                                        query: data.query,
                                        year: data.year,
                                      ).launch(context)),
                              6.height,
                              Row(
                                children: [
                                  TextFormField(
                                    readOnly: true,
                                    initialValue: data.key.toString(),
                                    style:
                                        primaryTextStyle(color: Colors.white60),
                                    decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white38))),
                                  ).withSize(
                                      width: context.width() * 0.50,
                                      height: 35),
                                  ElevatedButton.icon(
                                          onPressed: () => _launchYoutube(
                                              data.key.toString()),
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: white),
                                          icon: const Icon(
                                            FontAwesomeIcons.youtube,
                                            color: Colors.red,
                                          ),
                                          label: Text(
                                            'Play',
                                            style: boldTextStyle(
                                                color: Colors.black),
                                          ))
                                      .withSize(
                                          width: context.width() * 0.25,
                                          height: 37)
                                ],
                              ),
                              6.height,
                              Text(
                                  style: primaryTextStyle(
                                      color: Colors.white70, size: 15),
                                  data.releaseData.toString()),
                              6.height,
                              ReadMoreText(
                                data.overview.toString(),
                                style: primaryTextStyle(
                                    color: Colors.white60, size: 13),
                                trimLines: 3,
                                trimLength: 160,
                              ),
                              16.height
                            ],
                          ),
                        );
                }),
              ).expand(),
        Container(
                color: Colors.transparent,
                margin: const EdgeInsets.only(bottom: 12),
                height: 52,
                child: AdWidget(ad: bannerAd!))
            .visible(bannerAd != null),
      ],
    );
  }
}

extension _TrailerDetails on Map<String, dynamic> {
  get key => this['trailer'];
  get overview => this['overview'];
  get releaseData => this['release_date'];
  get type => this['type'];
  get homeUrl => this['homeUrl'];
  get query => this['query'];
  get year => this['year'];
}
