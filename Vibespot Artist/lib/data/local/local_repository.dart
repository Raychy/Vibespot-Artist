/// Interface for Local Repository
abstract class LocalRepository {
  /// initialize instance of database
  void init();

  /// get stored data from local database.
  ///
  /// checks if the data was cached and returns the cached data if its not expired, otherwise it returns null
  ///
  /// [key] - the key used to store the data
  Future<dynamic> getData(String key);

  /// get stored data from local database
  /// [key] - the key used to store the data
  /// [data] - string version of the data to be stored
  Future<dynamic> saveData(String key, String data);

  /// save expiry time in miliseconds for this data
  /// [key] - the key used to store the data
  /// [duration] - duration of cache in seconds
  void saveTime(String key, int duration);

  /// clear all content from cache
  void clearCache();

  /// remove a cached content from cache
  /// [key] - the key used to store the data
  void removeData(String key);

  /// check time storage if cached data exists and is valid
  /// [key] - the key used to store the data
  /// [data] - string version of the data to be stored
  Future<bool> checkCache(String key);
}

class CacheDescription {
  final String key;
  /// time in seconds
  final int lifeSpan;

  CacheDescription(this.key, {this.lifeSpan =  CacheDescription.ONE_MINUTE * 2, });

    static const ONE_MONTH = ONE_DAY * 30;
  static const SEVEN_DAYS = ONE_DAY * 7;
  static const ONE_DAY = ONE_HOUR * 24;
  static const ONE_HOUR = ONE_MINUTE * 60;
  static const ONE_MINUTE = 60 * 60;
}
