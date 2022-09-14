// GENERATED CODE - DO NOT MODIFY BY HAND

part of error_model;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ErrorModel> _$errorModelSerializer = new _$ErrorModelSerializer();

class _$ErrorModelSerializer implements StructuredSerializer<ErrorModel> {
  @override
  final Iterable<Type> types = const [ErrorModel, _$ErrorModel];
  @override
  final String wireName = 'ErrorModel';

  @override
  Iterable<Object?> serialize(Serializers serializers, ErrorModel object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[];
    Object? value;
    value = object.error;
    if (value != null) {
      result
        ..add('error')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.message;
    if (value != null) {
      result
        ..add('message')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.body;
    if (value != null) {
      result
        ..add('body')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.a;
    if (value != null) {
      result
        ..add('a')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(String)])));
    }
    value = object.errors;
    if (value != null) {
      result
        ..add('errors')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(BuiltMap, const [
              const FullType(String),
              const FullType(BuiltList, const [const FullType(String)])
            ])));
    }
    return result;
  }

  @override
  ErrorModel deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ErrorModelBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'error':
          result.error = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'message':
          result.message = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'a':
          result.a.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(String)]))!
              as BuiltList<Object?>);
          break;
        case 'errors':
          result.errors.replace(serializers.deserialize(value,
              specifiedType: const FullType(BuiltMap, const [
                const FullType(String),
                const FullType(BuiltList, const [const FullType(String)])
              ]))!);
          break;
      }
    }

    return result.build();
  }
}

class _$ErrorModel extends ErrorModel {
  @override
  final String? error;
  @override
  final String? message;
  @override
  final String? body;
  @override
  final BuiltList<String>? a;
  @override
  final BuiltMap<String, BuiltList<String>>? errors;

  factory _$ErrorModel([void Function(ErrorModelBuilder)? updates]) =>
      (new ErrorModelBuilder()..update(updates)).build();

  _$ErrorModel._({this.error, this.message, this.body, this.a, this.errors})
      : super._();

  @override
  ErrorModel rebuild(void Function(ErrorModelBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ErrorModelBuilder toBuilder() => new ErrorModelBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ErrorModel &&
        error == other.error &&
        message == other.message &&
        body == other.body &&
        a == other.a &&
        errors == other.errors;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, error.hashCode), message.hashCode), body.hashCode),
            a.hashCode),
        errors.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ErrorModel')
          ..add('error', error)
          ..add('message', message)
          ..add('body', body)
          ..add('a', a)
          ..add('errors', errors))
        .toString();
  }
}

class ErrorModelBuilder implements Builder<ErrorModel, ErrorModelBuilder> {
  _$ErrorModel? _$v;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  ListBuilder<String>? _a;
  ListBuilder<String> get a => _$this._a ??= new ListBuilder<String>();
  set a(ListBuilder<String>? a) => _$this._a = a;

  MapBuilder<String, BuiltList<String>>? _errors;
  MapBuilder<String, BuiltList<String>> get errors =>
      _$this._errors ??= new MapBuilder<String, BuiltList<String>>();
  set errors(MapBuilder<String, BuiltList<String>>? errors) =>
      _$this._errors = errors;

  ErrorModelBuilder();

  ErrorModelBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _error = $v.error;
      _message = $v.message;
      _body = $v.body;
      _a = $v.a?.toBuilder();
      _errors = $v.errors?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ErrorModel other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ErrorModel;
  }

  @override
  void update(void Function(ErrorModelBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ErrorModel build() {
    _$ErrorModel _$result;
    try {
      _$result = _$v ??
          new _$ErrorModel._(
              error: error,
              message: message,
              body: body,
              a: _a?.build(),
              errors: _errors?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'a';
        _a?.build();
        _$failedField = 'errors';
        _errors?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ErrorModel', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
