import 'package:built_collection/built_collection.dart';
import 'package:vsartist/constants/api_urls.dart';
import 'package:vsartist/data/remote/interceptors/auth_interceptor.dart';
import 'package:vsartist/data/remote/interceptors/json_interceptor.dart';
import 'package:vsartist/data/remote/provider/api_methods.dart';
import 'package:vsartist/data/remote/provider/api_response.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/models/balance_history.dart';
import 'package:vsartist/models/error_model.dart';
import 'package:vsartist/models/playlist.dart';
import 'package:vsartist/models/release.dart';
import 'package:vsartist/models/song.dart';
import '../api_client.dart';
import 'base_api_service.dart';

class MusicApiService extends BaseApiService {
  Future<ApiResponse<Album, Album>> createAlbum(Map<String, dynamic> body) {
    return provider.send<Album, Album>(ApiClient.baseRequest<Album, Album>()
        .copyWith(
            path: ApiUrls.CREATE_ALBUM,
            method: ApiMethods.POST,
            body: body,
            isMultipart: true,
            interceptors: [JsonInterceptor<ErrorModel>(), AuthInterceptor()],
            dataKey: 'data'));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>> updateAlbum(
      String albumID, Map<String, dynamic> body) {
    return provider.send<Map<String, dynamic>, Map<String, dynamic>>(
        ApiClient.baseRequest<Map<String, dynamic>, Map<String, dynamic>>()
            .copyWith(
                path: ApiUrls.updateAlbum(albumID),
                method: ApiMethods.POST,
                body: body,
                isMultipart: true,
                interceptors: [
                  JsonInterceptor<ErrorModel>(),
                  AuthInterceptor()
                ],
                dataKey: 'data'));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>> updateRelease(
      String releaseID, Map<String, dynamic> body) {
    return provider.send<Map<String, dynamic>, Map<String, dynamic>>(
        ApiClient.baseRequest<Map<String, dynamic>, Map<String, dynamic>>()
            .copyWith(
                path: ApiUrls.updateRelease(releaseID),
                method: ApiMethods.POST,
                body: body,
                // isMultipart: true,
                interceptors: [
                  JsonInterceptor<ErrorModel>(),
                  AuthInterceptor()
                ],
                dataKey: 'data'));
  }

  Future<ApiResponse<BuiltList<Album>, Album>> getAlbums(
      Map<String, dynamic> query) {
    return provider.send<BuiltList<Album>, Album>(
        ApiClient.baseRequest<BuiltList<Album>, Album>().copyWith(
            path: ApiUrls.ALBUM,
            method: ApiMethods.GET,
            query: query,
            hasPagination: true,
            interceptors: [JsonInterceptor<ErrorModel>(), AuthInterceptor()],
            nestedKey: 'data',
            dataKey: 'data'));
  }

  Future<ApiResponse<BuiltList<Release>, Release>> getReleases(
      Map<String, dynamic> query) {
    return provider.send<BuiltList<Release>, Release>(
        ApiClient.baseRequest<BuiltList<Release>, Release>().copyWith(
            path: ApiUrls.RELEASE,
            method: ApiMethods.GET,
            query: query,
            hasPagination: true,
            interceptors: [JsonInterceptor<ErrorModel>(), AuthInterceptor()],
            nestedKey: 'data',
            dataKey: 'data'));
  }

  Future<ApiResponse<BuiltList<Playlist>, Playlist>> getPlaylists(
      Map<String, dynamic> query) {
    return provider.send<BuiltList<Playlist>, Playlist>(
        ApiClient.baseRequest<BuiltList<Playlist>, Playlist>().copyWith(
            path: ApiUrls.PLAYLIST,
            method: ApiMethods.GET,
            query: query,
            hasPagination: false,
            interceptors: [JsonInterceptor<ErrorModel>(), AuthInterceptor()],
            // nestedKey: 'data',
            dataKey: 'data'));
  }

  Future<ApiResponse<BuiltList<Song>, Song>> getTracks(
      String path, Map<String, dynamic> query) {
    return provider.send<BuiltList<Song>, Song>(
        ApiClient.baseRequest<BuiltList<Song>, Song>().copyWith(
            path: path,
            method: ApiMethods.GET,
            query: query,
            hasPagination: true,
            interceptors: [JsonInterceptor<ErrorModel>(), AuthInterceptor()],
            nestedKey: 'data',
            dataKey: 'data'));
  }

  Future<ApiResponse<Release, Release>> createRelease(
      Map<String, dynamic> body) {
    return provider.send<Release, Release>(
        ApiClient.baseRequest<Release, Release>().copyWith(
            path: ApiUrls.CREATE_RELEASE,
            method: ApiMethods.POST,
            body: body,
            interceptors: [JsonInterceptor<ErrorModel>(), AuthInterceptor()],
            dataKey: 'data'));
  }

  Future<ApiResponse<Song, Song>> createTrack(Map<String, dynamic> body) {
    return provider.send<Song, Song>(ApiClient.baseRequest<Song, Song>()
        .copyWith(
            path: ApiUrls.CREATE_TRACK,
            method: ApiMethods.POST,
            body: body,
            interceptors: [JsonInterceptor<ErrorModel>(), AuthInterceptor()],
            dataKey: 'data'));
  }

  Future<ApiResponse<BuiltList<BalanceHistory>, BalanceHistory>>
      balanceHistory() {
    return provider.send<BuiltList<BalanceHistory>, BalanceHistory>(
        ApiClient.baseRequest<BuiltList<BalanceHistory>, BalanceHistory>()
            .copyWith(
      path: ApiUrls.WALLET_HISTORY,
      method: ApiMethods.GET,
      interceptors: [JsonInterceptor<ErrorModel>(), AuthInterceptor()],
    ));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>>
      addTrackToPlaylist(String trackID) {
    return provider.send<Map<String, dynamic>, Map<String, dynamic>>(
        ApiClient.baseRequest<Map<String, dynamic>, Map<String, dynamic>>()
            .copyWith(
                path: ApiUrls.addToPlaylist,
                method: ApiMethods.POST,
                body: {'track_id': trackID},
                interceptors: [
                  JsonInterceptor<ErrorModel>(),
                  AuthInterceptor()
                ],
                dataKey: ''));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>>
      removeTrackFromPlaylist(String trackID) {
    return provider.send<Map<String, dynamic>, Map<String, dynamic>>(
        ApiClient.baseRequest<Map<String, dynamic>, Map<String, dynamic>>()
            .copyWith(
                path: ApiUrls.removeFromPlaylist,
                method: ApiMethods.POST,
                body: {'track_id': trackID},
                interceptors: [
                  JsonInterceptor<ErrorModel>(),
                  AuthInterceptor()
                ],
                dataKey: ''));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>>
      releaseToAlbum(String trackID, String albumID) {
    return provider.send<Map<String, dynamic>, Map<String, dynamic>>(
        ApiClient.baseRequest<Map<String, dynamic>, Map<String, dynamic>>()
            .copyWith(
                path: ApiUrls.convertSingleToalbum,
                method: ApiMethods.POST,
                isMultipart: true,
                body: {'album_id': albumID, 'single_id[]': trackID},
                interceptors: [
                  JsonInterceptor<ErrorModel>(),
                  AuthInterceptor()
                ],
                dataKey: ''));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>>
      deleteAlbumTrack(String trackID, String albumID) {
    return provider.send<Map<String, dynamic>, Map<String, dynamic>>(
        ApiClient.baseRequest<Map<String, dynamic>, Map<String, dynamic>>()
            .copyWith(
                path: ApiUrls.deleteAlbumTrack(albumID),
                method: ApiMethods.DELETE,
                query: {'track_id': trackID},
                interceptors: [
                  JsonInterceptor<ErrorModel>(),
                  AuthInterceptor()
                ],
                dataKey: ''));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>> deleteAlbum(
      String albumID) {
    return provider.send<Map<String, dynamic>, Map<String, dynamic>>(
        ApiClient.baseRequest<Map<String, dynamic>, Map<String, dynamic>>()
            .copyWith(
                path: ApiUrls.deleteAlbum(albumID),
                method: ApiMethods.DELETE,
                interceptors: [
                  JsonInterceptor<ErrorModel>(),
                  AuthInterceptor()
                ],
                dataKey: ''));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>> deleteSingle(
      String singleID) {
    return provider.send<Map<String, dynamic>, Map<String, dynamic>>(
        ApiClient.baseRequest<Map<String, dynamic>, Map<String, dynamic>>()
            .copyWith(
                path: ApiUrls.deleteRelease(singleID),
                method: ApiMethods.DELETE,
                interceptors: [
                  JsonInterceptor<ErrorModel>(),
                  AuthInterceptor()
                ],
                dataKey: ''));
  }
}
