import 'package:flutter/foundation.dart'; 
import 'package:vsartist/data/remote/provider/api_response.dart';

import 'api_interceptor.dart';
import 'json_interceptor.dart';

class TokenInterceptor extends ApiInterceptor {
  @override
  ApiResponse<ResponseType, InnerType> onResponse<ResponseType, InnerType>(
      ApiResponse<ResponseType, InnerType> response) {
    if (kDebugMode) print('in TokenInterceptor ${response.statusCode}');
    if (response.isSuccessful) {
      var data = JsonInterceptor.convertFromJson<Map<String, dynamic>,
          Map<String, dynamic>>(response.bodyString, 'data');
      var token =
          JsonInterceptor.convertFromJson<String, String>(data, 'token');
      if (kDebugMode) print('in TokenInterceptor  $token $data');
      return response.copyWith(
          extra: <String, dynamic>{'token': token, ...?response.extra});
    }

    return response;
  }
}
