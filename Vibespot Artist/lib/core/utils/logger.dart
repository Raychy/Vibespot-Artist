// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:simple_logger/simple_logger.dart'; 


/// loging utility class
class Log {
static final logger = SimpleLogger(); 
  
 

  static void i(dynamic? message) {
    if (kDebugMode) logger.info(message?.toString() ?? '');
  }

  static void d(dynamic? message) {
    if (kDebugMode) logger.info(message?.toString());
  }

  static void e(dynamic? message) {
    if (kDebugMode) logger.severe(message?.toString() ?? '');
  }
 

  static uploadLog(String title, String trace) {
    // FirebaseCrashlytics.instance
    //     .recordError(title ?? '', StackTrace.fromString(trace ?? ''));
  }
}
