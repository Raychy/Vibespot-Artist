library song;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'song.g.dart';

abstract class Song implements Built<Song, SongBuilder> {
  Song._();

  factory Song([updates(SongBuilder b)]) = _$Song;


  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'track_id')
  int? get trackId;
  @BuiltValueField(wireName: 'user_id')
  int? get userId;
  @BuiltValueField(wireName: 'release_id')
  int? get releaseId;
  @BuiltValueField(wireName: 'album_id')
  int? get albumId;
  @BuiltValueField(wireName: 'slug')
  String? get slug;
  @BuiltValueField(wireName: 'title')
  String get title;
  @BuiltValueField(wireName: 'featured_by')
  String? get featuredBy;
  @BuiltValueField(wireName: 'produced_by')
  String? get producedBy;
  @BuiltValueField(wireName: 'description')
  String? get description;
  @BuiltValueField(wireName: 'genre')
  String? get genre;
  @BuiltValueField(wireName: 'country')
  String? get country;
  @BuiltValueField(wireName: 'state')
  String? get state;
  @BuiltValueField(wireName: 'push_state')
  String? get pushState;
  @BuiltValueField(wireName: 'push_city')
  String? get pushCity;
  @BuiltValueField(wireName: 'release_date')
  String? get releaseDate;
  @BuiltValueField(wireName: 'image')
  String? get image;
  @BuiltValueField(wireName: 'song')
  String? get song;
  @BuiltValueField(wireName: 'song_image')
  String? get songImage;
  @BuiltValueField(wireName: 'duration')
  String? get duration;
  // @BuiltValueField(wireName: 'stream')
  // int? get stream;
  @BuiltValueField(wireName: 'streamed')
  int? get streamed;
  // @BuiltValueField(wireName: 'amount')
  // int? get amount;
  @BuiltValueField(wireName: 'verification_status')
  int? get verificationStatus;
  @BuiltValueField(wireName: 'status')
  int? get status;
  @BuiltValueField(wireName: 'created_at')
  String? get createdAt;
  @BuiltValueField(wireName: 'push_country')
  String? get pushCountry;
  @BuiltValueField(wireName: 'push_latitude')
  String? get pushLatitude;
  @BuiltValueField(wireName: 'push_longitude')
  String? get pushLongitude;
      @BuiltValueField(wireName: 'dynamic_link_url')
  String? get dynamicLinkUrl;
  
  String toJson() {
    return json.encode(serializers.serializeWith(Song.serializer, this));
  }

  static Song? fromJson(String jsonString) {
    return serializers.deserializeWith(
        Song.serializer, json.decode(jsonString));
  }

  static Serializer<Song> get serializer => _$songSerializer;
}
