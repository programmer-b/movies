import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'kf_cast_and_crew_screen_build.dart';

class KFTVAndMovieExploreBuild extends StatelessWidget {
  const KFTVAndMovieExploreBuild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Cast & Crew",
            style: boldTextStyle(size: 17, color: Colors.white),
          ),
          3.height,
          Text(
            "Details From IMDb",
            style: boldTextStyle(size: 16, color: Colors.white60),
          ),
          const KFCastAndCrewScreenBuild()
        ],
      ),
    );
  }
}