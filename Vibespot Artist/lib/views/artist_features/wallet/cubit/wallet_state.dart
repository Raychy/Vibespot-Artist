part of 'wallet_cubit.dart';

class WalletState extends Equatable {
  final double balance;
  final bool isLoading;

  WalletState({this.isLoading = false, this.balance = 0.0});
  WalletState copyWith({
    double? balance,
  }) =>
      WalletState(balance: balance ?? this.balance);

  WalletState loading() => WalletState(balance: balance, isLoading: true);

  @override
  List<Object> get props => [balance, isLoading];
}
