import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart'; 
import 'package:vsartist/views/add_artist/newly_added_artist.dart';
import 'package:vsartist/views/artist_features/uploads/uploads-model.dart';
import 'package:vsartist/views/common/shared-data.dart';
import 'package:vsartist/views/dashboard.dart'; 

import '../../common/uidata.dart';

class NetworkRequest {
  static NetworkRequest _instance = new NetworkRequest.internal();
  NetworkRequest.internal();
  factory NetworkRequest() => _instance;
  final _internetStatus = PublishSubject<String>();
  Stream<String> get internetStatus => _internetStatus.stream;

  final snackBar = PublishSubject<String>();
  Stream<String> get snacksBar => snackBar.stream;

  final _showProgress = PublishSubject<bool>();
  Stream<bool> get showProgress => _showProgress.stream;

  final _sendProgress = PublishSubject<List>();
  Stream<List> get sendProgress => _sendProgress.stream;
  String? token;

  showToast(data, [context]) {
    Fluttertoast.showToast(
      msg: data,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      //fontSize: 16.0
    );
    //Toast.show(data, context, duration: 5, gravity: Toast.BOTTOM);
  }

  getTokken() async {
    SharedData _pref = SharedData();
    if (await _pref.getisUserLogin() == true) {
      print(await _pref.getAuthToken());
      return token = await _pref.getAuthToken();
    } else {
      return token = null;
    }
  }

  authLogout(statusCode, context) {
    SharedData _pref = SharedData();
    if (context != null && statusCode == 401) {
      _pref.disposeLogin();
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed(UiData.login);
    }
  }

  Future<String> get(String url, {context}) async {
    token = await getTokken();
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Accept": "application/json"
    };

    return await http.get(Uri.parse(url), headers: headers).then((response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      authLogout(statusCode, context);
      if (statusCode < 200 || statusCode > 422 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<String> postMap(String url,
      {Map? headers,
      Map<String, dynamic>? parameters,
      encoding,
      context}) async {
    token = await getTokken();
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      'Content-type': 'application/json',
      "Accept": "application/json",
      encoding: encoding
    };

    return await http
        .post(
      Uri.parse(url),
      body: parameters,
      headers: headers as Map<String, String>?,
      encoding: encoding,
    )
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      authLogout(statusCode, context);
      if (statusCode < 200 || statusCode > 422 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<String> post(String url,
      {Map? headers, body, encoding, context}) async {
    token = await getTokken();
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Accept": "application/json"
    };

    return await http
        .post(Uri.parse(url), body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      authLogout(statusCode, context);
      if (statusCode < 200 || statusCode > 422 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<dynamic> postWithFile(String url,
      {Map? headers, body, encoding, context}) async {
    token = await getTokken();
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Accept": "application/json",
      "content-type": "application/json"
    };

    Dio dio = new Dio();
    dio.options.headers = headers;
    try {
      return dio.post(url, data: body, onSendProgress: (int sent, int total) {
        print("$sent $total");
        _sendProgress.add([sent, total]);
      }, options: new Options(contentType: Headers.jsonContentType)).then(
          //ContentType.parse("application/json")
          (response) {
        final dynamic res = response;
        final int? statusCode = response.statusCode;
        print('Network response: $statusCode');
        print('Network response: $res');
        authLogout(statusCode, context);
        // if (statusCode < 200 || statusCode > 422 || json == null) {
        //   throw new Exception("Error while fetching data");
        // }
        return res.toString();
      });
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        // print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.request);
        print(e.message);
      }
    }
  }

  Future<dynamic> postWithForms(String url,
      {Map? headers, body, encoding, context}) async {
    token = await getTokken();
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Accept": "application/json",
      "content-type": "application/json"
    };

    Dio dio = new Dio();
    dio.options.headers = headers;
    try {
      return dio
          .post(url,
              data: body,
              options: new Options(contentType: Headers.jsonContentType))
          .then((response) {
        final dynamic res = response;
        final int? statusCode = response.statusCode;
        return statusCode.toString();
      });
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response!.data);
        print(e.response!.headers);
        // print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        // print(e.request);
        print(e.message);
      }
    }
  }

  Future<dynamic> guestGet(String url) {
    var headers = {"Accept": "application/json"};
    return http
        .get(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 422 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return res;
    });
  }

  Future<dynamic> guestPost(String url, {Map? headers, body, encoding}) {
    var headers = {"Accept": "application/json"};
    return http
        .post(Uri.parse(url), body: body, headers: headers, encoding: encoding)
        .then((http.Response response) {
      final dynamic res = response.body;
      //print(res);
      final int statusCode = response.statusCode;
      if (statusCode < 200 || statusCode > 422 || json == null) {
        throw new Exception("Error while fetching data");
      }

      return {'statusCode': statusCode, 'data': res};
    });
  }

  Future<String?> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      print('No Internet Connection');
      _internetStatus.sink.add('No Internet Connection');
      return 'No Internet Connection';
    }
    return null;
  }

//   Future<CountryToken> getCountryToken({context}) {
//     String url = "https://www.universal-tutorial.com/api/getaccesstoken";
//     var headers = {
//       "Accept": "application/json",
//       "api-token":
//           "HlAv4_o-wyyqxruJH9xSARozTavCiOcCNA7ubUJ7VUg-fMCD1i43JLv_NKbQc5JG7m4",
//       "user-email": "arowolojoshuao@gmail.com"
//     };
//     return http
//         .get(Uri.parse(url), headers: headers)
//         .then((http.Response response) {
//       final String res = response.body;
//       final int statusCode = response.statusCode;

//       if (statusCode < 200 || statusCode > 422 || json == null) {
//         throw new Exception("Error while fetching data");
//       }
//       dynamic parsedJson = jsonDecode(res);
//       CountryToken countryToken = CountryToken.fromJson(parsedJson);

//       return countryToken;
//     });
//   }

//   Future<List<CountryModel>> getCountries({context}) async {
//     String url = "https://www.universal-tutorial.com/api/countries/";
//     SharedData _pref = SharedData();
//     var countryToken = await _pref.getCountryToken();
//     var headers = {
//       HttpHeaders.authorizationHeader: "Bearer $countryToken",
// //      "Authorization": "Bearer $countryToken",
//       "Accept": "application/json",
//     };

//     return http
//         .get(Uri.parse(url), headers: headers)
//         .then((http.Response response) {
//       final String res = response.body;
//       final int statusCode = response.statusCode;

//       if (statusCode < 200 || statusCode > 422 || json == null) {
//         throw new Exception("Error while fetching data");
//       }
//       List result = jsonDecode(res);
//       List<CountryModel> countries =
//           result.map((country) => CountryModel.fromJson(country)).toList();

//       return countries;
//     });
//   }

//   Future<List<StateModel>> getStates({context, required url}) async {
// //    String url = "https://www.universal-tutorial.com/api/countries/";
//     SharedData _pref = SharedData();
//     var countryToken = await _pref.getCountryToken();
//     var headers = {
//       HttpHeaders.authorizationHeader: "Bearer $countryToken",
//       "Accept": "application/json",
//     };

//     return http
//         .get(Uri.parse(url), headers: headers)
//         .then((http.Response response) {
//       final String res = response.body;
//       final int statusCode = response.statusCode;

//       if (statusCode < 200 || statusCode > 422 || json == null) {
//         throw new Exception("Error while fetching data");
//       }
//       List result = jsonDecode(res);
//       List<StateModel> states =
//           result.map((state) => StateModel.fromJson(state)).toList();
//       return states;
//     });
//   }

//   Future<List<CityModel>> getCities({context, required url}) async {
//     SharedData _pref = SharedData();
//     var countryToken = await _pref.getCountryToken();
//     var headers = {
//       HttpHeaders.authorizationHeader: "Bearer $countryToken",
//       "Accept": "application/json",
//     };

//     return http
//         .get(Uri.parse(url), headers: headers)
//         .then((http.Response response) {
//       final String res = response.body;
//       final int statusCode = response.statusCode;

//       if (statusCode < 200 || statusCode > 422 || json == null) {
//         throw new Exception("Error while fetching data");
//       }
//       List result = jsonDecode(res);
//       List<CityModel> cities =
//           result.map((city) => CityModel.fromJson(city)).toList();
//       return cities;
//     });
//   }

  Future<dynamic> getAllMusics({context}) async {
    String url = UiData.domain + "/a1/songs/my-music";
    token = await getTokken();
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Accept": "application/json"
    };

    return http
        .get(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      // print(res);

      var resToString = jsonDecode(res);
      if (resToString["status"] == false && json == null) {
        throw new Exception("Error while fetching data");
      }
      Iterable list = resToString['data'];
      print(list);

      List<MusicModel> musics =
          list.map((music) => MusicModel.fromJson(music)).toList();

      return musics;
    });
  }

  Future<dynamic> getSIngleTracksOnly({context}) async {
    String url = UiData.domain + "/a1/songs/single-release-only";
    token = await getTokken();
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Accept": "application/json"
    };

    return http
        .get(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      // print(res);

      var resToString = jsonDecode(res);
      if (resToString["status"] == false && json == null) {
        throw new Exception("Error while fetching data");
      }
      Iterable list = resToString['data'];
      // print(list);

      List<MusicModel> musics =
          list.map((music) => MusicModel.fromJson(music)).toList();

      return musics;
    });
  }

  // Future<dynamic> getAllArtists({context}) async {
  //   String url = UiData.domain + "/r1/record-label-artist/view-all-artists";
  //   token = await getTokken();
  //   var headers = {
  //     HttpHeaders.authorizationHeader: "Bearer $token",
  //     "Accept": "application/json"
  //   };
  //   return http
  //       .get(Uri.parse(url), headers: headers)
  //       .then((http.Response response) {
  //     final String res = response.body;
  //     print(res);

  //     var resToString = jsonDecode(res);

  //     if (resToString["status"] == false && json == null) {
  //       throw new Exception("Error while fetching data");
  //     }
  //     Iterable list = resToString['body'];
  //     print(list);

  //     List<ArtistModel> musics =
  //         list.map((artist) => ArtistModel.fromJson(artist)).toList();

  //     return musics;
  //   });
  // }

  //

  Future<NewlyAddedArtist> getAttachedRecordLabel({context}) async {
    String url = UiData.domain + "/a1/record-label/is-newly-added";
    token = await getTokken();
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Accept": "application/json"
    };
    return http
        .get(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      print(res);

      var resToString = jsonDecode(res);

      if (resToString["status"] == false && json == null) {
        throw new Exception("Error while fetching data");
      }

      NewlyAddedArtist result = NewlyAddedArtist.fromJson(resToString['data']);
      return result;
    });
  }

/*
* Map Artist to Record Label
* */
  // addArtist(Map<String, dynamic> params, context) async {
  //   _showProgress.add(true);
  //   var response = await post(
  //       UiData.domain + "/r1/record-label-artist/add-artist",
  //       body: params,
  //       context: context);
  //   var res = jsonDecode(response);
  //   if (res['status'] == true) {
  //     showToast(res['message'], context);
  //     Navigator.pushReplacement(
  //         context,
  //         new MaterialPageRoute(
  //             builder: (context) => new RecordLabelDashboard()));
  //     showToast(res['message'], context);
  //     // snackBar.add(res['message']);
  //   } else {
  //     showToast("Something went wrong, please try again later.", context);
  //     // snackBar.add('Something went wrong, please try again later.');
  //     return;
  //   }
  // }

  approveRecordLabel(Map<String, dynamic> params, context) async {
    _showProgress.add(true);
    var response = await post(UiData.domain + "/a1/record-label/confirm",
        body: params, context: context);
    var res = jsonDecode(response);
    if (res['status'] == true) {
      showToast(res['message'], context);
      Navigator.pushReplacement(context,
          new MaterialPageRoute(builder: (context) => new Dashboard()));
      showToast(res['message'], context);
      // snackBar.add(res['message']);
    } else {
      showToast("Something went wrong, please try again later.", context);
      // snackBar.add('Something went wrong, please try again later.');
      return;
    }
  }

  Future<dynamic> getRecordLabelDetails({context}) async {
    String url = UiData.domain + "/a1/record-label/is-newly-added";
    token = await getTokken();
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Accept": "application/json"
    };
    return http
        .get(Uri.parse(url), headers: headers)
        .then((http.Response response) {
      final String res = response.body;
      var resToString = jsonDecode(res);
      if (resToString["status"] == false) {
        showToast(resToString['message'], context);
        return resToString;
        // throw new Exception("Error while fetching data");
      }
      dynamic data = resToString['data'];
      return data;
    });
  }

  dispose() {
    _internetStatus.close();
    snackBar.close();
    _showProgress.close();
  }
}

final networkBloc = NetworkRequest();
