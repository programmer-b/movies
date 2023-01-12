import 'package:flutter/material.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

import '../Commons/kf_functions.dart';

class KFTVSeasonSelectionScreenComponent extends StatelessWidget {
  const KFTVSeasonSelectionScreenComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<KFProvider>(builder: (context, value, child) {
      return WillPopScope(
        onWillPop: () async {
          value.switchSelectionMode();
          return false;
        },
        child: Container(
          width: getScreenContraints(context)["width"],
          height: getScreenContraints(context)["height"],
          color: const Color(0xbb000000),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 30,
              ),
              _seasonsList(value, context),
              Container(
                width: double.infinity,
                color: Colors.black,
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: FloatingActionButton(
                  onPressed: () => finish(context),
                  child: const Icon(
                    Icons.close_outlined,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  Widget _seasonsList(KFProvider value, BuildContext context) {
    int nOSeasons = value.numberOfSeasonsOfTheCurrentTVShow() ?? 0;
    return Expanded(
      child: ListView(
        reverse: true,
        children: [
          for (int i = 1; i <= nOSeasons; i++)
            TextButton(
                onPressed: () {
                  value.setCurrentSeason(i);
                  finish(context);
                },
                child: Text(
                  "Season $i",
                  style: TextStyle(
                      color: value.currentSeason == i
                          ? Colors.white
                          : Colors.white60,
                      fontSize: value.currentSeason == i ? 25 : 22),
                ))
        ],
      ),
    );
  }
}
