library pagination;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

// part 'pagination.g.dart';

abstract class Pagination implements Built<Pagination, PaginationBuilder> {
  Pagination._();

  factory Pagination([updates(PaginationBuilder b)]) = _$Pagination;

  @BuiltValueField(wireName: 'current_page')
  int get currentPage;
  @BuiltValueField(wireName: 'per_page')
  int get perPage;
  @BuiltValueField(wireName: 'to')
  int? get to;
  @BuiltValueField(wireName: 'total')
  int? get total;
  String toJson() {
    return json.encode(serializers.serializeWith(Pagination.serializer, this));
  }

  static Pagination? fromJson(String jsonString) {
    return serializers.deserializeWith(
        Pagination.serializer, json.decode(jsonString));
  }

  static Serializer<Pagination> get serializer => _$paginationSerializer;
}

Serializer<Pagination> _$paginationSerializer = new _$PaginationSerializer();

class _$PaginationSerializer implements StructuredSerializer<Pagination> {
  @override
  final Iterable<Type> types = const [Pagination, _$Pagination];
  @override
  final String wireName = 'Pagination';

  @override
  Iterable<Object?> serialize(Serializers serializers, Pagination object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'current_page',
      serializers.serialize(object.currentPage,
          specifiedType: const FullType(int)),
      'per_page',
      serializers.serialize(object.perPage, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.to;
    if (value != null) {
      result
        ..add('to')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.total;
    if (value != null) {
      result
        ..add('total')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    return result;
  }

  @override
  Pagination deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PaginationBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      var value = iterator.current;
      if (value is String) value = int.tryParse(value);
      switch (key) {
        case 'current_page':
          result.currentPage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'per_page':
          result.perPage = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'to':
          result.to = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'total':
          result.total = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
      }
    }

    return result.build();
  }
}

class _$Pagination extends Pagination {
  @override
  final int currentPage;
  @override
  final int perPage;
  @override
  final int? to;
  @override
  final int? total;

  factory _$Pagination([void Function(PaginationBuilder)? updates]) =>
      (new PaginationBuilder()..update(updates)).build();

  _$Pagination._(
      {required this.currentPage, required this.perPage, this.to, this.total})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        currentPage, 'Pagination', 'currentPage');
    BuiltValueNullFieldError.checkNotNull(perPage, 'Pagination', 'perPage');
  }

  @override
  Pagination rebuild(void Function(PaginationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PaginationBuilder toBuilder() => new PaginationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Pagination &&
        currentPage == other.currentPage &&
        perPage == other.perPage &&
        to == other.to &&
        total == other.total;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, currentPage.hashCode), perPage.hashCode), to.hashCode),
        total.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Pagination')
          ..add('currentPage', currentPage)
          ..add('perPage', perPage)
          ..add('to', to)
          ..add('total', total))
        .toString();
  }
}

class PaginationBuilder implements Builder<Pagination, PaginationBuilder> {
  _$Pagination? _$v;

  int? _currentPage;
  int? get currentPage => _$this._currentPage;
  set currentPage(int? currentPage) => _$this._currentPage = currentPage;

  int? _perPage;
  int? get perPage => _$this._perPage;
  set perPage(int? perPage) => _$this._perPage = perPage;

  int? _to;
  int? get to => _$this._to;
  set to(int? to) => _$this._to = to;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  PaginationBuilder();

  PaginationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currentPage = $v.currentPage;
      _perPage = $v.perPage;
      _to = $v.to;
      _total = $v.total;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Pagination other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Pagination;
  }

  @override
  void update(void Function(PaginationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Pagination build() {
    final _$result = _$v ??
        new _$Pagination._(
            currentPage: BuiltValueNullFieldError.checkNotNull(
                currentPage, 'Pagination', 'currentPage'),
            perPage: BuiltValueNullFieldError.checkNotNull(
                perPage, 'Pagination', 'perPage'),
            to: to,
            total: total);
    replace(_$result);
    return _$result;
  }
}
