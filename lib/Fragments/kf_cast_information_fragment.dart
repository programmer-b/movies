import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Commons/kf_functions.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Components/kf_cast_info_build_component.dart';
import 'package:movies/Fragments/kf_content_not_found_fragment.dart';
import 'package:movies/Models/kf_cast_information_model.dart';
import 'package:nb_utils/nb_utils.dart';

class KFCastInfoFragment extends StatefulWidget {
  const KFCastInfoFragment({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;
  @override
  State<KFCastInfoFragment> createState() => _KFCastInfoFragmentState();
}

class _KFCastInfoFragmentState extends State<KFCastInfoFragment> {
  Future<KFCastInformationModel> _fetchInfo() async {
    final url = kfGetCastInformation(castId: id);
    try {
      final results = await fetchDataFromInternet(url);
      if (results.ok) {
        return KFCastInformationModel.fromJson(jsonDecode(results.body));
      } else {
        throw "Invalid Status Code ${results.statusCode}\nRESULTS: $results\n\n";
      }
    } catch (e) {
      rethrow;
    }
  }

  int get id => widget.id;

  late Future<KFCastInformationModel> future;

  @override
  void initState() {
    super.initState();
    future = _fetchInfo();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<KFCastInformationModel>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          return KFCastInfoBuildComponent(data: data);
        }
        if (snapshot.hasError) {
          return const KFContentNotFound();
        }
        return snapWidgetHelper(snapshot,
            loadingWidget: Container(
              color: Colors.black,
              height: context.height(),
              width: context.width(),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            )).center();
      },
    );
  }
}
