import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_functions.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:movies/Commons/kf_extensions.dart';

class KFCastImageComponent extends StatelessWidget {
  const KFCastImageComponent(
      {super.key, required this.profilePath, required this.name, this.onTap});
  final String? profilePath;
  final String? name;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final constraits = getScreenContraints(context);
    final double width = constraits["width"] ?? 0.0;
    return GestureDetector(
      onTap: onTap,
      child: Responsive(
        mobile: Container(
          width: width * 0.3,
          height: width * 0.3 * 1.57,
          decoration: decoration(profilePath),
          child: Stack(children: [
            if (name != null)
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: name?.numberOfWords() == null
                      ? 0
                      : name?.numberOfWords() == 2 || name?.numberOfWords() == 1
                          ? 30
                          : 45,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.black,
                    Color(0xaa000000),
                    Color(0x99000000),
                    Color(0x77000000)
                  ], begin: Alignment.bottomCenter, end: Alignment.topCenter)),
                  alignment: Alignment.center,
                  child: Text(
                    "$name",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ]),
        ),
        tablet: Container(
            width: width * 0.23,
            height: width * 0.3 * 1.57,
            decoration: decoration(profilePath)),
      ),
    );
  }

  BoxDecoration decoration(profilePath) => BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Colors.white12,
        image: profilePath == null
            ? null
            : DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                    "$kfOriginalTMDBImageUrl$profilePath")),
      );
}
