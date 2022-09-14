part of 'wallet_cubit.dart';

class WalletRepository extends DataRepository {
  WalletApiService apiService = WalletApiService();

  Future<ApiResponse<BuiltList<BalanceHistory>, BalanceHistory>>
      history() async {
    return await handleRequest<BuiltList<BalanceHistory>, BalanceHistory>(
        () => apiService.balanceHistory());
  }

  Future<ApiResponse<BuiltList<Map<String, dynamic>>, Map<String, dynamic>>> balance(
) async {
    return await handleRequest<BuiltList<Map<String, dynamic>>, Map<String, dynamic>>(
        () => apiService.balance());
  }
}
