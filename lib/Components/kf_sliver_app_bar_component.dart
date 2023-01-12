import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies/Commons/kf_colors.dart';
import 'package:movies/Fragments/kf_search_fragment.dart';
import 'package:nb_utils/nb_utils.dart';

import '../Screens/account/view.dart';

class KFSliverAppBarComponent extends StatelessWidget {
  const KFSliverAppBarComponent(
      {super.key,
      this.flexibleSpace,
      this.pinned = false,
      this.snap = false,
      this.floating = false,
      this.expandedHeight,
      this.automaticallyImplyLeading = true,
      this.elevation,
      this.bottom,
      this.showTopMenu = true,
      this.actions,
      this.title,
      this.backgroundColor,
      this.systemOverlayStyle});

  final Widget? flexibleSpace;
  final bool pinned;
  final bool snap;
  final bool floating;
  final double? expandedHeight;
  final bool automaticallyImplyLeading;
  final double? elevation;
  final PreferredSizeWidget? bottom;
  final bool? showTopMenu;
  final List<Widget>? actions;
  final Widget? title;
  final Color? backgroundColor;
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      systemOverlayStyle: systemOverlayStyle,
      elevation: elevation,
      automaticallyImplyLeading: automaticallyImplyLeading,
      iconTheme: const IconThemeData(color: Colors.white60),
      actions: showTopMenu ?? true
          ? [
              IconButton(
                  onPressed: () => const KFSearchFragment().launch(context),
                  icon: const Icon(Icons.search, size: 37)),
              IconButton(
                  onPressed: () => const AccountPage().launch(context),
                  icon: const Icon(
                    Icons.account_circle,
                    size: 37,
                  ))
            ]
          : actions,
      backgroundColor: backgroundColor ?? kfAppBarBgColor,
      pinned: pinned,
      snap: snap,
      floating: floating,
      expandedHeight: expandedHeight,
      flexibleSpace: flexibleSpace,
      bottom: bottom,
      title: title,
    );
  }
}
