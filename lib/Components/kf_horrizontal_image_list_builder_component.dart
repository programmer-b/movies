import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Components/kf_image_container_component.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';

class KFHorrizontalImageListBuilderComponent extends StatefulWidget {
  const KFHorrizontalImageListBuilderComponent(
      {super.key,
      required this.args,
      this.trending = false,
      required this.type});

  final List<Map<String, String>> args;
  final String type;
  final bool trending;

  @override
  State<KFHorrizontalImageListBuilderComponent> createState() =>
      _KFHorrizontalImageListBuilderComponentState();
}

class _KFHorrizontalImageListBuilderComponentState
    extends State<KFHorrizontalImageListBuilderComponent> {
  late List<Map<String, String>> args;
  late bool trending;
  @override
  void initState() {
    super.initState();
    args = widget.args;
    trending = widget.trending;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KFProvider>(
      builder: (context, provider, child) {
        return HorizontalList(
          itemCount: trending ? args.length : kfGenreHorizontalImages,
          itemBuilder: (context, index) {
            final imageUrl = args[index]['imageUrl'];
            final homeUrl = args[index]['homeUrl'] ?? "";
            final type = widget.type;
            final query = args[index]['query'] ?? "";
            final year = args[index]['year'] ?? "";
            final urlImage = 'https:$imageUrl';
            return KFImageContainerComponent(
              urlImage: urlImage,
              homeUrl: homeUrl,
              trending: trending,
              year: year,
              query: query,
              type: type,
            );
          },
          spacing: 0,
        );
      },
    );
  }
}
