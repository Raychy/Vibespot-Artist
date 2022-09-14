import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:vsartist/constants/strings.dart';
import 'package:vsartist/core/utils/exception_formater.dart';
import 'package:vsartist/core/utils/logger.dart';
import 'package:vsartist/models/error_model.dart'; 

import '../data_repository.dart';
import 'provider/api_request.dart';
import 'provider/api_response.dart';

///  for Remote Repository
class RemoteRepository with ExceptionFormater {
  /// makes a network request
  Future<ApiResponse<ResultType, Item>> handleRequest<ResultType, Item>(
      NetworkCall<ApiResponse<ResultType, Item>> networkCall,
      {int timeout = 50,
      bool retry = false}) async {
    ApiResponse<ResultType, Item> response;
    try {
      response = await networkCall().timeout(Duration(seconds: timeout),
          onTimeout: () {
        throw (TimeoutException('Connection timed out'));
      });
    } catch (e) {
      if (kDebugMode) print(' error in request ');
      if (kDebugMode) print(e.toString());
      response = ApiResponse<ResultType, Item>(
          bodyString: null,
          request: ApiRequest.dummy(),
          error: formatErrorMessage(e),
          headers: {},
          statusCode: 200);
    }
    if (kDebugMode)
      Log.d(
          'Finished request, url:${response.request?.path}, reqBody:${response.request?.body}, resBody:${response.bodyString}');
    print('${response.error}');
    return response;
  }

  ApiResponse<ResultType, Item> handleError<ResultType, Item>(
      ApiResponse<ResultType, Item> response) {
    ErrorModel? error;
    if (response.error is ErrorModel)
      error = (response.error as ErrorModel);
    else
      error = formatErrorMessage(response.error);

    if ((response.statusCode ?? 500) > 490) {
      error = ErrorModel((b) => b
        // ..statusCode = response.statusCode
        ..message = Strings.DEFAULT_ERROR_MESSAGE);
      Log.uploadLog('API Error', response.bodyString?.toString() ?? '');
    }
    return response.copyWith(error: error);
  }
}
