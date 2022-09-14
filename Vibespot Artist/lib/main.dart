import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vsartist/Controllers/Auth_Controller.dart';
import 'di.dart';
import 'global_variables.dart';
import 'views/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AuthController authController = Get.put(AuthController());

  await Firebase.initializeApp();

  FirebaseMessaging.instance.getToken().then((value) {
    fcmToken.value= value!;
    print("Token saved");
    print(fcmToken.value);
  });
  await DI.setUp();
  runApp(DI.providers(App()));
}
