part of 'location_cubit.dart';

class LocationRepository extends DataRepository {
  LocationApiService apiService = LocationApiService();

  Future<ApiResponse<String, String>> getToken(
      String email, String apiKey) async {
    return await handleRequest<String, String>(
        () => apiService.getToken(email, apiKey));
  }

  Future<ApiResponse<BuiltList<Country>, Country>> getCountries(
      String apiToken) async {
    return await handleRequest<BuiltList<Country>, Country>(
        () => apiService.getCountries(apiToken),
        cache: CacheDescription('universal-tutorial.com-country',
            lifeSpan: CacheDescription.SEVEN_DAYS));
  }

  Future<ApiResponse<BuiltList<StateCity>, StateCity>> getStates(
      String apiToken, String country) async {
    return await handleRequest<BuiltList<StateCity>, StateCity>(
        () => apiService.getStates(apiToken, country),
        cache: CacheDescription('universal-tutorial.com-$country',
            lifeSpan: CacheDescription.SEVEN_DAYS));
  }

  Future<ApiResponse<BuiltList<StateCity>, StateCity>> getCities(
      String apiToken, String state) async {
    return await handleRequest<BuiltList<StateCity>, StateCity>(
        () => apiService.getCities(apiToken, state),
        cache: CacheDescription('universal-tutorial.com-state$state',
            lifeSpan: CacheDescription.SEVEN_DAYS));
  }
}
