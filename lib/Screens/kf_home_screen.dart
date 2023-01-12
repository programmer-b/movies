import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:movies/Commons/kf_colors.dart';
import 'package:movies/Fragments/kf_downloads_fragment.dart';
import 'package:movies/Fragments/kf_home_fragment.dart';
import 'package:movies/Fragments/kf_trailers_and_more_fragment.dart';
import 'package:movies/Provider/flutter_downloader_provider.dart';
import 'package:movies/Utils/ad_helper.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../Commons/kf_keys.dart';
import '../main.dart';

class KFHomeScreen extends StatefulWidget {
  const KFHomeScreen({Key? key}) : super(key: key);

  @override
  State<KFHomeScreen> createState() => _KFHomeScreenState();
}

class _KFHomeScreenState extends State<KFHomeScreen> {
  static int _selectedIndex = 0;
  void _onItemTapped(index) => setState(() => _selectedIndex = index);
  Widget _selectedFragment(index) {
    if (index != 0) {
      showInterstitialAd();
      createInterstitialAd();
    }
    switch (index) {
      case 0:
        return const KFHomeFragment();
      case 1:
        return const KFTrailersAndMoreFragment();
      case 2:
        return const KFDownloadsFragment();
      default:
        return const KFHomeFragment();
    }
  }

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    ///Create : Initialize an interstitialAd
    createInterstitialAd();

    IsolateNameServer.registerPortWithName(_port.sendPort, keyDownloadReport);
    _port.listen((dynamic data) {
      context.read<FlutterDownloaderProvider>().updateData(data);
    });
    FlutterDownloader.registerCallback(MyApp.downloadCallback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _selectedFragment(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        backgroundColor: kfScaffoldBackgroundColor,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              tooltip: 'Home',
              icon: _selectedIndex == 0
                  ? const Icon(MdiIcons.homeVariant)
                  : const Icon(MdiIcons.homeVariantOutline),
              label: 'Home'),
          BottomNavigationBarItem(
              tooltip: 'Trailers',
              icon: _selectedIndex == 1
                  ? const Icon(Icons.video_library)
                  : const Icon(Icons.video_library_outlined),
              label: 'Trailers and More'),
          BottomNavigationBarItem(
              tooltip: 'Downloads',
              icon: _selectedIndex == 2
                  ? const Icon(
                      Icons.file_download_outlined,
                      color: Colors.white,
                    )
                  : const Icon(Icons.file_download_outlined),
              label: 'Downloads'),
        ],
      ),
    );
  }
}
