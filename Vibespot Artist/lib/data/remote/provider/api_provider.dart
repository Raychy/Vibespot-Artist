import "dart:async";
 
import 'package:flutter/material.dart';
import 'package:vsartist/core/utils/exception_formater.dart'; 

import 'api_request.dart';
import 'api_response.dart';

abstract class ApiProvider with ExceptionFormater {

  Future<ApiResponse<ResponseType, InnerType>> send<ResponseType, InnerType>(
      ApiRequest<ResponseType, InnerType> request);
}
