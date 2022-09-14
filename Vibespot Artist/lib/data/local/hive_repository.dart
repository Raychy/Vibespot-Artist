import 'package:hive/hive.dart';
import 'package:vsartist/constants/hive_boxes.dart';
import 'package:vsartist/core/extensions/index.dart';

import 'local_repository.dart'; 

class HiveRepository implements LocalRepository {
  late LazyBox cacheBox;
  late LazyBox cacheTimeBox;
  HiveRepository() {
    init();
  }

  @override
  Future init() async {
    cacheBox = await Hive.openLazyBox(HiveBoxes.CACHE_BOX);
    cacheTimeBox = await Hive.openLazyBox(HiveBoxes.CACHE_TIME_BOX);
  }

  @override
  Future getData(String key) => cacheBox.get(key);

  @override
  Future<dynamic> saveData(String key, String data) => cacheBox.put(key, data);

  @override
  Future<bool> checkCache(String key) async {
    var time = cacheTimeBox.get(key).asInt;
    print('cache: $key, $time');
    if (time == null) return false;
    return !time.isPast;
  }

  @override
  void saveTime(String? key, int? duration) {
    duration = duration?.secondsToMilliseconds;
    if (key != null && key.isNotEmpty && duration != null && !duration.isNaN)
      cacheTimeBox.put(key, duration);
  }

  @override
  void clearCache() {
    cacheBox.clear();
    cacheTimeBox.clear();
  }

  @override
  void removeData(String key) {
    cacheBox.delete(key);
    cacheTimeBox.delete(key);
  }
}
