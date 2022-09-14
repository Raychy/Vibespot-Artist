import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class SecureStore {
  final FlutterSecureStorage storage;
  factory SecureStore()=> SecureStore._();

  SecureStore._(): storage = FlutterSecureStorage();

 
  void setString(String key, String value) async{
     try {
       return   await storage.write(key: key, value: value);
     } catch (e) {
       if(kDebugMode)print(e);
       return null;
     }
      }
     

  Future<String?> getString(String key) async {
     try {
       return  await storage.read(key: key);
     } catch (e) {
       if(kDebugMode)print(e);
       return null;
     }
      }

  Future<void> deleteKey(String key) async =>
      await storage.delete(key: key);
}
