// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';
// import 'package:vsartist/views/account/user.dart';
// import 'package:vsartist/views/artist_features/artist_global/networks.dart';
// import 'package:vsartist/views/common/shared-data.dart';
// import 'package:vsartist/views/common/uidata.dart';

// class AuthBloc {
//   NetworkRequest network = new NetworkRequest();
//   // var db = new DatabaseHelper();

//   final _signup = PublishSubject<SignupForm>();
//   Stream<SignupForm> get signup => _signup.stream;

//   final snackBar = PublishSubject<String?>();
//   Stream<String?> get snacksBar => snackBar.stream;

//   final _showProgress = PublishSubject<bool>();
//   Stream<bool> get showProgress => _showProgress.stream;

//   // final _snackBar = StreamController<String>();
//   // Stream<String> get snackBar => _snackBar.stream;

//   doArtistLogin(String? email, String? password, context) async {
//     _showProgress.add(true);

//     var body = {"email": email, "password": password};

//     return network
//         .guestPost(UiData.domain + "/a1/artist-auth/login", body: body)
//         .then((dynamic response) {
//       response = response['data'];
//       var res = jsonDecode(response);
//       if (res["status"]) {
//         User user = User.map(res["body"]);
//         String userData = jsonEncode(res["body"]);
//         SharedData _pref = SharedData();
//         _pref.setisUserLogin(true);
//         _pref.setIsRecordLabel(false);
//         _pref.setAuthToken(user.token!);
//         _pref.setAuthUserData(userData);

// //        Navigator.pushReplacement(context,
// //            new MaterialPageRoute(builder: (context) => new Dashboard()));

//         Navigator.of(context).pushNamedAndRemoveUntil(
//             UiData.dashboard, (Route<dynamic> route) => false);
//       } else {
//         snackBar.add('${res["body"]["password"][0]}');
//         _showProgress.add(false);
//         return;
//       }
//     });
//   }

//   doRecordLabelLogin(String? email, String? password, context) async {
//     _showProgress.add(true);

//     var body = {"email": email, "password": password};
//     return network
//         .guestPost(UiData.domain + "/r1/record-label-auth/login", body: body)
//         .then((dynamic response) {
//       response = response['data'];
//       var res = jsonDecode(response);
//       if (res["status"]) {
//         User user = User.map(res["body"]);
//         String userData = jsonEncode(res["body"]);
//         SharedData _pref = SharedData();
//         _pref.setisUserLogin(true);
//         _pref.setIsRecordLabel(true);
//         _pref.setAuthToken(user.token!);
//         _pref.setAuthUserData(userData);

// //        Navigator.pushReplacement(context,
// //            new MaterialPageRoute(builder: (context) => new Dashboard()));
//         Navigator.of(context).pushNamedAndRemoveUntil(
//             UiData.record_labeldashboard, (Route<dynamic> route) => false);
//       } else {
//         snackBar.add('${res["body"]["password"][0]}');
//         _showProgress.add(false);
//         return;
//       }
//     });
//   }

//   artistRegister(SignupForm signup, context) async {
//     _showProgress.add(true);
//     Map<dynamic, dynamic> body = {
//       "stage_name": signup.stage_name,
//       "record_label_name": signup.stage_name,
//       "username": signup.username,
//       "email": signup.email,
//       "phone": signup.phone,
//       "country": signup.country,
//       "state": signup.state,
//       "city": signup.city,
//       "password": signup.password,
//       "password_confirm": signup.password_confirmation,
//     };

//     return network
//         .guestPost(UiData.domain + "/a1/artist-auth/signup", body: body)
//         .then((res) {
//       String data = res['data'];
//       var response = jsonDecode(data);

//       if (res['statusCode'] == 200) {
//         snackBar.add('Account Successfully created');
//         //var userData = jsonEncode(response);
//         User user = User.map(response);
//         SharedData _pref = SharedData();
//         _pref.setisUserLogin(true);
//         _pref.setAuthToken(user.token!);
//         _pref.setAuthUserData(data);
//         Navigator.of(context).pushNamedAndRemoveUntil(
//             UiData.dashboard, (Route<dynamic> route) => false);
//       } else {
//         snackBar.add('${response[0]['message']}');
//         _showProgress.add(false);
//         return;
//       }
//     });
//   }

//   generateForgotPasswordToken(
//       ForgetPasswordModel forgetPasswordModel, context) async {
//     _showProgress.add(true);
// //    Map<dynamic, dynamic> body = {
// //      "email": forgetPasswordModel.email,
// //    };
// //    {{base_url}}/a1/artist-auth/forgot-password?email=adebajoolu@gmail.com
//     return network
//         .guestPost(UiData.domain +
//             "/a1/artist-auth/forgot-password?email=${forgetPasswordModel.email}")
//         .then((res) {
//       String data = res['data'];
//       var response = jsonDecode(data);

//       if (response["message"] == 'Ok' || response['statusCode'] == 200) {
//         snackBar.add('Kindly check your email for token');
//       } else {
//         snackBar.add('${response[0]['message']}');
//         _showProgress.add(false);
//         return;
//       }
//     });
//   }

//   generateRecordLabelForgotPasswordToken(
//       ForgetPasswordModel forgetPasswordModel, context) async {
//     _showProgress.add(true);
// //    Map<dynamic, dynamic> body = {
// //      "email": forgetPasswordModel.email,
// //    };
// //    {{base_url}}/a1/artist-auth/forgot-password?email=adebajoolu@gmail.com
//     return network
//         .guestPost(UiData.domain +
//             "/r1/artist-auth/forgot-password?email=${forgetPasswordModel.email}")
//         .then((res) {
//       String data = res['data'];
//       var response = jsonDecode(data);

//       if (response["message"] == 'Ok' || response['statusCode'] == 200) {
//         snackBar.add('Kindly check your email for token');
//       } else {
//         snackBar.add('${response[0]['message']}');
//         _showProgress.add(false);
//         return;
//       }
//     });
//   }

// //  doForgotPassword(ForgetPasswordModel forgetPasswordModel, context) async {
// //    _showProgress.add(true);
// //    Map<dynamic, dynamic> body = {
// //      "password_reset_token": forgetPasswordModel.password_reset_token,
// //      "password": forgetPasswordModel.password,
// //      "password_confirm": forgetPasswordModel.password_confirm,
// //      "email": forgetPasswordModel.email,
// //    };
// //
// //    return network
// //        .guestPost(UiData.domain + "/auth/signup", body: body)
// //        .then((res) {
// //      String data = res['data'];
// //      var response = jsonDecode(data);
// //
// //      if (response["message"] == 'Ok') {
// //        functions.showToast('Account successful created.', context);
// //        configureAuthentication(response, context);
// //      } else {
// //        functions.showToast(
// //            response["errors"][0] ?? 'Try again later', context);
// //      }
// //      general.updateShowProgress(context);
// //      return;
// //    });
// //  }

//   recordLabelRegister(SignupForm signup, context) async {
//     _showProgress.add(true);
//     Map<dynamic, dynamic> body = {
//       "stage_name": signup.stage_name,
//       "record_label_name": signup.stage_name,
//       "username": signup.username,
//       "email": signup.email,
//       "phone": signup.phone,
//       "country": signup.country,
//       "state": signup.state,
//       "city": signup.city,
//       "password": signup.password,
//       "password_confirm": signup.password_confirmation,
//     };

//     return network
//         .guestPost(UiData.domain + "/r1/record-label-auth/signup", body: body)
//         .then((res) {
//       String data = res['data'];
//       var response = jsonDecode(data);

//       if (res['statusCode'] == 200) {
//         snackBar.add('Account Successfully Created');
//         //var userData = jsonEncode(response);
//         User user = User.map(response);
//         SharedData _pref = SharedData();
//         _pref.setisUserLogin(true);
//         _pref.setAuthToken(user.token!);
//         _pref.setAuthUserData(data);
//         Navigator.of(context).pop();
// //        Navigator.of(context).pushReplacementNamed(UiData.dashboard);
//         Navigator.of(context).pushNamedAndRemoveUntil(
//             UiData.record_labeldashboard, (Route<dynamic> route) => false);
//       } else {
//         snackBar.add('${response[0]['message']}');
//         _showProgress.add(false);
//         return;
//       }
//     });
//   }

//   dispose() {
//     _signup.close();
//     snackBar.close();
//     _showProgress.close();
//   }
// }

// final authBloc = AuthBloc();
