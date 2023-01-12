import 'package:flutter/material.dart';
import 'package:movies/Utils/ad_helper.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Fragments/kf_cast_information_fragment.dart';
import '../Models/kf_tmdb_search_credits_model.dart';
import '../Provider/kf_provider.dart';
import 'kf_cast_image_component.dart';

class KFCastAndCrewScreenBuild extends StatelessWidget {
  const KFCastAndCrewScreenBuild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
      ),
      child: Consumer<KFProvider>(builder: (context, value, child) {
        var credits = context.watch<KFProvider>().kfTMDBsearchCreditsResults;
        final List<Cast> casts = credits?.cast ?? [];

        if (value.kfTMDBsearchCreditsResults?.cast?.isNotEmpty ?? false) {
          return Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              for (var cast in casts)
                KFCastImageComponent(
                  profilePath: cast.profilePath,
                  name: cast.name ?? cast.originalName,
                  onTap: () => {
                    showInterstitialAd(),
                    KFCastInfoFragment(id: cast.id ?? 0).launch(context),
                    createInterstitialAd()
                  },
                )
            ],
          );
        }
        return Wrap(
          spacing: 5,
          runSpacing: 5,
          children: List<Widget>.generate(
            10,
            (index) => const KFCastImageComponent(
              profilePath: null,
              name: null,
            ),
          ),
        );
      }),
    );
  }
}
