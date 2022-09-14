
import 'package:flutter/foundation.dart';
import 'package:vsartist/data/remote/provider/api_request.dart';

import 'api_interceptor.dart'; 

/// an interceptor to add headers to a request before initiating it
class HeaderInterceptor extends ApiInterceptor {
  final Map<String, String> headers;

  HeaderInterceptor(this.headers);
  @override
  ApiRequest<ResponseType, InnerType> onRequest<ResponseType, InnerType>(
      ApiRequest<ResponseType, InnerType> request) {
    if (kDebugMode)
      print(
          '${request.isMultipart} in headers interceptor: ${request.headers}, ');
    var headr = <String, String>{};
    headr.addAll(headers);
    headr.addAll(request.headers);
    if (kDebugMode)
      print(
          '${request.isMultipart} in headers interceptor: ${request.headers}, ');
    return request.copyWith(headers: headr);
  }
}
