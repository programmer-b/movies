
import 'package:flutter/material.dart';

class FlutterDownloaderProvider extends ChangeNotifier {
  dynamic _data;
  dynamic get data => _data;

  void updateData(data) {
    _data = data;
    notifyListeners();
  }
}