// GENERATED CODE - DO NOT MODIFY BY HAND

part of country;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Country> _$countrySerializer = new _$CountrySerializer();

class _$CountrySerializer implements StructuredSerializer<Country> {
  @override
  final Iterable<Type> types = const [Country, _$Country];
  @override
  final String wireName = 'Country';

  @override
  Iterable<Object?> serialize(Serializers serializers, Country object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'country_name',
      serializers.serialize(object.countryName,
          specifiedType: const FullType(String)),
      'country_short_name',
      serializers.serialize(object.countryShortName,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.countryPhoneCode;
    if (value != null) {
      result
        ..add('country_phone_code')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Country deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CountryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'country_name':
          result.countryName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'country_short_name':
          result.countryShortName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'country_phone_code':
          result.countryPhoneCode = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$Country extends Country {
  @override
  final String countryName;
  @override
  final String countryShortName;
  @override
  final int? countryPhoneCode;

  factory _$Country([void Function(CountryBuilder)? updates]) =>
      (new CountryBuilder()..update(updates)).build();

  _$Country._(
      {required this.countryName,
      required this.countryShortName,
      this.countryPhoneCode})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        countryName, 'Country', 'countryName');
    BuiltValueNullFieldError.checkNotNull(
        countryShortName, 'Country', 'countryShortName');
  }

  @override
  Country rebuild(void Function(CountryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CountryBuilder toBuilder() => new CountryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Country &&
        countryName == other.countryName &&
        countryShortName == other.countryShortName &&
        countryPhoneCode == other.countryPhoneCode;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, countryName.hashCode), countryShortName.hashCode),
        countryPhoneCode.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Country')
          ..add('countryName', countryName)
          ..add('countryShortName', countryShortName)
          ..add('countryPhoneCode', countryPhoneCode))
        .toString();
  }
}

class CountryBuilder implements Builder<Country, CountryBuilder> {
  _$Country? _$v;

  String? _countryName;
  String? get countryName => _$this._countryName;
  set countryName(String? countryName) => _$this._countryName = countryName;

  String? _countryShortName;
  String? get countryShortName => _$this._countryShortName;
  set countryShortName(String? countryShortName) =>
      _$this._countryShortName = countryShortName;

  int? _countryPhoneCode;
  int? get countryPhoneCode => _$this._countryPhoneCode;
  set countryPhoneCode(int? countryPhoneCode) =>
      _$this._countryPhoneCode = countryPhoneCode;

  CountryBuilder();

  CountryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _countryName = $v.countryName;
      _countryShortName = $v.countryShortName;
      _countryPhoneCode = $v.countryPhoneCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Country other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Country;
  }

  @override
  void update(void Function(CountryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Country build() {
    final _$result = _$v ??
        new _$Country._(
            countryName: BuiltValueNullFieldError.checkNotNull(
                countryName, 'Country', 'countryName'),
            countryShortName: BuiltValueNullFieldError.checkNotNull(
                countryShortName, 'Country', 'countryShortName'),
            countryPhoneCode: countryPhoneCode);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
