// GENERATED CODE - DO NOT MODIFY BY HAND

part of playlist;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Playlist> _$playlistSerializer = new _$PlaylistSerializer();

class _$PlaylistSerializer implements StructuredSerializer<Playlist> {
  @override
  final Iterable<Type> types = const [Playlist, _$Playlist];
  @override
  final String wireName = 'Playlist';

  @override
  Iterable<Object?> serialize(Serializers serializers, Playlist object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(num)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.trackId;
    if (value != null) {
      result
        ..add('track_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(num)));
    }
    value = object.song;
    if (value != null) {
      result
        ..add('song')
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
    value = object.genre;
    if (value != null) {
      result
        ..add('genre')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.stageName;
    if (value != null) {
      result
        ..add('stage_name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.artistId;
    if (value != null) {
      result
        ..add('artist_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(num)));
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
  Playlist deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new PlaylistBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num;
          break;
        case 'track_id':
          result.trackId = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num?;
          break;
        case 'song':
          result.song = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'genre':
          result.genre = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'stage_name':
          result.stageName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'artist_id':
          result.artistId = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num?;
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

class _$Playlist extends Playlist {
  @override
  final num id;
  @override
  final num? trackId;
  @override
  final String? song;
  @override
  final String? image;
  @override
  final String title;
  @override
  final String? genre;
  @override
  final String? stageName;
  @override
  final num? artistId;
  @override
  final String? dynamicLinkUrl;

  factory _$Playlist([void Function(PlaylistBuilder)? updates]) =>
      (new PlaylistBuilder()..update(updates)).build();

  _$Playlist._(
      {required this.id,
      this.trackId,
      this.song,
      this.image,
      required this.title,
      this.genre,
      this.stageName,
      this.artistId,
      this.dynamicLinkUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(id, 'Playlist', 'id');
    BuiltValueNullFieldError.checkNotNull(title, 'Playlist', 'title');
  }

  @override
  Playlist rebuild(void Function(PlaylistBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PlaylistBuilder toBuilder() => new PlaylistBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Playlist &&
        id == other.id &&
        trackId == other.trackId &&
        song == other.song &&
        image == other.image &&
        title == other.title &&
        genre == other.genre &&
        stageName == other.stageName &&
        artistId == other.artistId &&
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
                            $jc($jc($jc(0, id.hashCode), trackId.hashCode),
                                song.hashCode),
                            image.hashCode),
                        title.hashCode),
                    genre.hashCode),
                stageName.hashCode),
            artistId.hashCode),
        dynamicLinkUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Playlist')
          ..add('id', id)
          ..add('trackId', trackId)
          ..add('song', song)
          ..add('image', image)
          ..add('title', title)
          ..add('genre', genre)
          ..add('stageName', stageName)
          ..add('artistId', artistId)
          ..add('dynamicLinkUrl', dynamicLinkUrl))
        .toString();
  }
}

class PlaylistBuilder implements Builder<Playlist, PlaylistBuilder> {
  _$Playlist? _$v;

  num? _id;
  num? get id => _$this._id;
  set id(num? id) => _$this._id = id;

  num? _trackId;
  num? get trackId => _$this._trackId;
  set trackId(num? trackId) => _$this._trackId = trackId;

  String? _song;
  String? get song => _$this._song;
  set song(String? song) => _$this._song = song;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _genre;
  String? get genre => _$this._genre;
  set genre(String? genre) => _$this._genre = genre;

  String? _stageName;
  String? get stageName => _$this._stageName;
  set stageName(String? stageName) => _$this._stageName = stageName;

  num? _artistId;
  num? get artistId => _$this._artistId;
  set artistId(num? artistId) => _$this._artistId = artistId;

  String? _dynamicLinkUrl;
  String? get dynamicLinkUrl => _$this._dynamicLinkUrl;
  set dynamicLinkUrl(String? dynamicLinkUrl) =>
      _$this._dynamicLinkUrl = dynamicLinkUrl;

  PlaylistBuilder();

  PlaylistBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _trackId = $v.trackId;
      _song = $v.song;
      _image = $v.image;
      _title = $v.title;
      _genre = $v.genre;
      _stageName = $v.stageName;
      _artistId = $v.artistId;
      _dynamicLinkUrl = $v.dynamicLinkUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Playlist other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Playlist;
  }

  @override
  void update(void Function(PlaylistBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Playlist build() {
    final _$result = _$v ??
        new _$Playlist._(
            id: BuiltValueNullFieldError.checkNotNull(id, 'Playlist', 'id'),
            trackId: trackId,
            song: song,
            image: image,
            title: BuiltValueNullFieldError.checkNotNull(
                title, 'Playlist', 'title'),
            genre: genre,
            stageName: stageName,
            artistId: artistId,
            dynamicLinkUrl: dynamicLinkUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
