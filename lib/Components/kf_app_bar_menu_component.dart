import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_menus.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:movies/Utils/ad_helper.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class KFAppBarMenuComponent extends StatelessWidget {
  const KFAppBarMenuComponent({super.key, this.controller});

  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return Consumer<KFProvider>(builder: (context, provider, child) {
      final selectedIndex = provider.selectedHomeCategory;
      return SizedBox(
        width: double.infinity,
        child: HorizontalList(
          itemCount: kfTopAppBarMenu.length,
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              showInterstitialAd();
              context.read<KFProvider>().updateHomeCategory(index);
              controller!.jumpTo(controller!.position.minScrollExtent);
              createInterstitialAd();
            },
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: index == selectedIndex
                      ? Colors.white
                      : Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Center(
                  child: Text(
                kfTopAppBarMenu[index]['name'],
                style: boldTextStyle(
                    color: index == selectedIndex ? Colors.black : Colors.white,
                    size: 9),
              )),
            ),
          ),
        ),
      );
    });
  }
}
