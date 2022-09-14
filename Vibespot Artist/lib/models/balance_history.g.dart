// GENERATED CODE - DO NOT MODIFY BY HAND

part of balance_history;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BalanceHistory> _$balanceHistorySerializer =
    new _$BalanceHistorySerializer();

class _$BalanceHistorySerializer
    implements StructuredSerializer<BalanceHistory> {
  @override
  final Iterable<Type> types = const [BalanceHistory, _$BalanceHistory];
  @override
  final String wireName = 'BalanceHistory';

  @override
  Iterable<Object?> serialize(Serializers serializers, BalanceHistory object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'old_balance',
      serializers.serialize(object.oldBalance,
          specifiedType: const FullType(String)),
      'new_balance',
      serializers.serialize(object.newBalance,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  BalanceHistory deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BalanceHistoryBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'type':
          result.type = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'old_balance':
          result.oldBalance = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'new_balance':
          result.newBalance = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$BalanceHistory extends BalanceHistory {
  @override
  final String type;
  @override
  final String oldBalance;
  @override
  final String newBalance;

  factory _$BalanceHistory([void Function(BalanceHistoryBuilder)? updates]) =>
      (new BalanceHistoryBuilder()..update(updates)).build();

  _$BalanceHistory._(
      {required this.type, required this.oldBalance, required this.newBalance})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(type, 'BalanceHistory', 'type');
    BuiltValueNullFieldError.checkNotNull(
        oldBalance, 'BalanceHistory', 'oldBalance');
    BuiltValueNullFieldError.checkNotNull(
        newBalance, 'BalanceHistory', 'newBalance');
  }

  @override
  BalanceHistory rebuild(void Function(BalanceHistoryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BalanceHistoryBuilder toBuilder() =>
      new BalanceHistoryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BalanceHistory &&
        type == other.type &&
        oldBalance == other.oldBalance &&
        newBalance == other.newBalance;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, type.hashCode), oldBalance.hashCode), newBalance.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BalanceHistory')
          ..add('type', type)
          ..add('oldBalance', oldBalance)
          ..add('newBalance', newBalance))
        .toString();
  }
}

class BalanceHistoryBuilder
    implements Builder<BalanceHistory, BalanceHistoryBuilder> {
  _$BalanceHistory? _$v;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _oldBalance;
  String? get oldBalance => _$this._oldBalance;
  set oldBalance(String? oldBalance) => _$this._oldBalance = oldBalance;

  String? _newBalance;
  String? get newBalance => _$this._newBalance;
  set newBalance(String? newBalance) => _$this._newBalance = newBalance;

  BalanceHistoryBuilder();

  BalanceHistoryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _type = $v.type;
      _oldBalance = $v.oldBalance;
      _newBalance = $v.newBalance;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BalanceHistory other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$BalanceHistory;
  }

  @override
  void update(void Function(BalanceHistoryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BalanceHistory build() {
    final _$result = _$v ??
        new _$BalanceHistory._(
            type: BuiltValueNullFieldError.checkNotNull(
                type, 'BalanceHistory', 'type'),
            oldBalance: BuiltValueNullFieldError.checkNotNull(
                oldBalance, 'BalanceHistory', 'oldBalance'),
            newBalance: BuiltValueNullFieldError.checkNotNull(
                newBalance, 'BalanceHistory', 'newBalance'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
