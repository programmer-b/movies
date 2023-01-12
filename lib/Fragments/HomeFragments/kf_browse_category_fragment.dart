import 'package:flutter/material.dart';
import 'package:movies/Components/kf_browse_component.dart';

class KFBrowseCategoryFragment extends StatelessWidget {
  const KFBrowseCategoryFragment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return KFBrowserComponent(
            key: UniqueKey(),
          );
        },
        childCount: 1,
      ),
    );
  }
}
