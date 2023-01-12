import 'package:flutter/material.dart';
import 'package:movies/Components/kf_tv_season_selection_screen_component.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import 'kf_episode_info_list.dart';

class KFTVSeasonBuild extends StatelessWidget {
  const KFTVSeasonBuild({Key? key, required this.homeUrl}) : super(key: key);
  final String homeUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Consumer<KFProvider>(builder: (context, value, child) {
        int numberOfSeasons = value.numberOfSeasonsOfTheCurrentTVShow() ?? 0;
        return numberOfSeasons != 0
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (numberOfSeasons > 1) _seasonButtonBuild(value, context),
                  KFEpisodesInfoList(
                      currentSeason: "${value.currentSeason}",
                      homeUrl: homeUrl),
                ],
              )
            : Container();
      }),
    );
  }

  Widget _seasonButtonBuild(KFProvider value, BuildContext context) => Row(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white30),
              onPressed: () => showDialog(
                    context: context,
                    builder: (context) =>
                        const KFTVSeasonSelectionScreenComponent(),
                  ),
              child: Row(
                children: [
                  Text("Season ${value.currentSeason}"),
                  3.width,
                  const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.white,
                  )
                ],
              )),
        ],
      );
}
