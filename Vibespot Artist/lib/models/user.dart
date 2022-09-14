library user;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

part 'user.g.dart';

abstract class User implements Built<User, UserBuilder> {
  User._();

  factory User([updates(UserBuilder b)]) = _$User;

  @BuiltValueField(wireName: 'id')
  num? get id;
  @BuiltValueField(wireName: 'username')
  String? get username;
  @BuiltValueField(wireName: 'email')
  String get email;
  @BuiltValueField(wireName: 'phone')
  String? get phone;
  @BuiltValueField(wireName: 'image')
  String? get image;
  @BuiltValueField(wireName: 'email_verified')
  bool? get emailVerified;
  @BuiltValueField(wireName: 'profileVerified')
  bool? get profileVerified;
  @BuiltValueField(wireName: 'state')
  String? get state;
  @BuiltValueField(wireName: 'city')
  String? get city;
  @BuiltValueField(wireName: 'country')
  String? get youtubeChannel;
  @BuiltValueField(wireName: 'youtube_channel')
  String? get country;
  @BuiltValueField(wireName: 'surname')
  String? get surname;
    @BuiltValueField(wireName: 'stage_name')
  String? get stageName;
  @BuiltValueField(wireName: 'unique_id')
  String? get uniqueId;
  @BuiltValueField(wireName: 'firstname')
  String? get firstname;
  @BuiltValueField(wireName: 'othernames')
  String? get othernames;
  @BuiltValueField(wireName: 'user_type')
  String? get userType;
  @BuiltValueField(wireName: 'artist_image')
  String? get artistImage;
  @BuiltValueField(wireName: 'updated_at')
  String? get updatedAt;
  @BuiltValueField(wireName: 'created_at')
  String? get createdAt;
    @BuiltValueField(wireName: 'wallet')
  String? get wallet;
  
  String? toJson() {
    return json.encode(serializers.serializeWith(User.serializer, this));
  }

  static User? fromJson(String jsonString) {
    try {
      return serializers.deserializeWith(
          User.serializer, json.decode(jsonString));
    } catch (e) {}
  }

  static Serializer<User> get serializer => _$userSerializer;
}
