// GENERATED CODE - DO NOT MODIFY BY HAND

part of release;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Release> _$releaseSerializer = new _$ReleaseSerializer();

class _$ReleaseSerializer implements StructuredSerializer<Release> {
  @override
  final Iterable<Type> types = const [Release, _$Release];
  @override
  final String wireName = 'Release';

  @override
  Iterable<Object?> serialize(Serializers serializers, Release object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'release_name',
      serializers.serialize(object.releaseName,
          specifiedType: const FullType(String)),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
    ];
    Object? value;
    value = object.releaseDate;
    if (value != null) {
      result
        ..add('release_date')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
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
    value = object.trackCount;
    if (value != null) {
      result
        ..add('track_count')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.tracks;
    if (value != null) {
      result
        ..add('tracks')
        ..add(serializers.serialize(value,
            specifiedType:
                const FullType(BuiltList, const [const FullType(Song)])));
    }
    value = object.imageUrl;
    if (value != null) {
      result
        ..add('image_url')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  Release deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ReleaseBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'release_name':
          result.releaseName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'release_date':
          result.releaseDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
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
        case 'track_count':
          result.trackCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'tracks':
          result.tracks.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Song)]))!
              as BuiltList<Object?>);
          break;
        case 'image_url':
          result.imageUrl = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$Release extends Release {
  @override
  final String releaseName;
  @override
  final String? releaseDate;
  @override
  final String? createdAt;
  @override
  final int? userId;
  @override
  final int? publish;
  @override
  final int? trackCount;
  @override
  final int id;
  @override
  final BuiltList<Song>? tracks;
  @override
  final String? imageUrl;

  factory _$Release([void Function(ReleaseBuilder)? updates]) =>
      (new ReleaseBuilder()..update(updates)).build();

  _$Release._(
      {required this.releaseName,
      this.releaseDate,
      this.createdAt,
      this.userId,
      this.publish,
      this.trackCount,
      required this.id,
      this.tracks,
      this.imageUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        releaseName, 'Release', 'releaseName');
    BuiltValueNullFieldError.checkNotNull(id, 'Release', 'id');
  }

  @override
  Release rebuild(void Function(ReleaseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ReleaseBuilder toBuilder() => new ReleaseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Release &&
        releaseName == other.releaseName &&
        releaseDate == other.releaseDate &&
        createdAt == other.createdAt &&
        userId == other.userId &&
        publish == other.publish &&
        trackCount == other.trackCount &&
        id == other.id &&
        tracks == other.tracks &&
        imageUrl == other.imageUrl;
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
                                $jc($jc(0, releaseName.hashCode),
                                    releaseDate.hashCode),
                                createdAt.hashCode),
                            userId.hashCode),
                        publish.hashCode),
                    trackCount.hashCode),
                id.hashCode),
            tracks.hashCode),
        imageUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Release')
          ..add('releaseName', releaseName)
          ..add('releaseDate', releaseDate)
          ..add('createdAt', createdAt)
          ..add('userId', userId)
          ..add('publish', publish)
          ..add('trackCount', trackCount)
          ..add('id', id)
          ..add('tracks', tracks)
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class ReleaseBuilder implements Builder<Release, ReleaseBuilder> {
  _$Release? _$v;

  String? _releaseName;
  String? get releaseName => _$this._releaseName;
  set releaseName(String? releaseName) => _$this._releaseName = releaseName;

  String? _releaseDate;
  String? get releaseDate => _$this._releaseDate;
  set releaseDate(String? releaseDate) => _$this._releaseDate = releaseDate;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _publish;
  int? get publish => _$this._publish;
  set publish(int? publish) => _$this._publish = publish;

  int? _trackCount;
  int? get trackCount => _$this._trackCount;
  set trackCount(int? trackCount) => _$this._trackCount = trackCount;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  ListBuilder<Song>? _tracks;
  ListBuilder<Song> get tracks => _$this._tracks ??= new ListBuilder<Song>();
  set tracks(ListBuilder<Song>? tracks) => _$this._tracks = tracks;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  ReleaseBuilder();

  ReleaseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _releaseName = $v.releaseName;
      _releaseDate = $v.releaseDate;
      _createdAt = $v.createdAt;
      _userId = $v.userId;
      _publish = $v.publish;
      _trackCount = $v.trackCount;
      _id = $v.id;
      _tracks = $v.tracks?.toBuilder();
      _imageUrl = $v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Release other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Release;
  }

  @override
  void update(void Function(ReleaseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Release build() {
    _$Release _$result;
    try {
      _$result = _$v ??
          new _$Release._(
              releaseName: BuiltValueNullFieldError.checkNotNull(
                  releaseName, 'Release', 'releaseName'),
              releaseDate: releaseDate,
              createdAt: createdAt,
              userId: userId,
              publish: publish,
              trackCount: trackCount,
              id: BuiltValueNullFieldError.checkNotNull(id, 'Release', 'id'),
              tracks: _tracks?.build(),
              imageUrl: imageUrl);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tracks';
        _tracks?.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Release', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
