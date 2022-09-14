import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/constants/strings.dart';
import 'package:vsartist/core/extensions/index.dart';
import 'package:vsartist/data/data_repository.dart';
import 'package:vsartist/data/remote/api_services/wallet_api_service.dart';
import 'package:vsartist/data/remote/provider/api_response.dart';
import 'package:vsartist/models/balance_history.dart';
import 'package:vsartist/models/error_model.dart'; 
import 'package:vsartist/views/widgets/app_dialog.dart';

part 'wallet_state.dart';
part 'wallet_repository.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletState());
  WalletRepository _repository = WalletRepository();

  void balance(BuildContext context) async {
    emit(state.loading());
    var response = await _repository.balance();
    if (response.isSuccessful && (response.body?.length ?? 0) > 0) {
      emit(state.copyWith(
          balance: double.tryParse(response.body![0].getKey('balance'))));
    } else {
      AppDialog.show(
          context,
          'Error',
          (response.error as ErrorModel?)?.message ??
              Strings.DEFAULT_ERROR_MESSAGE);
    }
    emit(state.copyWith());
  }
}
