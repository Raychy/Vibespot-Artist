import 'package:built_collection/built_collection.dart';
import 'package:vsartist/constants/api_urls.dart';
import 'package:vsartist/data/remote/interceptors/auth_interceptor.dart';
import 'package:vsartist/data/remote/interceptors/json_interceptor.dart';
import 'package:vsartist/data/remote/provider/api_methods.dart';
import 'package:vsartist/data/remote/provider/api_response.dart';
import 'package:vsartist/models/balance_history.dart';
import 'package:vsartist/models/error_model.dart'; 

import '../api_client.dart';
import 'base_api_service.dart';

class WalletApiService extends BaseApiService {
  Future<ApiResponse<BuiltList<Map<String, dynamic>>, Map<String, dynamic>>> balance() {
    return provider.send<BuiltList<Map<String, dynamic>>, Map<String, dynamic>>(
        ApiClient.baseRequest<BuiltList<Map<String, dynamic>>, Map<String, dynamic>>()
            .copyWith(
      path: ApiUrls.WALLET_BALANCE,
      method: ApiMethods.GET,
      interceptors: [
        JsonInterceptor<ErrorModel>(),
        AuthInterceptor()
      ],
    ));
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
}
