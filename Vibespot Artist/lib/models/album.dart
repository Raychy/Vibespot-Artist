library album;

import 'dart:convert';

import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

import 'serializers.dart';

// part 'album.g.dart';

abstract class Album implements Built<Album, AlbumBuilder> {
  Album._();

  factory Album([updates(AlbumBuilder b)]) = _$Album;

  @BuiltValueField(wireName: 'title')
  String get title;
  @BuiltValueField(wireName: 'description')
  String get description;
  @BuiltValueField(wireName: 'track_count')
  int? get trackCount;
  @BuiltValueField(wireName: 'release_date')
  String? get releaseDate;
  @BuiltValueField(wireName: 'image')
  String? get image;
  @BuiltValueField(wireName: 'user_id')
  int? get userId;
  @BuiltValueField(wireName: 'publish')
  int? get publish;
  @BuiltValueField(wireName: 'slug')
  String? get slug;
  @BuiltValueField(wireName: 'amount_expected')
  num? get amountExpected;
  @BuiltValueField(wireName: 'id')
  int? get id;
  @BuiltValueField(wireName: 'album_image')
  String? get albumImage;
  @BuiltValueField(wireName: 'dynamic_link_url')
  String? get dynamicLinkUrl;
  String toJson() {
    return json.encode(serializers.serializeWith(Album.serializer, this));
  }

  static Album? fromJson(String jsonString) {
    return serializers.deserializeWith(
        Album.serializer, json.decode(jsonString));
  }

  static Serializer<Album> get serializer => _$albumSerializer;
}

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Album> _$albumSerializer = new _$AlbumSerializer();

class _$AlbumSerializer implements StructuredSerializer<Album> {
  @override
  final Iterable<Type> types = const [Album, _$Album];
  @override
  final String wireName = 'Album';

  @override
  Iterable<Object?> serialize(Serializers serializers, Album object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.trackCount;
    if (value != null) {
      result
        ..add('track_count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.releaseDate;
    if (value != null) {
      result
        ..add('release_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.image;
    if (value != null) {
      result
        ..add('image')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.publish;
    if (value != null) {
      result
        ..add('publish')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.slug;
    if (value != null) {
      result
        ..add('slug')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.amountExpected;
    if (value != null) {
      result
        ..add('amount_expected')
        ..add(serializers.serialize(value, specifiedType: const FullType(num)));
    }
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.albumImage;
    if (value != null) {
      result
        ..add('album_image')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.dynamicLinkUrl;
    if (value != null) {
      result
        ..add('dynamic_link_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Album deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AlbumBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'track_count':
          var val = value;
          if (value is String) val = int.tryParse(value);
          result.trackCount = serializers.deserialize(val,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'release_date':
          result.releaseDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'publish':
          result.publish = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'slug':
          result.slug = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'amount_expected':
          result.amountExpected = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'album_image':
          result.albumImage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'dynamic_link_url':
          result.dynamicLinkUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$Album extends Album {
  @override
  final String title;
  @override
  final String description;
  @override
  final int? trackCount;
  @override
  final String? releaseDate;
  @override
  final String? image;
  @override
  final int? userId;
  @override
  final int? publish;
  @override
  final String? slug;
  @override
  final num? amountExpected;
  @override
  final int? id;
  @override
  final String? albumImage;
  @override
  final String? dynamicLinkUrl;

  factory _$Album([void Function(AlbumBuilder)? updates]) =>
      (new AlbumBuilder()..update(updates)).build();

  _$Album._(
      {required this.title,
      required this.description,
      this.trackCount,
      this.releaseDate,
      this.image,
      this.userId,
      this.publish,
      this.slug,
      this.amountExpected,
      this.id,
      this.albumImage,
      this.dynamicLinkUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(title, 'Album', 'title');
    BuiltValueNullFieldError.checkNotNull(description, 'Album', 'description');
  }

  @override
  Album rebuild(void Function(AlbumBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AlbumBuilder toBuilder() => new AlbumBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Album &&
        title == other.title &&
        description == other.description &&
        trackCount == other.trackCount &&
        releaseDate == other.releaseDate &&
        image == other.image &&
        userId == other.userId &&
        publish == other.publish &&
        slug == other.slug &&
        amountExpected == other.amountExpected &&
        id == other.id &&
        albumImage == other.albumImage &&
        dynamicLinkUrl == other.dynamicLinkUrl;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc(
                                        $jc(
                                            $jc($jc(0, title.hashCode),
                                                description.hashCode),
                                            trackCount.hashCode),
                                        releaseDate.hashCode),
                                    image.hashCode),
                                userId.hashCode),
                            publish.hashCode),
                        slug.hashCode),
                    amountExpected.hashCode),
                id.hashCode),
            dynamicLinkUrl.hashCode),
        albumImage.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Album')
          ..add('title', title)
          ..add('description', description)
          ..add('trackCount', trackCount)
          ..add('releaseDate', releaseDate)
          ..add('image', image)
          ..add('userId', userId)
          ..add('publish', publish)
          ..add('slug', slug)
          ..add('amountExpected', amountExpected)
          ..add('id', id)
          ..add('albumImage', albumImage)
          ..add('dynamic_link_url', dynamicLinkUrl))
        .toString();
  }
}

class AlbumBuilder implements Builder<Album, AlbumBuilder> {
  _$Album? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  int? _trackCount;
  int? get trackCount => _$this._trackCount;
  set trackCount(int? trackCount) => _$this._trackCount = trackCount;

  String? _releaseDate;
  String? get releaseDate => _$this._releaseDate;
  set releaseDate(String? releaseDate) => _$this._releaseDate = releaseDate;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _publish;
  int? get publish => _$this._publish;
  set publish(int? publish) => _$this._publish = publish;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  num? _amountExpected;
  num? get amountExpected => _$this._amountExpected;
  set amountExpected(num? amountExpected) =>
      _$this._amountExpected = amountExpected;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _albumImage;
  String? get albumImage => _$this._albumImage;
  set albumImage(String? albumImage) => _$this._albumImage = albumImage;

  String? _dynamicLinkUrl;
  String? get dynamicLinkUrl => _$this._dynamicLinkUrl;
  set dynamicLinkUrl(String? dynamicLinkUrl) => _$this._dynamicLinkUrl = dynamicLinkUrl;

  AlbumBuilder();

  AlbumBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _title = $v.title;
      _description = $v.description;
      _trackCount = $v.trackCount;
      _releaseDate = $v.releaseDate;
      _image = $v.image;
      _userId = $v.userId;
      _publish = $v.publish;
      _slug = $v.slug;
      _amountExpected = $v.amountExpected;
      _id = $v.id;
      _albumImage = $v.albumImage;
      _dynamicLinkUrl = $v.dynamicLinkUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Album other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Album;
  }

  @override
  void update(void Function(AlbumBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Album build() {
    final _$result = _$v ??
        new _$Album._(
            title:
                BuiltValueNullFieldError.checkNotNull(title, 'Album', 'title'),
            description: BuiltValueNullFieldError.checkNotNull(
                description, 'Album', 'description'),
            trackCount: trackCount,
            releaseDate: releaseDate,
            image: image,
            userId: userId,
            publish: publish,
            slug: slug,
            amountExpected: amountExpected,
            id: id,
            albumImage: albumImage, dynamicLinkUrl: dynamicLinkUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
