import 'package:built_collection/built_collection.dart';
import 'package:vsartist/constants/api_urls.dart';
import 'package:vsartist/data/remote/interceptors/json_interceptor.dart';

import 'package:vsartist/data/remote/provider/api_methods.dart';
import 'package:vsartist/data/remote/provider/api_request.dart';
import 'package:vsartist/data/remote/provider/api_response.dart';
import 'package:vsartist/models/country.dart';
import 'package:vsartist/models/error_model.dart';
import 'package:vsartist/models/state_city.dart';

import 'base_api_service.dart';

/// API service for managing location, @[getCountries] gets all countries available in the database.
/// @[getStates] gets all states in a country
class LocationApiService extends BaseApiService {
  Future<ApiResponse<String, String>> getToken(String email, String apiKey) {
    return provider.send<String, String>(ApiRequest<String, String>(
        path: 'getaccesstoken',
        baseUrl: ApiUrls.LOCATION_SERVICE,
        method: ApiMethods.GET,
        headers: {
          "Accept": "application/json",
          "api-token": apiKey,
          "user-email": email
        },
        interceptors: [JsonInterceptor<ErrorModel>()],
        error: ErrorDescription(key: ''),
        dataKey: 'auth_token'));
  }

  Future<ApiResponse<BuiltList<Country>, Country>> getCountries(
      String apiToken) {
    return provider.send<BuiltList<Country>, Country>(
        ApiRequest<BuiltList<Country>, Country>(
            path: 'countries',
            baseUrl: ApiUrls.LOCATION_SERVICE,
            method: ApiMethods.GET,
            headers: {
              "Accept": "application/json",
              "Authorization": 'Bearer $apiToken'
            },
            interceptors: [
              JsonInterceptor<ErrorModel>(),
            ],
            error: ErrorDescription(key: ''),
            dataKey: ''));
  }

  Future<ApiResponse<BuiltList<StateCity>, StateCity>> getStates(
      String apiToken, String country) {
    return provider.send<BuiltList<StateCity>, StateCity>(
        ApiRequest<BuiltList<StateCity>, StateCity>(
            path: 'states/$country',
            baseUrl: ApiUrls.LOCATION_SERVICE,
            method: ApiMethods.GET,
            headers: {
              "Accept": "application/json",
              "Authorization": 'Bearer $apiToken'
            },
            interceptors: [
              JsonInterceptor<ErrorModel>(),
            ],
            error: ErrorDescription(key: ''),
            dataKey: ''));
  }

  Future<ApiResponse<BuiltList<StateCity>, StateCity>> getCities(
      String apiToken, String state) {
    return provider.send<BuiltList<StateCity>, StateCity>(
        ApiRequest<BuiltList<StateCity>, StateCity>(
            path: 'cities/$state',
            baseUrl: ApiUrls.LOCATION_SERVICE,
            method: ApiMethods.GET,
            headers: {
              "Accept": "application/json",
              "Authorization": 'Bearer $apiToken'
            },
            interceptors: [
              JsonInterceptor<ErrorModel>(),
            ],
            error: ErrorDescription(key: ''),
            dataKey: ''));
  }
}
