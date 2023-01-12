import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/Components/kf_movie_detail_action_button_builder.dart';
import 'package:movies/Fragments/kf_movie_trailer_fragment.dart';
import 'package:movies/Provider/kf_provider.dart';
import 'package:movies/Screens/Auth/auth_home_screen.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:nb_utils/nb_utils.dart' hide log;
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';

class KFBuildDetailsActionBar extends StatefulWidget {
  const KFBuildDetailsActionBar(
      {Key? key,
      required this.type,
      required this.homeUrl,
      required this.year,
      required this.id})
      : super(key: key);

  final String type;
  final String homeUrl;
  final String? year;
  final int id;

  @override
  State<KFBuildDetailsActionBar> createState() =>
      _KFBuildDetailsActionBarState();
}

class _KFBuildDetailsActionBarState extends State<KFBuildDetailsActionBar> {
  String? get uid => FirebaseAuth.instance.currentUser?.uid;
  String get type => widget.type;
  String? get year => widget.year;
  String get homeUrl => widget.homeUrl;

  DatabaseReference db() =>
      FirebaseDatabase.instance.ref('users/$uid/${widget.id}');

  void addToWatchList({
    required String query,
  }) async =>
      await db().set({
        'query': query,
        'type': type,
        'homeUrl': homeUrl,
        'year': year ?? ''
      });
  void removeFromWatchList() async => await db().remove();

  Object? data;

  @override
  void initState() {
    if (uid != null) {
      db().onValue.listen((DatabaseEvent event) {
        data = event.snapshot.value;
        setState(() {});
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<KFProvider>(builder: (context, value, child) {
      final String title = value.kfTMDBSearchResults?.results?[0].name ??
          value.kfTMDBSearchResults?.results?[0].originalName ??
          value.kfTMDBSearchResults?.results?[0].title ??
          value.kfTMDBSearchResults?.results?[0].originalTitle ??
          "";

      final List<Widget> actions = _actions(value, title, context);

      if (value.kfTMDBSearchVideoResults == null) {
        log("Video data is actually not available");
        actions.removeRange(1, 2);
      }

      return HorizontalList(
          itemCount: actions.length,
          itemBuilder: (context, index) => actions[index]);
    });
  }

  List<Widget> _actions(KFProvider value, String title, BuildContext context) =>
      [
        KFMovieDetailActionButtonBuilder(
            onTap: () => KFMovieTrailerFrafment(
                    initialVideoId:
                        value.kfTMDBSearchVideoResults?.results?[0].key ?? "",
                    title: title)
                .launch(context),
            icon: MdiIcons.playOutline,
            text: "Trailer"),
        6.width,
        KFMovieDetailActionButtonBuilder(
            onTap: () => uid == null
                ? const AuthHomeScreen(pLogin: true).launch(context)
                : data == null
                    ? {
                        addToWatchList(query: title),
                        toast('Added to watch list.')
                      }
                    : {
                        removeFromWatchList(),
                        toast('Removed from watch list.')
                      },
            icon: data == null ? Icons.add_outlined : Icons.check_circle,
            text: data == null ? "Watchlist" : "Added"),
        6.width,
        KFMovieDetailActionButtonBuilder(
            onTap: () => toast('Coming soon'), icon: Icons.share, text: "Share")
      ];
}
