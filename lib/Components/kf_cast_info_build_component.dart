import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Commons/kf_functions.dart';
import '../Models/kf_cast_information_model.dart';

class KFCastInfoBuildComponent extends StatelessWidget {
  const KFCastInfoBuildComponent({
    super.key,
    required this.data,
  });

  final KFCastInformationModel? data;

  @override
  Widget build(BuildContext context) {
    final height = getScreenContraints(context)["height"] ?? 0.0;
    final width = getScreenContraints(context)["width"] ?? 0.0;
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: width,
                height: height * 2.0,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                    color: Colors.black,
                    image: data?.profilePath == null
                        ? null
                        : DecorationImage(
                            alignment: Alignment.topCenter,
                            fit: BoxFit.fitWidth,
                            image: CachedNetworkImageProvider(
                                "$kfOriginalTMDBImageUrl${data?.profilePath}"),
                          )),
                child: Container(
                  width: width,
                  height: height,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0x11000000),
                      Color(0x77000000),
                      Color(0xcc000000),
                      Colors.black
                    ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  top: 0.46 * height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(data?.name ?? "",
                                  style: boldTextStyle(
                                    size: 28,
                                    color: Colors.white,
                                  )),
                              10.height,
                              ReadMoreText(
                                data?.biography ?? "",
                                trimCollapsedText: kfTrimCollapsedText,
                              ),
                              16.height,
                              if (data?.knownForDepartment != null)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Profession",
                                      style: boldTextStyle(color: Colors.white),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 7,
                                        vertical: 10,
                                      ),
                                      child:
                                          Text(data?.knownForDepartment ?? ""),
                                    ),
                                  ],
                                )
                            ]).paddingSymmetric(horizontal: 14),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
