import 'package:share_plus/share_plus.dart';

class KFShare {
  static Future<void> shareText(String url) async {
    await Share.share(url);
  }
}