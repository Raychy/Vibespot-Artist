part of 'track_bloc.dart';

class TrackRepository extends DataRepository with PaginationHandlerMixin {
  final TrackBloc? bloc;
  MusicApiService apiService = MusicApiService();
  final String path;

  TrackRepository(this.path, [this.bloc]) : super();

  Future<void> loadData(
      {bool loadMore = false, String? id, Map<String, dynamic>? query}) async {
    int page = loadMore ? ((bloc?.state.page ?? 1) + 1) : 1;
    query ??= <String, dynamic>{};
    query['page'] = '$page';
    var response = await handleRequest<BuiltList<Song>, Song>(
        () => apiService.getTracks(path, query!));
    handleRespone<Song>(
      bloc as TrackBloc,
      response,
      isMore: loadMore,
    );
  }
}
