library state_city;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'state_city.g.dart';

abstract class StateCity implements Built<StateCity, StateCityBuilder> {
  StateCity._();

  factory StateCity([updates(StateCityBuilder b)]) = _$StateCity;

  @BuiltValueField(wireName: 'state_name')
  String? get stateName;
  @BuiltValueField(wireName: 'city_name')
  String? get cityName;
  String toJson() {
    return json.encode(serializers.serializeWith(StateCity.serializer, this));
  }

  static StateCity? fromJson(String jsonString) {
    return serializers.deserializeWith(
        StateCity.serializer, json.decode(jsonString));
  }

  static Serializer<StateCity> get serializer => _$stateCitySerializer;
}
