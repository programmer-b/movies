import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:movies/Commons/kf_keys.dart';
import 'package:movies/Commons/kf_strings.dart';
import 'package:movies/Screens/kf_home_screen.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../Commons/kf_functions.dart';
import '../Provider/kf_provider.dart';

class KFSplashScreen extends StatefulWidget {
  const KFSplashScreen({Key? key}) : super(key: key);

  @override
  State<KFSplashScreen> createState() => _KFSplashScreenState();
}

class _KFSplashScreenState extends State<KFSplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    final provider = context.read<KFProvider>();
    provider.stracturePopularMoviesAndSeriesData();
    await fetchDataAndStoreData(provider);
  }

  Future<void> _ready() async {
    await 5.seconds.delay;
  }

  Future<void> launchToHomeScreenFirstTime() async {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
        await setValue(keyNotFirstTime, true);
        const KFHomeScreen().launch(context, isNewTask: true);
      });
    }
  }

  Future<void> launchToHomeScreen() async =>
      WidgetsBinding.instance.addPostFrameCallback(
          (timeStamp) => const KFHomeScreen().launch(context, isNewTask: true));

  bool get firstTime => getBoolAsync(keyNotFirstTime);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: _ready(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (!firstTime) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
                  showDialog(
                      context: context, builder: (_) => _loadingScaffold()));
            } else {
              launchToHomeScreen();
            }
            return _loadingWidget();
          }
          return _loadingWidget();
        });
  }

  Widget _loadingScaffold() => Scaffold(
        body: FutureBuilder(
            future: 5000.milliseconds.delay,
            builder: (context, snap) {
              if (snap.ready) {
                launchToHomeScreenFirstTime();
              }
              log('Loading scaffold');
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      );

  Widget _loadingWidget() => Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultTextStyle(
                style: boldTextStyle(
                    size: 44,
                    color: Color.fromARGB(255, 231, 26, 11),
                    fontFamily: 'assets/fonts/BungeeInline-Regular.ttf'),
                child: AnimatedTextKit(
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TypewriterAnimatedText(kfAppName.toUpperCase(),
                          speed: 200.milliseconds)
                    ])),
          ],
        ).center().paddingSymmetric(vertical: 30),
      );
}
