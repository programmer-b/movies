import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Components/kf_common_components.dart';
import 'package:movies/Components/kf_image_play.dart';
import 'package:movies/Components/kf_video_loading_component.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Commons/kf_functions.dart';

class KFEpisodesInfoList extends StatelessWidget {
  KFEpisodesInfoList(
      {Key? key, required this.homeUrl, required this.currentSeason})
      : super(key: key);
  final String homeUrl;
  final String currentSeason;

  @override
  Widget build(BuildContext context) {
    final contraints = getScreenContraints(context);
    double width = contraints.getWidth();

    return Consumer<KFProvider>(builder: (context, value, child) {
      return value.kfEpisodes != null
          ? _buildEpisodeInfo(width, value, context)
          : Column(
              children: [
                for (int i = 0; i < 5; i++) _episodeInfoPlaceHolder(width)
              ],
            );
    });
  }

  Widget _buildEpisodeInfo(
      double width, KFProvider value, BuildContext context) {
    String? imageUrl = "";
    dynamic runTime = 0;
    int episodeNumber = 0;
    String overview = "";

    final episodesList = value.kfEpisodes?.episodes ?? [];

    return Column(
      children: [
        for (int index = 0; index < episodesList.length; index++)
          GestureDetector(
            onTap: () => KFVideoLoadingComponent(
              homeUrl: homeUrl,
              currentSeason: currentSeason,
              episodeIndex: index,
              isMovie: false,
            ).launch(context),
            child: Builder(builder: (context) {
              imageUrl =
                  episodesList[index].stillPath ?? value.kfEpisodes?.posterPath;
              runTime =
                  episodesList[index].runtime ?? episodesList[index].name ?? 0;
              episodeNumber = episodesList[index].episodeNumber ?? 0;
              overview = episodesList[index].overview ?? "";

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            KFImagePlay(
                              width: width * 0.3,
                              height: 90,
                              path: imageUrl,
                            ),
                            12.width,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _titleBulder(index + 1, episodeNumber),
                                4.height,
                                _runTimeBuilder(runTime, width * 0.4)
                              ],
                            )
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              KFVideoLoadingComponent(
                                homeUrl: homeUrl,
                                currentSeason: currentSeason,
                                episodeIndex: index,
                                isMovie: false,
                                isDownloading: true,
                              ).launch(context);
                            },
                            icon: const Icon(
                              Icons.file_download_outlined,
                              color: Colors.white,
                              size: 30,
                            ))
                      ],
                    ),
                    6.height,
                    _descriptionBuilder(overview)
                  ],
                ),
              );
            }),
          ),
      ],
    );
  }

  Widget _imagePlaceHolder(double width) => FadeShimmer(
        height: 80,
        width: width * 0.3,
        fadeTheme: FadeTheme.dark,
      );

  Widget _titleBulder(int index, int episodeNumber) => Text(
        "$index.Episode $episodeNumber",
        style: boldTextStyle(size: 16, color: Colors.white),
      );
  Widget _titlePlaceHolder() => mediumTextShimmer();

  Widget _runTimeBuilder(dynamic runTime, double width) =>
      "$runTime".isNumeric()
          ? Text(
              "$runTime min",
              style: boldTextStyle(color: Colors.white60),
            )
          : SizedBox(
              height: 32,
              width: width,
              child: ReadMoreText(
                "$runTime",
                style: boldTextStyle(color: Colors.white60),
                trimLength: 20,
                trimCollapsedText: kfTrimCollapsedText,
              ),
            );
  Widget _runTimePlaceHolder() => smallTextShimmer();

  final List _smallTextShimmers = smallTextShimmers(8, height: 12);
  final List _mediumTextShimmers = mediumTextShimmers(6, height: 12);
  final List _largeTextShimmers = largeTextShimmers(3, height: 12);

  Widget _descriptionPlaceHolder() {
    List<Widget> descriptionnShimmers = [
      ..._smallTextShimmers,
      ..._mediumTextShimmers,
      ..._largeTextShimmers
    ];
    descriptionnShimmers.shuffle();

    return Wrap(
      spacing: 3,
      runSpacing: 3,
      children: descriptionnShimmers,
    );
  }

  Widget _descriptionBuilder(String overview) => ReadMoreText(
        trimCollapsedText: kfTrimCollapsedText,
        trimLength: 150,
        trimMode: TrimMode.Length,
        overview,
        style: primaryTextStyle(color: Colors.white60, size: 13),
      );

  Widget _episodeInfoPlaceHolder(double width) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _imagePlaceHolder(width),
                5.width,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _titlePlaceHolder(),
                    4.height,
                    _runTimePlaceHolder()
                  ],
                )
              ],
            ),
            6.height,
            _descriptionPlaceHolder()
          ],
        ),
      );
}
