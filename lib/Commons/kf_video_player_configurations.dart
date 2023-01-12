import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

BetterPlayerConfiguration betterPlayerConfiguration(context) {
  return const BetterPlayerConfiguration(
      autoPlay: true,
      looping: true,
      fullScreenByDefault: true,
      showPlaceholderUntilPlay: true,
      autoDetectFullscreenAspectRatio: true,
      autoDetectFullscreenDeviceOrientation: true,
      allowedScreenSleep: false,
      useRootNavigator: true,
      expandToFill: true,    
      controlsConfiguration: BetterPlayerControlsConfiguration(
          playerTheme: BetterPlayerTheme.cupertino,
          progressBarPlayedColor: Colors.red,
          showControlsOnInitialize: true,enableFullscreen: true,
          enablePip: true,
          ));
}
