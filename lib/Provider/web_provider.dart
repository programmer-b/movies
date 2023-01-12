import 'dart:developer';

import 'package:flutter/material.dart';

class KFWebProvider extends ChangeNotifier {
  int _urlHits = 0;
  int get urlHits => _urlHits;

  bool _webAccessed = false;
  bool get webAccessed => _webAccessed;

  void addUrlHits() {
    _urlHits += 1;
    log("$_urlHits");

    if (_urlHits > 5) {
      log("url hits are more than 5");

      _webAccessed = true;
      notifyListeners();
    }
  }
}
