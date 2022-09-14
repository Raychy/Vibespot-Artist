part of 'playlist_bloc.dart';

class PlaylistRepository extends DataRepository with PaginationHandlerMixin {
  final PlaylistBloc? bloc;
  MusicApiService apiService = MusicApiService();

  PlaylistRepository([this.bloc]) : super();

  Future<void> loadData(
      {bool loadMore = false, String? id, Map<String, dynamic>? query}) async {
    int page = loadMore ? ((bloc?.state.page ?? 1) + 1) : 1;
    query ??= <String, dynamic>{};
    query['page'] = '$page';
    var response = await handleRequest<BuiltList<Playlist>, Playlist>(
        () => apiService.getPlaylists(query!));
    handleRespone<Playlist>(
      bloc as PlaylistBloc,
      response,
      isMore: loadMore,
    );
  }

  
}
