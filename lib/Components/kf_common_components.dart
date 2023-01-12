import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_dimens.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Commons/kf_strings.dart';

Widget loadingWidget({bool trending = false}) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        genreTitlePlaceHolder(),
        6.height,
        HorizontalList(
            itemCount: 10,
            itemBuilder: (context, index) {
              return imagePlaceHolder();
            }),
      ],
    ).paddingSymmetric(vertical: 5, horizontal: 8);

Widget genreTitleWidget(String genre,
        {required bool isMovie, bool trending = false}) =>
    Row(
      children: [
        RichText(
            text: TextSpan(
                text: trending ? '' : '$kfAppName ',
                children: <TextSpan>[
                  TextSpan(
                      text:
                          "$genre ${trending ? '' : isMovie ? 'Movies' : 'Series'} ",
                      style: boldTextStyle(color: Colors.white))
                ],
                style: boldTextStyle(color: Colors.blue))),
        4.width,
        const Icon(Icons.chevron_right)
      ],
    );
Widget genreTitlePlaceHolder() => const FadeShimmer(
      height: 25,
      width: 100,
      fadeTheme: FadeTheme.dark,
    );

Widget imagePlaceHolder({bool trending = false}) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: FadeShimmer(
        width: trending ? trendingImageWidthDimen : defaultGenreImageWidthDimen,
        height:
            trending ? trendingImageHeightDimen : defaultGenreImageHeightDimen,
        fadeTheme: FadeTheme.dark,
      ),
    );
Widget textShimmer(double width, {double height = kfDefaultTextHeight}) =>
    Container(
      decoration: const BoxDecoration(
          borderRadius:
              BorderRadius.all(Radius.circular(kfPlaceHolderTextRadiusDimen))),
      child: FadeShimmer(
        radius: 6,
        height: height,
        width: width,
        fadeTheme: FadeTheme.dark,
      ),
    );
Widget smallTextShimmer({double height = kfDefaultTextHeight}) =>
    textShimmer(smallTextWidthDimen, height: height);
Widget mediumTextShimmer({double height = kfDefaultTextHeight}) =>
    textShimmer(mediumTextWidthDimen, height: height);
Widget largeTextShimmer({double height = kfDefaultTextHeight}) =>
    textShimmer(largeTextWidthDimen, height: height);

List<Widget> smallTextShimmers(number, {double height = kfDefaultTextHeight}) =>
    List<Widget>.generate(number, (index) => smallTextShimmer(height: height));

List<Widget> mediumTextShimmers(number,
        {double height = kfDefaultTextHeight}) =>
    List<Widget>.generate(number, (index) => mediumTextShimmer(height: height));

List<Widget> largeTextShimmers(number, {double height = kfDefaultTextHeight}) =>
    List<Widget>.generate(number, (index) => largeTextShimmer(height: height));
