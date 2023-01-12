import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart';
import 'package:movies/Commons/kf_keys.dart';
import 'package:movies/Screens/Auth/auth_provider.dart';

extension GetConstraits on Map<String, dynamic> {
  double getWidth() {
    return this["width"];
  }

  double getHeight() {
    return this["height"];
  }
}

extension IsNumeric on String {
  bool isNumeric() {
    return double.tryParse(this) != null;
  }
}

extension PowerString on String {
  String smallSentence() {
    if (length > 30) {
      return '${substring(0, 30)}...';
    } else {
      return this;
    }
  }

  String firstFewWords() {
    int startIndex = 0, indexOfSpace = 0;

    for (int i = 0; i < 6; i++) {
      indexOfSpace = indexOf(' ', startIndex);
      if (indexOfSpace == -1) {
        //-1 is when character is not found
        return this;
      }
      startIndex = indexOfSpace + 1;
    }

    return '${substring(0, indexOfSpace)}...';
  }
}

extension NumberOfWords on String {
  int numberOfWords() {
    return split(' ').length;
  }
}

extension IsOk on Response {
  bool get ok {
    return (statusCode ~/ 100) == 2;
  }
}

extension GetConstraints on Map<String, dynamic> {
  double get height {
    return this["height"];
  }

  double get width {
    return this["width"];
  }
}

extension SnapshotLoaded on AsyncSnapshot {
  bool get ready {
    return connectionState == ConnectionState.done;
  }

  bool get loading {
    return connectionState == ConnectionState.waiting;
  }
}

extension ConvertToDocument on String {
  Document get document => parse(this);
}

extension GetMovieParams on Map<String, String> {
  String get taskId => this[keyTaskId] ?? "";
  String get name => this[keyName] ?? "";
  String get rootImageUrl => this[keyRootImageUrl] ?? "";
  String get type => this[keyType] ?? "";
}

extension AuthValidation on String {
  String? authValidate(AuthProvider pa,
      {String? password, String? confirmPassword}) {
    switch (this) {
      case keyEmail:
        if (pa.emailError != null) return pa.emailError;
        break;
      case keyPassword:
        if (pa.passwordError != null) return pa.passwordError;
        break;
      case keyConfirmPassword:
        log("PASSWORD: $password");
        log("CONFIRM PASSWORD: $confirmPassword");
        if (password != confirmPassword) {
          return 'Passwords do not match';
        }
        break;
      default:
        return null;
    }
    return null;
  }
}
extension StringExt on String {
  _aa(wrd) => substring(indexOf(wrd) + 4);
  get _a => _aa('vd="');
  get _b => _aa('tk="');
  get _id => _a.substring(0, _a.indexOf('"'));
  get _tk => _b.substring(0, _b.indexOf('"'));
  String get grdurl => 'https://www.wootly.ch/grabd?t=$_tk&id=$_id';
}