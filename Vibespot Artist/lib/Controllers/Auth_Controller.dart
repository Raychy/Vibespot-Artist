// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../global_variables.dart';

class AuthController extends GetxController {
  var token = "".obs;

  Future saveFcmToken({@required token, @required userId}) async {
    print("save fcm");
    print(token);
    String url = baseUrl + saveFcmUrl;
    print(url);
    try {
      http.Response response = await http.post(Uri.parse(url), body: {
        "fcm_token": token,
        "user_id": USER_ID.value.toString(),
      },
      );
      print("fcm response");
      print(response.body);
    } catch (e) {
      rethrow;
    }
  }



}
