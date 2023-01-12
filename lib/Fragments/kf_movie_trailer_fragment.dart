import 'package:flutter/material.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class KFMovieTrailerFrafment extends StatefulWidget {
  const KFMovieTrailerFrafment(
      {super.key, required this.initialVideoId, required this.title});
  final String initialVideoId;
  final String title;

  @override
  State<KFMovieTrailerFrafment> createState() => _KFMovieTrailerFrafmentState();
}

class _KFMovieTrailerFrafmentState extends State<KFMovieTrailerFrafment> {
  String get initialVideoId => widget.initialVideoId;
  String get title => widget.title;

  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: initialVideoId,
        flags: const YoutubePlayerFlags(
            loop: true,
            forceHD: true,
            autoPlay: true,
            showLiveFullscreenButton: false));

    enterFullScreen();
    setOrientationLandscape();
  }

  @override
  void dispose() {
    super.dispose();
    exitFullScreen();
    setOrientationPortrait();
  }

  @override
  Widget build(BuildContext context) {
    _controller.fitHeight(Size.fromHeight(context.height()));
    _controller.fitWidth(Size.fromWidth(context.width()));
    return Scaffold(
      body: Consumer<KFProvider>(builder: (context, value, child) {
        return YoutubePlayer(
          aspectRatio: context.pixelRatio(),
          controller: _controller,
          width: double.infinity,
          showVideoProgressIndicator: true,
          progressIndicatorColor: Colors.red,
          topActions: _topActions,
        );
      }),
    );
  }

  List<Widget> get _topActions => [
        BackButton(
          onPressed: () => finish(context),
        ),
        Text(style: boldTextStyle(size: 18, color: Colors.white), title)
      ];
}
