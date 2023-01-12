import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class KFCacheManager {
  static kfCustomCacheManager(
          {Duration stalePeriod = const Duration(days: 15)}) =>
      CacheManager(Config('customCacheKey', stalePeriod: stalePeriod));
}
