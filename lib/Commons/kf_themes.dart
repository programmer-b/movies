import 'package:flutter/material.dart';
import 'package:movies/Commons/kf_colors.dart';
import 'package:nb_utils/nb_utils.dart';

ThemeData? kfMainTheme = ThemeData(
    fontFamily: "KFCustomIcons",
    primarySwatch: Colors.red,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: kfScaffoldBackgroundColor,
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(backgroundColor: Colors.white));

ButtonStyle? kfButtonStyle(context) => ButtonStyle(
      textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
        return boldTextStyle(
            color: states.contains(MaterialState.disabled)
                ? Colors.white
                : Colors.black);
      }),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.white24;
          }
          return Colors.white;
        },
      ),
    );
