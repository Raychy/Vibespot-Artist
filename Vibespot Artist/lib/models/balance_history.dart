library balance_history;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'balance_history.g.dart';

abstract class BalanceHistory
    implements Built<BalanceHistory, BalanceHistoryBuilder> {
  BalanceHistory._();

  factory BalanceHistory([updates(BalanceHistoryBuilder b)]) = _$BalanceHistory;

  @BuiltValueField(wireName: 'type')
  String get type;
  @BuiltValueField(wireName: 'old_balance')
  String get oldBalance;
  @BuiltValueField(wireName: 'new_balance')
  String get newBalance;
  String toJson() {
    return json
        .encode(serializers.serializeWith(BalanceHistory.serializer, this));
  }

  static BalanceHistory? fromJson(String jsonString) {
    return serializers.deserializeWith(
        BalanceHistory.serializer, json.decode(jsonString));
  }

  static Serializer<BalanceHistory> get serializer =>
      _$balanceHistorySerializer;
}
