// GENERATED CODE - DO NOT MODIFY BY HAND

part of state_city;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<StateCity> _$stateCitySerializer = new _$StateCitySerializer();

class _$StateCitySerializer implements StructuredSerializer<StateCity> {
  @override
  final Iterable<Type> types = const [StateCity, _$StateCity];
  @override
  final String wireName = 'StateCity';

  @override
  Iterable<Object?> serialize(Serializers serializers, StateCity object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.stateName;
    if (value != null) {
      result
        ..add('state_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.cityName;
    if (value != null) {
      result
        ..add('city_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  StateCity deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new StateCityBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'state_name':
          result.stateName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'city_name':
          result.cityName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$StateCity extends StateCity {
  @override
  final String? stateName;
  @override
  final String? cityName;

  factory _$StateCity([void Function(StateCityBuilder)? updates]) =>
      (new StateCityBuilder()..update(updates)).build();

  _$StateCity._({this.stateName, this.cityName}) : super._();

  @override
  StateCity rebuild(void Function(StateCityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StateCityBuilder toBuilder() => new StateCityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StateCity &&
        stateName == other.stateName &&
        cityName == other.cityName;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, stateName.hashCode), cityName.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('StateCity')
          ..add('stateName', stateName)
          ..add('cityName', cityName))
        .toString();
  }
}

class StateCityBuilder implements Builder<StateCity, StateCityBuilder> {
  _$StateCity? _$v;

  String? _stateName;
  String? get stateName => _$this._stateName;
  set stateName(String? stateName) => _$this._stateName = stateName;

  String? _cityName;
  String? get cityName => _$this._cityName;
  set cityName(String? cityName) => _$this._cityName = cityName;

  StateCityBuilder();

  StateCityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _stateName = $v.stateName;
      _cityName = $v.cityName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StateCity other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$StateCity;
  }

  @override
  void update(void Function(StateCityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$StateCity build() {
    final _$result =
        _$v ?? new _$StateCity._(stateName: stateName, cityName: cityName);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
