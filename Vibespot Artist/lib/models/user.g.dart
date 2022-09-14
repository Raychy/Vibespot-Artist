// GENERATED CODE - DO NOT MODIFY BY HAND

part of user;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<User> _$userSerializer = new _$UserSerializer();

class _$UserSerializer implements StructuredSerializer<User> {
  @override
  final Iterable<Type> types = const [User, _$User];
  @override
  final String wireName = 'User';

  @override
  Iterable<Object?> serialize(Serializers serializers, User object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(num)));
    }
    value = object.username;
    if (value != null) {
      result
        ..add('username')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.phone;
    if (value != null) {
      result
        ..add('phone')
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
    value = object.emailVerified;
    if (value != null) {
      result
        ..add('email_verified')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.profileVerified;
    if (value != null) {
      result
        ..add('profileVerified')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.state;
    if (value != null) {
      result
        ..add('state')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.city;
    if (value != null) {
      result
        ..add('city')
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
    value = object.surname;
    if (value != null) {
      result
        ..add('surname')
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
    value = object.uniqueId;
    if (value != null) {
      result
        ..add('unique_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.firstname;
    if (value != null) {
      result
        ..add('firstname')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.othernames;
    if (value != null) {
      result
        ..add('othernames')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userType;
    if (value != null) {
      result
        ..add('user_type')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.artistImage;
    if (value != null) {
      result
        ..add('artist_image')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.updatedAt;
    if (value != null) {
      result
        ..add('updated_at')
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
    value = object.wallet;
    if (value != null) {
      result
        ..add('wallet')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  User deserialize(Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new UserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(num)) as num?;
          break;
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'phone':
          result.phone = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'email_verified':
          result.emailVerified = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'profileVerified':
          result.profileVerified = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool?;
          break;
        case 'state':
          result.state = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'city':
          result.city = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'country':
          result.country = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'surname':
          result.surname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'stage_name':
          result.stageName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'unique_id':
          result.uniqueId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'firstname':
          result.firstname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'othernames':
          result.othernames = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'user_type':
          result.userType = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'artist_image':
          result.artistImage = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'updated_at':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'created_at':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'wallet':
          result.wallet = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$User extends User {
  @override
  final num? id;
  @override
  final String? username;
  @override
  final String email;
  @override
  final String? phone;
  @override
  final String? image;
  @override
  final bool? emailVerified;
  @override
  final bool? profileVerified;
  @override
  final String? state;
  @override
  final String? city;
  @override
  final String? country;
  @override
  final String? surname;
  @override
  final String? stageName;
  @override
  final String? youtubeChannel;
  @override
  final String? uniqueId;
  @override
  final String? firstname;
  @override
  final String? othernames;
  @override
  final String? userType;
  @override
  final String? artistImage;
  @override
  final String? updatedAt;
  @override
  final String? createdAt;
  @override
  final String? wallet;

  factory _$User([void Function(UserBuilder)? updates]) =>
      (new UserBuilder()..update(updates)).build();

  _$User._(
      {this.id,
      this.username,
      required this.email,
      this.phone,
      this.image,
      this.emailVerified,
      this.profileVerified,
      this.state,
      this.city,
      this.country,
      this.surname,
      this.stageName,
        this.youtubeChannel,
      this.uniqueId,
      this.firstname,
      this.othernames,
      this.userType,
      this.artistImage,
      this.updatedAt,
      this.createdAt,
      this.wallet})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(email, 'User', 'email');
  }

  @override
  User rebuild(void Function(UserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UserBuilder toBuilder() => new UserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
        id == other.id &&
        username == other.username &&
        email == other.email &&
        phone == other.phone &&
        image == other.image &&
        emailVerified == other.emailVerified &&
        profileVerified == other.profileVerified &&
        state == other.state &&
        city == other.city &&
        country == other.country &&
        surname == other.surname &&
        stageName == other.stageName &&
        youtubeChannel == other.youtubeChannel &&
        uniqueId == other.uniqueId &&
        firstname == other.firstname &&
        othernames == other.othernames &&
        userType == other.userType &&
        artistImage == other.artistImage &&
        updatedAt == other.updatedAt &&
        createdAt == other.createdAt &&
        wallet == other.wallet;
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
                                                                            $jc($jc(0, id.hashCode),
                                                                                username.hashCode),
                                                                            email.hashCode),
                                                                        phone.hashCode),
                                                                    image.hashCode),
                                                                emailVerified.hashCode),
                                                            profileVerified.hashCode),
                                                        state.hashCode),
                                                    city.hashCode),
                                                country.hashCode),
                                            surname.hashCode),
                                        stageName.hashCode),
                                    uniqueId.hashCode),
                                firstname.hashCode),
                            othernames.hashCode),
                        userType.hashCode),
                    artistImage.hashCode),
                updatedAt.hashCode),
            createdAt.hashCode),
        wallet.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('User')
          ..add('id', id)
          ..add('username', username)
          ..add('email', email)
          ..add('phone', phone)
          ..add('image', image)
          ..add('emailVerified', emailVerified)
          ..add('profileVerified', profileVerified)
          ..add('state', state)
          ..add('city', city)
          ..add('country', country)
          ..add('surname', surname)
          ..add('stageName', stageName)
          ..add('youtubeChannel', youtubeChannel)
          ..add('uniqueId', uniqueId)
          ..add('firstname', firstname)
          ..add('othernames', othernames)
          ..add('userType', userType)
          ..add('artistImage', artistImage)
          ..add('updatedAt', updatedAt)
          ..add('createdAt', createdAt)
          ..add('wallet', wallet))
        .toString();
  }
}

class UserBuilder implements Builder<User, UserBuilder> {
  _$User? _$v;

  num? _id;
  num? get id => _$this._id;
  set id(num? id) => _$this._id = id;

  String? _username;
  String? get username => _$this._username;
  set username(String? username) => _$this._username = username;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  String? _image;
  String? get image => _$this._image;
  set image(String? image) => _$this._image = image;

  bool? _emailVerified;
  bool? get emailVerified => _$this._emailVerified;
  set emailVerified(bool? emailVerified) =>
      _$this._emailVerified = emailVerified;

  bool? _profileVerified;
  bool? get profileVerified => _$this._profileVerified;
  set profileVerified(bool? profileVerified) =>
      _$this._profileVerified = profileVerified;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  String? _surname;
  String? get surname => _$this._surname;
  set surname(String? surname) => _$this._surname = surname;

  String? _stageName;
  String? get stageName => _$this._stageName;
  set stageName(String? stageName) => _$this._stageName = stageName;

  String? _youtubeName;
  String? get youtubeName => _$this._youtubeName;
  set youtubeName(String? youtubeName) => _$this._youtubeName = youtubeName;

  String? _uniqueId;
  String? get uniqueId => _$this._uniqueId;
  set uniqueId(String? uniqueId) => _$this._uniqueId = uniqueId;

  String? _firstname;
  String? get firstname => _$this._firstname;
  set firstname(String? firstname) => _$this._firstname = firstname;

  String? _othernames;
  String? get othernames => _$this._othernames;
  set othernames(String? othernames) => _$this._othernames = othernames;

  String? _userType;
  String? get userType => _$this._userType;
  set userType(String? userType) => _$this._userType = userType;

  String? _artistImage;
  String? get artistImage => _$this._artistImage;
  set artistImage(String? artistImage) => _$this._artistImage = artistImage;

  String? _updatedAt;
  String? get updatedAt => _$this._updatedAt;
  set updatedAt(String? updatedAt) => _$this._updatedAt = updatedAt;

  String? _createdAt;
  String? get createdAt => _$this._createdAt;
  set createdAt(String? createdAt) => _$this._createdAt = createdAt;

  String? _wallet;
  String? get wallet => _$this._wallet;
  set wallet(String? wallet) => _$this._wallet = wallet;

  UserBuilder();

  UserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _username = $v.username;
      _email = $v.email;
      _phone = $v.phone;
      _image = $v.image;
      _emailVerified = $v.emailVerified;
      _profileVerified = $v.profileVerified;
      _state = $v.state;
      _city = $v.city;
      _country = $v.country;
      _surname = $v.surname;
      _stageName = $v.stageName;
      _youtubeName=$v.youtubeChannel;
      _uniqueId = $v.uniqueId;
      _firstname = $v.firstname;
      _othernames = $v.othernames;
      _userType = $v.userType;
      _artistImage = $v.artistImage;
      _updatedAt = $v.updatedAt;
      _createdAt = $v.createdAt;
      _wallet = $v.wallet;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(User other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$User;
  }

  @override
  void update(void Function(UserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$User build() {
    final _$result = _$v ??
        new _$User._(
            id: id,
            username: username,
            email:
                BuiltValueNullFieldError.checkNotNull(email, 'User', 'email'),
            phone: phone,
            image: image,
            emailVerified: emailVerified,
            profileVerified: profileVerified,
            state: state,
            city: city,
            country: country,
            surname: surname,
            stageName: stageName,
            youtubeChannel: youtubeName,
            uniqueId: uniqueId,
            firstname: firstname,
            othernames: othernames,
            userType: userType,
            artistImage: artistImage,
            updatedAt: updatedAt,
            createdAt: createdAt,
            wallet: wallet);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
