import 'package:built_collection/built_collection.dart';

extension FormError on BuiltMap<String, dynamic> {
  T? getKey<T>(String key) {
   try {
      // if (this == null) return null;
    if (this.containsKey(key))
      return this[key];
    else
      return null;
   } catch (e) {
      return null;
   }
  }
}


extension MapExt on Map<String, dynamic> {
  T? getKey<T>(String key) {
    try {
    if (this.containsKey(key))
      return this[key];
    else
      return null;
    } catch (e) {
       return null;
    }
  }
}
