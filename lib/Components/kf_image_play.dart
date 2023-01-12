import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../Commons/kf_strings.dart';

class KFImagePlay extends StatelessWidget {
  const KFImagePlay(
      {super.key, required this.width, required this.height, this.path});
  final double width;
  final double height;
  final String? path;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
              color: Colors.white30,
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              image: path == null
                  ? null
                  : DecorationImage(
                      image: CachedNetworkImageProvider(
                          "$kfOriginalTMDBImageUrl$path"),
                      fit: BoxFit.cover)),
        ),
        Container(
          height: height,
          width: width,
          color: Colors.transparent,
          alignment: Alignment.center,
          child: playButton(onTap: () {}),
        )
      ],
    );
  }

  Widget playButton({required Function()? onTap}) => InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
              color: const Color(0x67000000),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
              )),
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 17,
          ),
        ),
      );
}
