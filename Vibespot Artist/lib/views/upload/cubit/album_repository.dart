part of 'album_cubit.dart';

class AlbumRepository extends DataRepository {
  MusicApiService apiService = MusicApiService();

  Future<ApiResponse<Album, Album>> createAlbum(
      Map<String, dynamic> body) async {
    return await handleRequest<Album, Album>(
        () => apiService.createAlbum(body));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>> updateAlbum(
      String albumID, Map<String, dynamic> body) async {
    return await handleRequest<Map<String, dynamic>, Map<String, dynamic>>(
        () => apiService.updateAlbum(albumID, body));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>> updateRelease(
      String releaseID, Map<String, dynamic> body) async {
    return await handleRequest<Map<String, dynamic>, Map<String, dynamic>>(
        () => apiService.updateRelease(releaseID, body));
  }

  Future<ApiResponse<Release, Release>> createRelease(
      Map<String, dynamic> body) async {
    return await handleRequest<Release, Release>(
        () => apiService.createRelease(body));
  }

  Future<ApiResponse<Song, Song>> createTrack(Map<String, dynamic> body) async {
    return await handleRequest<Song, Song>(() => apiService.createTrack(body));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>>
      addTrackToPlaylist(String trackId) async {
    return await handleRequest<Map<String, dynamic>, Map<String, dynamic>>(
        () => apiService.addTrackToPlaylist(trackId));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>>
      removeTrackFromPlaylist(String trackId) async {
    return await handleRequest<Map<String, dynamic>, Map<String, dynamic>>(
        () => apiService.removeTrackFromPlaylist(trackId));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>>
      releaseToAlbum(String trackID, String albumID) async {
    return await handleRequest<Map<String, dynamic>, Map<String, dynamic>>(
        () => apiService.releaseToAlbum(trackID, albumID));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>>
      deleteAlbumTrack(String trackID, String albumID) async {
    return await handleRequest<Map<String, dynamic>, Map<String, dynamic>>(
        () => apiService.deleteAlbumTrack(trackID, albumID));
  }

   Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>>
      deleteAlbum( String albumID) async {
    return await handleRequest<Map<String, dynamic>, Map<String, dynamic>>(
        () => apiService.deleteAlbum( albumID));
  }

   Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>>
      deleteSingle(String singleID) async {
    return await handleRequest<Map<String, dynamic>, Map<String, dynamic>>(
        () => apiService.deleteSingle(singleID));
  }
}
