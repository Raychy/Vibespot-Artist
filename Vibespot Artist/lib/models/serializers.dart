library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';

import 'album.dart';
import 'balance_history.dart';
import 'country.dart';
import 'error_model.dart';
import 'pagination.dart';
import 'playlist.dart';
import 'release.dart';
import 'song.dart';
import 'state_city.dart';
// import 'track.dart';
import 'user.dart';

part 'serializers.g.dart';

@SerializersFor(const [
  Album,
  BalanceHistory,
  Country,
  ErrorModel,
  Pagination,
  Release,
  StateCity,
  Playlist,
  Song,
  User,
])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
