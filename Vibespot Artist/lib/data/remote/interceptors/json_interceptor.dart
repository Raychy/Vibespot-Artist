import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter/foundation.dart';
import 'package:vsartist/constants/strings.dart';
import 'package:vsartist/core/utils/logger.dart';
import 'package:vsartist/data/remote/provider/api_request.dart';
import 'package:vsartist/data/remote/provider/api_response.dart';
import 'package:vsartist/models/error_model.dart';
import 'package:vsartist/models/pagination.dart';
import 'package:vsartist/models/serializers.dart';

import 'api_interceptor.dart';

class JsonInterceptor<ErrorType> implements ApiInterceptor {
  static T? _deserialize<T>(dynamic value) {
    // print('pagination $value ${value.runtimeType}');
    if (value is T) return value;
    return serializers.deserializeWith<T>(
      serializers.serializerForType(T) as Serializer<T>,
      value,
    );
  }

  static BuiltList<T> _deserializeListOf<T>(Iterable value) => BuiltList(
        value.map((value) => _deserialize<T>(value)).toList(growable: false),
      );

  static dynamic _decode<T>(entity) {
    // print('pagination ${entity.runtimeType}, $T $entity}');

    /// handle case when we want to access to Map<String, dynamic> directly
    /// getResource or getMapResource
    /// Avoid dynamic or unconverted value, this could lead to several issues
    // if (entity is T) return entity;
    try {
      if (entity is List) return _deserializeListOf<T>(entity);
      return _deserialize<T>(entity);
    } catch (e) {
      if (kDebugMode) print(e);
      return null;
    }
  }

  static dynamic _getBody(dynamic body, [String? key = '']) {
    if (kDebugMode) print('get body, $key');
    try {
      if (key == '') return body;
      return body[key] ?? body;
    } catch (e) {
      return body;
    }
  }

  ///convert a  json string  to a builtvalue  with type [ResultType]
  static ResultType? convertFromJson<ResultType, Item>(dynamic data,
      [String? key]) {
    try {
      if (data is String) data = json.decode(data);
    } catch (e) {
    if (kDebugMode) print('in convert fromjson, error $key, $data');
    }
    if (kDebugMode) print('in convert fromjson $key, $data');
    return _decode<Item>(_getBody(data, key));
  }

  ///convert a value to a json encoded string
  static dynamic convertToJson(dynamic data) {
    return json.encode(_encode(data));
  }

  static dynamic _serialize<T>(dynamic value) => serializers.serializeWith(
      serializers.serializerForType(value.runtimeType)!, value);

  static List<T> _serializeListOf<T>(BuiltList value) => List.castFrom(
        value.map((value) => _serialize<T>(value)).toList(growable: false),
      );

  static dynamic _encode<T>(entity) {
    /// handle case when we want to access to Map<String, dynamic> directly
    /// getResource or getMapResource
    /// Avoid dynamic or unconverted value, this could lead to several issues
    if (entity is String) return entity;

    try {
      if (entity is BuiltList) return _serializeListOf<T>(entity);
      return _serialize<T>(entity);
    } catch (e) {
      if (kDebugMode) print(e);
      return null;
    }
  }

  Pagination? _parsePagination(jsn) {
    return _decode<Pagination>(_getBody(jsn, ''));
  }

  @override
  ApiResponse<ResponseType, InnerType> onResponse<ResponseType, InnerType>(
      ApiResponse<ResponseType, InnerType> response) {
    Log.d(
        'in convert response ${response.bodyString.runtimeType}, ${response.bodyString}');

    var jsn = _tryDecodeJson(response.bodyString);
    Pagination? pagination;

    if (response.request?.nestedKey != null &&
        (response.request?.nestedKey?.isNotEmpty ?? false)) {
      jsn = _getBody(jsn, response.request?.nestedKey);
    }

// decode pagination
    if (response.request?.hasPagination ?? false) {
      pagination = _parsePagination(jsn);
    }
    if (kDebugMode) Log.d('in convert response ${jsn.runtimeType}, $jsn');

    final body = _decode<InnerType>(_getBody(jsn, response.request?.dataKey));
    if (kDebugMode) Log.d(body?.toString());

    return response.copyWith(body: body, pagination: pagination);
  }

  dynamic _tryDecodeJson(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (kDebugMode) print(data.runtimeType);
    try {
      return jsonDecode(data.toString());
    } catch (e) {
      Log.e(e.toString());
      return data;
    }
  }

  BuiltMap<String, String>? _validationError(Map<String, dynamic>? body) {
    var err = <String, String>{};
    if (body != null) {
      body.entries.forEach((e) {
        print(e);
        print(e.key);
        if (e.value is List &&
            e.value.length > 0 &&
            (e.value as List)[0] is String)
          err.addAll({e.key: (e.value as List)[0] as String});
      });
    }
    print(err);

    return err.isNotEmpty ? BuiltMap<String, String>.from(err) : null;
  }

  @override
  ApiResponse<ResponseType, InnerType> onError<ResponseType, InnerType>(
      ApiResponse<ResponseType, InnerType> response) {
    if (kDebugMode)
      Log.i(
          'in convert error ${response.bodyString}, ${response.error?.runtimeType}, ${response.error?.runtimeType is ErrorModel}');

    if (response.error != null) return response.copyWith(error: response.error);

    var json = _tryDecodeJson(response.bodyString);

    json = _getBody(json, response.request?.error?.key);
    var body = _decode<ErrorType>(json) ??
        ErrorModel((b) => b..message = Strings.DEFAULT_ERROR_MESSAGE);

    var _validation = _validationError(json);

    // print('_validation: $_validation ${_validation?.isNotEmpty}');
    // if (_validation?.isNotEmpty ?? false)
    //   body = (body as ErrorModel)
    //       .rebuild((b) => b..errors = _validation?.toBuilder());
    if (kDebugMode) Log.i('in convert error $body, }');
    // var error = ErrorModel((b) => b..errors = body);
    return response.copyWith(error: body);
  }

  @override
  ApiRequest<ResponseType, InnerType> onRequest<ResponseType, InnerType>(
      ApiRequest<ResponseType, InnerType> request) {
    return request;
  }
}
