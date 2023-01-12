import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_colors.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Commons/kf_themes.dart';
import 'package:nb_utils/nb_utils.dart';

class KFPaginationComponent extends StatelessWidget {
  const KFPaginationComponent({
    super.key,
    required this.onPressedPrevButton,
    required this.onPressedNextButton,
    required this.currentPage,
  });

  final void Function()? onPressedPrevButton;
  final void Function()? onPressedNextButton;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      width: double.infinity,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          "Page $currentPage",
          style: boldTextStyle(color: kfPrimaryTextColor),
        ),
        Row(children: [
          ElevatedButton(
              style: kfButtonStyle(context),
              onPressed: onPressedPrevButton,
              child: Center(
                child: Text(
                  kfPrevButtonLabel,
                  style: boldTextStyle(
                      color: onPressedPrevButton == null
                          ? Colors.white
                          : Colors.black),
                ),
              )),
          6.width,
          ElevatedButton(
              style: kfButtonStyle(context),
              onPressed: onPressedNextButton,
              child: Center(
                child: Text(
                  kfNextButtonLabel,
                  style: boldTextStyle(
                      color: onPressedNextButton == null
                          ? Colors.white
                          : Colors.black),
                ),
              ))
        ])
      ]),
    );
  }
}
