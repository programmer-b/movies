import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_menus.dart';
import 'package:movies/Components/kf_app_bar_menu_component.dart';
import 'package:movies/Fragments/kf_error_screen_fragment.dart';
import 'package:movies/Components/kf_sliver_app_bar_component.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:provider/provider.dart';

class KFHomeFragment extends StatefulWidget {
  const KFHomeFragment({Key? key}) : super(key: key);

  @override
  State<KFHomeFragment> createState() => _KFHomeFragmentState();
}

class _KFHomeFragmentState extends State<KFHomeFragment> {
  late ScrollController? controller;

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KFProvider>(builder: (context, provider, child) {
      return provider.contentLoadError
          ? const KFErrorScreenComponent()
          : CustomScrollView(
              controller: controller,
              slivers: <Widget>[
                KFSliverAppBarComponent(
                  pinned: false,
                  snap: true,
                  floating: true,
                  expandedHeight: 90,
                  flexibleSpace: _flexibleSpace(controller),
                ),
                kfTopAppBarMenu[provider.selectedHomeCategory]['widget']
              ],
            );
    });
  }

  Widget _flexibleSpace(ScrollController? controller) => Padding(
        padding: EdgeInsets.zero,
        child: FlexibleSpaceBar(
          title: KFAppBarMenuComponent(controller: controller),
          titlePadding: EdgeInsets.zero,
          collapseMode: CollapseMode.none,
        ),
      );
}
