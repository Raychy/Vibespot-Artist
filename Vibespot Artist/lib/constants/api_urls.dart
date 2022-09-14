import 'package:flutter/cupertino.dart';

/// a manifest for all paths following base url
class ApiUrls {
  // Auth
  static const LOGIN = 'a1/artist-auth/login';
  static const REGISTER = 'a1/artist-auth/signup';
  static const RESET_PASSWORD = 'a1/artist-auth/reset-password';
  static const FORGOT_PASSWORD = 'a1/artist-auth/forgot-password';
  static const CONFIRM_EMAIL = 'a1/artist-auth/confirm-email';
  static const LOGOUT = 'v1/oauth/logout';

  //Profile
  static const PROFILE = 'a1/profile/index';
  static const EDIT_PROFILE = 'a1/profile/edit';

  //Payment
  static const WALLET_BALANCE = 'a1/wallet/balance';
  static const WALLET_HISTORY = 'a1/wallet/history';

  /// request withdrawal, accepts query parameter amount
  static const REQUEST_WITHDRAWAL = 'payment/request-withdraw';

  /// music
  static const CREATE_RELEASE = 'a1/songs/new-release';
  static const CREATE_TRACK = 'a1/songs/upload';
  static const CREATE_ALBUM = 'a1/songs/new-album';
  static updateAlbum(String albumID) => 'a1/songs/update-album/$albumID';
  static deleteAlbum(String albumID) => 'a1/songs/delete-album/$albumID';
  static deleteAlbumTrack(String albumID) =>
      'a1/songs/delete-album-track/$albumID';
  static deleteRelease(String releaseID) =>
      'a1/songs/delete-single-release/$releaseID';
  static updateRelease(String releaseID) =>
      'a1/songs/update-new-release/$releaseID';

  static const ALBUM = 'a1/songs/album';
  static const RELEASE = 'a1/songs/release';
  static const RELEASE_TRACK = 'a1/songs/release-list';
  static const ALBUM_TRACK = 'a1/songs/album-list';
  static const TRACKS = 'a1/songs/my-music';
  static const PLAYLIST = 'a1/playlist/view-artist-playlists';
  static const addToPlaylist = 'a1/playlist/add-song-to-artist-playlist';
  static const removeFromPlaylist =
      'a1/playlist/remove-song-from-artist-playlist';
  static const convertSingleToalbum = 'a1/songs/single-to-album';
  // vibestream
  static const VIBESTREAM_SEARCH = 'v1/search/index';
  static const ALBUMS = 'vibestream/albums';

  // static const NEW_ALBUMS = 'spot-lights/new-albums';
  // static const STATE_VIBES = 'vibestream/state-vibes';
  // static const SLIDER = 'spot-lights/slider';
  // static const ALBUM_TRACKS = 'vibestream/album-tracks';
  // static const MAINSTREAM_RANKING = 'spot-lights/mainstream-ranking';
  // static const SUGGESTED_ARTIST = 'spot-lights/suggested-artist';
  // static const NEWLY_RELEASED_TRACKS = 'spot-lights/newly-released';
//
  static const YOUTUBE_API_BASE = 'https://www.googleapis.com/youtube/v3';
  static const YOUTUBE_SEARCH = 'search';
  static const YOUTUBE_VIDEO = 'videos';

  static const LOCATION_SERVICE = 'https://www.universal-tutorial.com/api';

  static const PRIVACY = 'https://google.com';
  static const TERMS = 'https://google.com';
}

final IMAGE_URL = ValueNotifier("");