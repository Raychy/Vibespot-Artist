library playlist;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'playlist.g.dart';

abstract class Playlist implements Built<Playlist, PlaylistBuilder> {
  Playlist._();

  factory Playlist([updates(PlaylistBuilder b)]) = _$Playlist;

  @BuiltValueField(wireName: 'id')
  num get id;
  @BuiltValueField(wireName: 'track_id')
  num? get trackId;
  @BuiltValueField(wireName: 'song')
  String? get song;
  @BuiltValueField(wireName: 'image')
  String? get image;
  @BuiltValueField(wireName: 'title')
  String get title;
  @BuiltValueField(wireName: 'genre')
  String? get genre;
  @BuiltValueField(wireName: 'stage_name')
  String? get stageName;
  @BuiltValueField(wireName: 'artist_id')
  num? get artistId;
      @BuiltValueField(wireName: 'dynamic_link_url')
  String? get dynamicLinkUrl;
  String toJson() {
    return json.encode(serializers.serializeWith(Playlist.serializer, this));
  }

  static Playlist? fromJson(String jsonString) {
    return serializers.deserializeWith(
        Playlist.serializer, json.decode(jsonString));
  }

  static Serializer<Playlist> get serializer => _$playlistSerializer;
}
