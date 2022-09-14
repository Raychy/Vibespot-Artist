import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:vsartist/Controllers/Auth_Controller.dart';
import 'package:vsartist/constants/image_assets.dart';
import 'package:vsartist/constants/pref_keys.dart';
import 'package:vsartist/core/preference_store/preference_store.dart';
import 'package:vsartist/views/account/login.dart'; 
import 'package:vsartist/views/dashboard.dart';

import '../global_variables.dart';
import 'account/bloc/auth/auth_bloc.dart';
import 'onboarding/onboarding.dart';

class SplashPage extends StatefulWidget {
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  startTime() async {
    var duration = new Duration(seconds: 2);
    return Timer(duration, navigate);
  }

  @override
  void initState() {
    super.initState();
    startTime();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  void navigate() async {
    var _pref = GetIt.I<PreferenceStore>();
    if (Auth.state is AuthUninitialized)
      return Future.delayed(Duration(milliseconds: 500), navigate);

    if (!(await _pref.getBool(PrefKeys.SEEN_SLIDE, false))) {
      Navigator.of(context).pushReplacementNamed(Onboarding.routeName);
      return;
    }

    if (Auth.state is UnAuthenticated) {
      Navigator.of(context).pushReplacementNamed(Login.routeName);
      return;
    }
    USER_ID.value=Auth.state.user!.id!.toInt();
    AuthController authController = Get.put(AuthController());
    authController.saveFcmToken(token: fcmToken.value, userId: USER_ID.value);
    print("User ID Unique");
    print(USER_ID.value);
    Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageAssets.SPLASH),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
