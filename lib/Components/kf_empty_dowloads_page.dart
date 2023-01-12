import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class KFEmptyDownloadsPage extends StatelessWidget {
  const KFEmptyDownloadsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height() - (kToolbarHeight * 2.5),
      width: context.width(),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "No Videos Downloaded",
            style: boldTextStyle(size: 22, color: Colors.white),
          ),
          6.height,
          Text(
            "Your downloads will appear here.",
            style: primaryTextStyle(color: Colors.white60),
            textAlign: TextAlign.center,
          )
        ],
      )),
    );
  }
}
