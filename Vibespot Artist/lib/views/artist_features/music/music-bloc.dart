import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:vsartist/views/artist_features/artist_global/networks.dart';
import 'package:vsartist/views/artist_features/uploads/uploads-model.dart';
import 'package:vsartist/views/common/uidata.dart';

class MusicBloc {
  NetworkRequest network = new NetworkRequest();

  final _all = PublishSubject<List<Music>>();
  Stream<List<Music>> get allSongs => _all.stream;

  final _release = PublishSubject<List<ReleaseSingle>>();
  Stream<List<ReleaseSingle>> get allRelease => _release.stream;

  final _album = PublishSubject<List<UploadAlbumDetails>>();
  Stream<List<UploadAlbumDetails>> get allAlbum => _album.stream;

  final _allAlbum = PublishSubject<List<Music>>();
  Stream<List<Music>> get allAlbumList => _allAlbum.stream;

  final _allRelease = PublishSubject<List<Music>>();
  Stream<List<Music>> get allReleaseList => _allRelease.stream;

  final _allUnpublish = PublishSubject<List?>();
  Stream<List?> get allUnpublish => _allUnpublish.stream;

  final _showProgress = PublishSubject<bool>();
  Stream<bool> get showProgress => _showProgress.stream;

  final snackBar = PublishSubject<String>();
  Stream<String> get snacksBar => snackBar.stream;

  getSongs(context) async {
    var toJson = <Music>[];

    String parsed = await network.get(
        Uri.encodeFull(UiData.domain + "/a1/songs/my-music"),
        context: context);
    // print(parsed);
    var response = jsonDecode(parsed);
    if (response["status"] == false) {
      snackBar.add('Could not fetch songs');
      return;
    }

    Iterable list = response['data'];
    toJson = list.map((model) => Music.fromJson(model)).toList();
    _all.sink.add(toJson);
  }

  getRelease(context) async {
    var toJson = <ReleaseSingle>[];

    String parsed = await network.get(
        Uri.encodeFull(UiData.domain + "/a1/songs/release"),
        context: context);
    var response = jsonDecode(parsed);
    if (response["status"] == false) {
      snackBar.add('Could not fetch songs');
      return;
    }

    Iterable list = response['data'];
    toJson = list.map((model) => ReleaseSingle.fromJson(model)).toList();
    _release.sink.add(toJson);
  }

  getAlbum(context) async {
    var toJson = <UploadAlbumDetails>[];

    String parsed = await network.get(
        Uri.encodeFull(UiData.domain + "/a1/songs/album"),
        context: context);
    //print(parsed);
    var response = jsonDecode(parsed);
    if (response["status"] == false) {
      snackBar.add('Could not fetch songs');
      return;
    }

    Iterable list = response['data'];
    toJson = list.map((model) => UploadAlbumDetails.fromJson(model)).toList();
    _album.sink.add(toJson);
  }

  getAlbumList(id) async {
    var toJson = <Music>[];
    String parsed = await network
        .get(Uri.encodeFull(UiData.domain + "/a1/songs/album-list?id=$id"));
    var response = jsonDecode(parsed);
    if (response["status"] == false) {
      snackBar.add('Could not fetch songs');
      return;
    }
    Iterable list = response['data'];
    toJson = list.map((model) => Music.fromJson(model)).toList();
    _allAlbum.sink.add(toJson);
  }

  getReleaseList(id) async {
    var toJson = <Music>[];
    String parsed = await network
        .get(Uri.encodeFull(UiData.domain + "/a1/songs/release-list?id=$id"));
    var response = jsonDecode(parsed);
    if (response["status"] == false) {
      snackBar.add('Could not fetch songs');
      return;
    }
    Iterable list = response['data'];
    toJson = list.map((model) => Music.fromJson(model)).toList();
    _allRelease.sink.add(toJson);
  }

  getUnpublish(context) async {
    String parsed = await network.get(
        Uri.encodeFull(UiData.domain + "/a1/songs/unpublish"),
        context: context);
    var response = jsonDecode(parsed);
    if (response["status"] == false) {
      snackBar.add('Could not fetch songs');
      return;
    }
    Iterable? list = response['data'];

    _allUnpublish.sink.add(list as List<dynamic>?);
  }

  dispose() {
    _all.close();
    _release.close();
    _album.close();
    _allAlbum.close();
    _allRelease.close();
    _allUnpublish.close();
    _showProgress.close();
    snackBar.close();
  }
}

final musicBloc = MusicBloc();
