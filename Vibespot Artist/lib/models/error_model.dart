library error_model;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'error_model.g.dart';

abstract class ErrorModel implements Built<ErrorModel, ErrorModelBuilder> {
  ErrorModel._();

  factory ErrorModel([updates(ErrorModelBuilder b)]) = _$ErrorModel;

  // @BuiltValueField(wireName: 'status')
  // bool get status;
  @BuiltValueField(wireName: 'error')
  String? get error;
  @BuiltValueField(wireName: 'message')
  String? get message;
  @BuiltValueField(wireName: 'body')
  String? get body;
  ///dummy field to enable generator generate extra BuiltList<String> serializer
   @BuiltValueField(wireName: 'a')
  BuiltList<String>? get a;
  @BuiltValueField(wireName: 'errors')
  BuiltMap<String, BuiltList<String>>? get errors;
  String toJson() {
    return json.encode(serializers.serializeWith(ErrorModel.serializer, this));
  }

  static ErrorModel? fromJson(String jsonString) {
    return serializers.deserializeWith(
        ErrorModel.serializer, json.decode(jsonString));
  }

  static Serializer<ErrorModel> get serializer => _$errorModelSerializer;
}
