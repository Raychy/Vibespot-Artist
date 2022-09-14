// GENERATED CODE - DO NOT MODIFY BY HAND

part of song;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<Song> _$songSerializer = new _$SongSerializer();

class _$SongSerializer implements StructuredSerializer<Song> {
  @override
  final Iterable<Type> types = const [Song, _$Song];
  @override
  final String wireName = 'Song';

  @override
  Iterable<Object?> serialize(Serializers serializers, Song object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.trackId;
    if (value != null) {
      result
        ..add('track_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.releaseId;
    if (value != null) {
      result
        ..add('release_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.albumId;
    if (value != null) {
      result
        ..add('album_id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.slug;
    if (value != null) {
      result
        ..add('slug')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.featuredBy;
    if (value != null) {
      result
        ..add('featured_by')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.producedBy;
    if (value != null) {
      result
        ..add('produced_by')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
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
    value = object.country;
    if (value != null) {
      result
        ..add('country')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.state;
    if (value != null) {
      result
        ..add('state')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pushState;
    if (value != null) {
      result
        ..add('push_state')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pushCity;
    if (value != null) {
      result
        ..add('push_city')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
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
    value = object.song;
    if (value != null) {
      result
        ..add('song')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.songImage;
    if (value != null) {
      result
        ..add('song_image')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.duration;
    if (value != null) {
      result
        ..add('duration')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.streamed;
    if (value != null) {
      result
        ..add('streamed')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.verificationStatus;
    if (value != null) {
      result
        ..add('verification_status')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.status;
    if (value != null) {
      result
        ..add('status')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
    }
    value = object.createdAt;
    if (value != null) {
      result
        ..add('created_at')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pushCountry;
    if (value != null) {
      result
        ..add('push_country')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pushLatitude;
    if (value != null) {
      result
        ..add('push_latitude')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.pushLongitude;
    if (value != null) {
      result
        ..add('push_longitude')
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
  Song deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SongBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'track_id':
          result.trackId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'release_id':
          result.releaseId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'album_id':
          result.albumId = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'slug':
          result.slug = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'featured_by':
          result.featuredBy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'produced_by':
          result.producedBy = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'genre':
          result.genre = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'country':
          result.country = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'state':
          result.state = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'push_state':
          result.pushState = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'push_city':
          result.pushCity = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'release_date':
          result.releaseDate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'song':
          result.song = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'song_image':
          result.songImage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'duration':
          result.duration = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'streamed':
          result.streamed = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'verification_status':
          result.verificationStatus = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'status':
          result.status = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'push_country':
          result.pushCountry = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'push_latitude':
          result.pushLatitude = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'push_longitude':
          result.pushLongitude = serializers.deserialize(value,
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

class _$Song extends Song {
  @override
  final int? id;
  @override
  final int? trackId;
  @override
  final int? userId;
  @override
  final int? releaseId;
  @override
  final int? albumId;
  @override
  final String? slug;
  @override
  final String title;
  @override
  final String? featuredBy;
  @override
  final String? producedBy;
  @override
  final String? description;
  @override
  final String? genre;
  @override
  final String? country;
  @override
  final String? state;
  @override
  final String? pushState;
  @override
  final String? pushCity;
  @override
  final String? releaseDate;
  @override
  final String? image;
  @override
  final String? song;
  @override
  final String? songImage;
  @override
  final String? duration;
  @override
  final int? streamed;
  @override
  final int? verificationStatus;
  @override
  final int? status;
  @override
  final String? createdAt;
  @override
  final String? pushCountry;
  @override
  final String? pushLatitude;
  @override
  final String? pushLongitude;
  @override
  final String? dynamicLinkUrl;

  factory _$Song([void Function(SongBuilder)? updates]) =>
      (new SongBuilder()..update(updates)).build();

  _$Song._(
      {this.id,
      this.trackId,
      this.userId,
      this.releaseId,
      this.albumId,
      this.slug,
      required this.title,
      this.featuredBy,
      this.producedBy,
      this.description,
      this.genre,
      this.country,
      this.state,
      this.pushState,
      this.pushCity,
      this.releaseDate,
      this.image,
      this.song,
      this.songImage,
      this.duration,
      this.streamed,
      this.verificationStatus,
      this.status,
      this.createdAt,
      this.pushCountry,
      this.pushLatitude,
      this.pushLongitude,
      this.dynamicLinkUrl})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(title, 'Song', 'title');
  }

  @override
  Song rebuild(void Function(SongBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SongBuilder toBuilder() => new SongBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Song &&
        id == other.id &&
        trackId == other.trackId &&
        userId == other.userId &&
        releaseId == other.releaseId &&
        albumId == other.albumId &&
        slug == other.slug &&
        title == other.title &&
        featuredBy == other.featuredBy &&
        producedBy == other.producedBy &&
        description == other.description &&
        genre == other.genre &&
        country == other.country &&
        state == other.state &&
        pushState == other.pushState &&
        pushCity == other.pushCity &&
        releaseDate == other.releaseDate &&
        image == other.image &&
        song == other.song &&
        songImage == other.songImage &&
        duration == other.duration &&
        streamed == other.streamed &&
        verificationStatus == other.verificationStatus &&
        status == other.status &&
        createdAt == other.createdAt &&
        pushCountry == other.pushCountry &&
        pushLatitude == other.pushLatitude &&
        pushLongitude == other.pushLongitude &&
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
                                            $jc(
                                                $jc(
                                                    $jc(
                                                        $jc(
                                                            $jc(
                                                                $jc(
                                                                    $jc(
                                                                        $jc(
                                                                            $jc($jc($jc($jc($jc($jc($jc($jc($jc($jc(0, id.hashCode), trackId.hashCode), userId.hashCode), releaseId.hashCode), albumId.hashCode), slug.hashCode), title.hashCode), featuredBy.hashCode), producedBy.hashCode),
                                                                                description.hashCode),
                                                                            genre.hashCode),
                                                                        country.hashCode),
                                                                    state.hashCode),
                                                                pushState.hashCode),
                                                            pushCity.hashCode),
                                                        releaseDate.hashCode),
                                                    image.hashCode),
                                                song.hashCode),
                                            songImage.hashCode),
                                        duration.hashCode),
                                    streamed.hashCode),
                                verificationStatus.hashCode),
                            status.hashCode),
                        createdAt.hashCode),
                    pushCountry.hashCode),
                pushLatitude.hashCode),
            pushLongitude.hashCode),
        dynamicLinkUrl.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Song')
          ..add('id', id)
          ..add('trackId', trackId)
          ..add('userId', userId)
          ..add('releaseId', releaseId)
          ..add('albumId', albumId)
          ..add('slug', slug)
          ..add('title', title)
          ..add('featuredBy', featuredBy)
          ..add('producedBy', producedBy)
          ..add('description', description)
          ..add('genre', genre)
          ..add('country', country)
          ..add('state', state)
          ..add('pushState', pushState)
          ..add('pushCity', pushCity)
          ..add('releaseDate', releaseDate)
          ..add('image', image)
          ..add('song', song)
          ..add('songImage', songImage)
          ..add('duration', duration)
          ..add('streamed', streamed)
          ..add('verificationStatus', verificationStatus)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('pushCountry', pushCountry)
          ..add('pushLatitude', pushLatitude)
          ..add('pushLongitude', pushLongitude)
          ..add('dynamicLinkUrl', dynamicLinkUrl))
        .toString();
  }
}

class SongBuilder implements Builder<Song, SongBuilder> {
  _$Song? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  int? _trackId;
  int? get trackId => _$this._trackId;
  set trackId(int? trackId) => _$this._trackId = trackId;

  int? _userId;
  int? get userId => _$this._userId;
  set userId(int? userId) => _$this._userId = userId;

  int? _releaseId;
  int? get releaseId => _$this._releaseId;
  set releaseId(int? releaseId) => _$this._releaseId = releaseId;

  int? _albumId;
  int? get albumId => _$this._albumId;
  set albumId(int? albumId) => _$this._albumId = albumId;

  String? _slug;
  String? get slug => _$this._slug;
  set slug(String? slug) => _$this._slug = slug;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _featuredBy;
  String? get featuredBy => _$this._featuredBy;
  set featuredBy(String? featuredBy) => _$this._featuredBy = featuredBy;

  String? _producedBy;
  String? get producedBy => _$this._producedBy;
  set producedBy(String? producedBy) => _$this._producedBy = producedBy;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _genre;
  String? get genre => _$this._genre;
  set genre(String? genre) => _$this._genre = genre;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  String? _pushState;
  String? get pushState => _$this._pushState;
  set pushState(String? pushState) => _$this._pushState = pushState;

  String? _pushCity;
  String? get pushCity => _$this._pushCity;
  set pushCity(String? pushCity) => _$this._pushCity = pushCity;

  String? _releaseDate;
  String? get releaseDate => _$this._releaseDate;
  set releaseDate(String? releaseDate) => _$this._releaseDate = releaseDate;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  String? _song;
  String? get song => _$this._song;
  set song(String? song) => _$this._song = song;

  String? _songImage;
  String? get songImage => _$this._songImage;
  set songImage(String? songImage) => _$this._songImage = songImage;

  String? _duration;
  String? get duration => _$this._duration;
  set duration(String? duration) => _$this._duration = duration;

  int? _streamed;
  int? get streamed => _$this._streamed;
  set streamed(int? streamed) => _$this._streamed = streamed;

  int? _verificationStatus;
  int? get verificationStatus => _$this._verificationStatus;
  set verificationStatus(int? verificationStatus) =>
      _$this._verificationStatus = verificationStatus;

  int? _status;
  int? get status => _$this._status;
  set status(int? status) => _$this._status = status;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _pushCountry;
  String? get pushCountry => _$this._pushCountry;
  set pushCountry(String? pushCountry) => _$this._pushCountry = pushCountry;

  String? _pushLatitude;
  String? get pushLatitude => _$this._pushLatitude;
  set pushLatitude(String? pushLatitude) => _$this._pushLatitude = pushLatitude;

  String? _pushLongitude;
  String? get pushLongitude => _$this._pushLongitude;
  set pushLongitude(String? pushLongitude) =>
      _$this._pushLongitude = pushLongitude;

  String? _dynamicLinkUrl;
  String? get dynamicLinkUrl => _$this._dynamicLinkUrl;
  set dynamicLinkUrl(String? dynamicLinkUrl) =>
      _$this._dynamicLinkUrl = dynamicLinkUrl;

  SongBuilder();

  SongBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _trackId = $v.trackId;
      _userId = $v.userId;
      _releaseId = $v.releaseId;
      _albumId = $v.albumId;
      _slug = $v.slug;
      _title = $v.title;
      _featuredBy = $v.featuredBy;
      _producedBy = $v.producedBy;
      _description = $v.description;
      _genre = $v.genre;
      _country = $v.country;
      _state = $v.state;
      _pushState = $v.pushState;
      _pushCity = $v.pushCity;
      _releaseDate = $v.releaseDate;
      _image = $v.image;
      _song = $v.song;
      _songImage = $v.songImage;
      _duration = $v.duration;
      _streamed = $v.streamed;
      _verificationStatus = $v.verificationStatus;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _pushCountry = $v.pushCountry;
      _pushLatitude = $v.pushLatitude;
      _pushLongitude = $v.pushLongitude;
      _dynamicLinkUrl = $v.dynamicLinkUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Song other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$Song;
  }

  @override
  void update(void Function(SongBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$Song build() {
    final _$result = _$v ??
        new _$Song._(
            id: id,
            trackId: trackId,
            userId: userId,
            releaseId: releaseId,
            albumId: albumId,
            slug: slug,
            title:
                BuiltValueNullFieldError.checkNotNull(title, 'Song', 'title'),
            featuredBy: featuredBy,
            producedBy: producedBy,
            description: description,
            genre: genre,
            country: country,
            state: state,
            pushState: pushState,
            pushCity: pushCity,
            releaseDate: releaseDate,
            image: image,
            song: song,
            songImage: songImage,
            duration: duration,
            streamed: streamed,
            verificationStatus: verificationStatus,
            status: status,
            createdAt: createdAt,
            pushCountry: pushCountry,
            pushLatitude: pushLatitude,
            pushLongitude: pushLongitude,
            dynamicLinkUrl: dynamicLinkUrl);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
