import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_extensions.dart';
import 'package:nb_utils/nb_utils.dart';

class AuthLoading extends StatelessWidget {
  const AuthLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: 3.seconds.delay,
        builder: (context, snapshot) {
          if (snapshot.ready) {
            finish(context);
          }
          return Container(
            color: Colors.black,
            width: context.width(),
            height: context.height(),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(),
          );
        });
  }
}
