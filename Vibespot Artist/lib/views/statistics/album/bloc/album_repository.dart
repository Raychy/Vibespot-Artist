part of 'album_bloc.dart';

class AlbumRepository extends DataRepository with PaginationHandlerMixin {
  final AlbumBloc? bloc;
  MusicApiService apiService = MusicApiService();

  AlbumRepository([this.bloc]) : super();

  Future<void> loadData(
      {bool loadMore = false, String? id, Map<String, dynamic>? query}) async {
    int page = loadMore ? ((bloc?.state.page ?? 1) + 1) : 1;
    query ??= <String, dynamic>{};
    query['page'] = '$page';
    // query['limit'] = '5';
    var response = await handleRequest<BuiltList<Album>, Album>(() => 
     apiService.getAlbums(query!));
    handleRespone<Album>(
      bloc as AlbumBloc,
      response,
      isMore: loadMore,
    );
  }
}
