import "dart:async";
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:vsartist/core/utils/logger.dart';
import 'package:vsartist/core/extensions/index.dart';

import '../../file_field.dart';
import '../api_methods.dart';
import '../api_provider.dart';
import '../api_request.dart';
import '../api_response.dart';

class HttpApiProvider extends ApiProvider {
  @override
  Future<ApiResponse<ResulType, InnerType>> send<ResulType, InnerType>(
      ApiRequest<ResulType, InnerType> request) async {
    request = request.build;

    http.Response response;
    print('handling request ${request.isMultipart}');
    try {
      if (request.isMultipart) {
        var res = await handleMultipart(request);
        return ApiResponse<ResulType, InnerType>(
                request: request,
                bodyString: await res.stream.bytesToString(),
                headers: res.headers,
                statusCode: res.statusCode)
            .resolve;
      }
      response = await runRequest(request)
          .timeout(Duration(seconds: request.timeout), onTimeout: () {
        throw (TimeoutException('Connection timed out'));
      });
    } catch (e) {
      if (kDebugMode) print(' error in request ');
      if (kDebugMode) print(e.toString());
      if (kDebugMode) print(e.runtimeType);
      return ApiResponse<ResulType, InnerType>(
              request: request,
              headers: {},
              statusCode: 400,
              error: formatErrorMessage(e))
          .resolve;
    }

    // print(response?.bodyBytes);

    return ApiResponse<ResulType, InnerType>(
            request: request,
            bodyString: response.body,
            headers: response.headers,
            statusCode: response.statusCode)
        .resolve;
  }

  Future<http.Response> runRequest(ApiRequest request) {
    var uri = _buildUri(request);
    if (kDebugMode) Log.i(uri.data?.toString());
    switch (request.method) {
      case ApiMethods.DELETE:
        return http.delete(uri, headers: request.headers);
      case ApiMethods.POST:
        return http.post(uri,
            headers: request.headers, body: jsonEncode(request.body));
      case ApiMethods.PUT:
        return http.put(uri,
            headers: request.headers, body: jsonEncode(request.body));
      default:
        return http.get(uri, headers: request.headers);
    }
  }

  Uri _buildUri(ApiRequest request) {
    var url = '${request.baseUrl}/${request.path}';
    if (!url.contains('?'))
      url += '?';
    else if (!url.endsWith('&')) url += '&';
    url += request.buildQuery;
    print('Uri.parse(url.normalizeUrl) ${Uri.parse(url.normalizeUrl)}');
    return Uri.parse(url.normalizeUrl);
  }

  Future<http.StreamedResponse> handleMultipart(ApiRequest request) {
    var uri = _buildUri(request);
    if (kDebugMode) Log.i(uri.data?.toString());
    http.MultipartRequest req = http.MultipartRequest(
      request.method ?? ApiMethods.GET,
      uri,
    );

    request.body?.forEach((key, value) async {
      if (value is FileFormField)
        req.files.add(await http.MultipartFile.fromPath(key, value.path));
      else
        req.fields[key] = value;
    });
    request.headers.forEach((key, value) {
      req.headers[key] = value;
    });
    return req.send();
  }
}
