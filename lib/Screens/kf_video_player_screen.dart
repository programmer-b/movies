import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart' hide log;

class KFVideoPlayerScreen extends StatefulWidget {
  const KFVideoPlayerScreen({
    Key? key,
    required this.masterUrl,
  }) : super(key: key);

  final String masterUrl;
  @override
  State<KFVideoPlayerScreen> createState() => _KFVideoPlayerScreenState();
}

class _KFVideoPlayerScreenState extends State<KFVideoPlayerScreen> {
  late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    super.initState();

    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        //https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4
        widget.masterUrl);
    _betterPlayerController = BetterPlayerController(
        const BetterPlayerConfiguration(
            controlsConfiguration: BetterPlayerControlsConfiguration(
                playerTheme: BetterPlayerTheme.cupertino,
                loadingColor: Colors.red,
                enableFullscreen: false,
                enablePip: true,
                enableQualities: true),
            fullScreenByDefault: true,
            allowedScreenSleep: false,
            autoPlay: true,
            autoDetectFullscreenDeviceOrientation: true,
            autoDispose: true,
            deviceOrientationsAfterFullScreen: [
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight
            ],
            deviceOrientationsOnFullScreen: [
              DeviceOrientation.landscapeLeft,
              DeviceOrientation.landscapeRight
            ]),
        betterPlayerDataSource: betterPlayerDataSource);

    setOrientationLandscape();
    enterFullScreen();
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exitFullScreen();
        setOrientationPortrait();
        finish(context);
        return true;
      },
      child: Scaffold(
        body: Builder(builder: (context) {
          _betterPlayerController
              .setOverriddenAspectRatio(context.pixelRatio());
          _betterPlayerController.setOverriddenFit(BoxFit.fill);
          return BetterPlayer(
            controller: _betterPlayerController,
          );
        }),
      ),
    );
  }
}
