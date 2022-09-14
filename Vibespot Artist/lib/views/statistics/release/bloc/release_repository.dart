part of 'release_bloc.dart';

class ReleaseRepository extends DataRepository with PaginationHandlerMixin {
  final ReleaseBloc? bloc;
  MusicApiService apiService = MusicApiService();

  ReleaseRepository([this.bloc]) : super();

  Future<void> loadData(
      {bool loadMore = false, String? id, Map<String, dynamic>? query}) async {
    int page = loadMore ? ((bloc?.state.page ?? 1) + 1) : 1;
    query ??= <String, dynamic>{};
    query['page'] = '$page';
    var response = await handleRequest<BuiltList<Release>, Release>(
        () => apiService.getReleases(query!));
    handleRespone<Release>(
      bloc as ReleaseBloc,
      response,
      isMore: loadMore,
    );
  }
}
