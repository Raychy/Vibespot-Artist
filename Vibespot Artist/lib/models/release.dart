library release;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';
import 'song.dart';

part 'release.g.dart';

abstract class Release implements Built<Release, ReleaseBuilder> {
  Release._();

  factory Release([updates(ReleaseBuilder b)]) = _$Release;

  @BuiltValueField(wireName: 'release_name')
  String get releaseName;
  @BuiltValueField(wireName: 'release_date')
  String? get releaseDate;
  @BuiltValueField(wireName: 'created_at')
  String? get createdAt;
  @BuiltValueField(wireName: 'user_id')
  int? get userId;
  @BuiltValueField(wireName: 'publish')
  int? get publish;
  // @BuiltValueField(wireName: 'amount_expected')
  // num? get amountExpected;
  @BuiltValueField(wireName: 'track_count')
  int? get trackCount;
  @BuiltValueField(wireName: 'id')
  int get id;
  @BuiltValueField(wireName: 'tracks')
  BuiltList<Song>? get tracks;
  @BuiltValueField(wireName: 'image_url')
  String? get imageUrl;
  

  Song? get track {
    if (tracks == null || tracks!.isEmpty) {
      return null;
    }
    return tracks!.first;
  }

  String toJson() {
    return json.encode(serializers.serializeWith(Release.serializer, this));
  }

  static Release? fromJson(String jsonString) {
    return serializers.deserializeWith(
        Release.serializer, json.decode(jsonString));
  }

  static Serializer<Release> get serializer => _$releaseSerializer;
}
