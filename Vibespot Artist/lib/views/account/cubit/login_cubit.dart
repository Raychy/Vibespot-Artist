import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:vsartist/constants/strings.dart';
import 'package:vsartist/core/router/app_router.dart';
import 'package:vsartist/core/router/transissions/slide_side_route.dart';

import 'package:vsartist/core/utils/validator_mixin.dart';
import 'package:vsartist/core/extensions/index.dart';
import 'package:vsartist/data/data_repository.dart';
import 'package:vsartist/data/remote/api_services/authentication_service.dart';
import 'package:vsartist/data/remote/file_field.dart';
import 'package:vsartist/data/remote/provider/api_response.dart';
import 'package:vsartist/models/error_model.dart';
import 'package:vsartist/models/user.dart';
import 'package:vsartist/services/upload/upload_service.dart';
import 'package:vsartist/views/account/bloc/auth/auth_bloc.dart';
import 'package:vsartist/views/dashboard.dart';
import 'package:vsartist/views/widgets/app_dialog.dart';
import 'package:vsartist/views/widgets/location/cubit/location_cubit.dart';
import 'package:vsartist/views/widgets/place/address.dart';

import '../../../global_variables.dart';
import '../reset_password.dart';

part 'login_state.dart';
part 'login_repository.dart';

class LoginCubit extends Cubit<LoginState> with ValidatorMixin {
  LoginCubit() : super(LoginState());

  LoginRepository _repository = LoginRepository();

  void addressChanged(Address value) => emit(state.copyWith(address: value));
  void otpChanged(String value) => emit(state.copyWith(otp: value));
  void stageNameChanged(String value) => emit(state.copyWith(stageName: value));
  void youtubeChanged(String value) => emit(state.copyWith(youtubeChannel: value));
  void emailChanged(String email) => emit(state.copyWith(email: email));
  void firstnameChanged(String data) => emit(state.copyWith(firstname: data));
  void lastnameChanged(String data) => emit(state.copyWith(lastname: data));
  void youtubeNameChanged(String data) => emit(state.copyWith(youtubeChannel: data));
  void usernameChanged(String data) => emit(state.copyWith(username: data));
  void confirmPasswordChanged(String data) =>
      emit(state.copyWith(confirmPassword: data));
  void phoneChanged(String data) => emit(state.copyWith(phone: data));
  void countryChanged(String data) =>
      emit(state.copyWith(country: data, city: '', state: ''));
  void stateChanged(String data) => emit(state.copyWith(state: data));
  void cityChanged(String data) => emit(state.copyWith(city: data));
  void passwordChanged(String password) =>
      emit(state.copyWith(password: password));
  void setLoading() => emit(state.copyWith(isLoading: true));
  void loadingStopped() => emit(state.copyWith());

  void login(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    handleAuthPayload(context,
        await _repository.login(state.email ?? '', state.password ?? ''));
    emit(state.copyWith(isLoading: false));
  }

  void register(
    BuildContext context,
  ) async {
    emit(state.copyWith(isLoading: true));
    handleAuthPayload(context, await _repository.register(state.signupToMap()));
    emit(state.copyWith(isLoading: false));
  }

  void updateProfile(BuildContext context, String? image) async {
    emit(state.copyWith(isLoading: true));
    var response = await _repository.updateProfile(state.profileToMap(image));

    emit(state.copyWith(isLoading: false));
    if (response.isSuccessful) {
      AppDialog.show(AppRouter.navigationKey.currentContext!, 'Profile updated',
          'Profile updated successfully');
      LoginRepository().getProfile();
    } else {
      showError(
          context,
          (response.error as ErrorModel?) ??
              ErrorModel((b) => b..message = Strings.DEFAULT_ERROR_MESSAGE));
    }
  }

  Future uploadImage(BuildContext context, String path) async {
    var link = await GetIt.I<UploadService>().upload(path);
    var response = await _repository.updateProfile({'artist_image': link});
    AppRouter.navigationKey.currentState?.pop();
    if (response.isSuccessful) {
      AppDialog.show(AppRouter.navigationKey.currentContext!, 'Profile updated',
          'image updated successfully');
      LoginRepository().getProfile();
    } else {
      showError(
          context,
          (response.error as ErrorModel?) ??
              ErrorModel((b) => b..message = Strings.DEFAULT_ERROR_MESSAGE));
    }
  }

  void forgotPassword(BuildContext context) async {
    emit(state.copyWith(isLoading: true));
    var response = await _repository.forgotPassword(state.email ?? '');
    if (response.isSuccessful && response.body != null) {
      AppRouter.navigationKey.currentState!.pop();

      Navigator.push(
          AppRouter.navigationKey.currentContext!,
          SlideSideRoute(
              settings: RouteSettings(name: 'ResetPassword'),
              page: ResetPassword(email: state.email ?? '')));

      AppDialog.show(AppRouter.navigationKey.currentContext!, 'Reset sent',
          'Reset Token Sent to Your Mail');
    } else {
      showError(
          context,
          (response.error as ErrorModel?) ??
              ErrorModel((b) => b..message = Strings.DEFAULT_ERROR_MESSAGE));
    }
    emit(state.copyWith(isLoading: false));
  }

  void handleAuthPayload(
      BuildContext context, ApiResponse<User, User> response) {
    if (response.isSuccessful && response.body != null) {
      var token = response.extra?.getKey<String>('token');
      Auth.add(LoggedIn(response.body!, token: token));
      USER_ID.value=response.body!.id!.toInt();
      print("User id added");
      print(USER_ID.value);
      Navigator.of(context)
          .popUntil((route) => !Navigator.of(context).canPop());
      Navigator.of(context).pushReplacementNamed(Dashboard.routeName);
    } else {
      showError(
          context,
          (response.error as ErrorModel?) ??
              ErrorModel((b) => b..message = Strings.DEFAULT_ERROR_MESSAGE));
    }
  }

  void resetPassword(BuildContext context, String email) async {
    emit(state.copyWith(isLoading: true));
    var response = await _repository.resetPassword(state.resetToMap(email));
    if (response.isSuccessful && response.body != null) {
      AppRouter.navigationKey.currentState!.pop();

      AppDialog.show(AppRouter.navigationKey.currentContext!, 'Reset success',
          'Password reset was successful');
    } else {
      showError(
          context,
          (response.error as ErrorModel?) ??
              ErrorModel((b) => b..message = Strings.DEFAULT_ERROR_MESSAGE));
    }
    emit(state.copyWith(isLoading: false));
  }

  showError(BuildContext context, ErrorModel error, [List<String>? override]) {
    var message = error.error ?? error.message ?? error.body ?? '';
    if (error.errors != null &&
        error.errors!.values.isNotEmpty &&
        error.errors!.values.first.isNotEmpty)
      message = error.errors!.values.first.first;
    AppDialog.show(context, 'Error', message);
  }

  bool get loginValid =>
      emailValidator(state.email ?? '') == null &&
      passwordValidator(state.password ?? '') == null;

  bool get resetValid =>
      passwordValidator(state.password ?? '') == null &&
      confirmPasswordValidator(
              state.password ?? '', state.confirmPassword ?? '') ==
          null &&
      otpValidator(state.otp ?? '') == null;

  bool isNotEmpty(String? value) => value != null && value.isNotEmpty;

  bool get signupValid =>
      emailValidator(state.email ?? '') == null &&
      passwordValidator(state.password ?? '') == null &&
      confirmPasswordValidator(
              state.password ?? '', state.confirmPassword ?? '') ==
          null &&
      isNotEmpty(state.lastname) &&
      isNotEmpty(state.firstname) &&
      // isNotEmpty(state.username) &&
      isNotEmpty(state.phone) &&
      isNotEmpty(state.stageName) &&
      state.address != null;

  bool get profileValid =>
      emailValidator(state.email ?? '') == null &&
      isNotEmpty(state.lastname) &&
      isNotEmpty(state.firstname) &&
      // isNotEmpty(state.username) &&
      isNotEmpty(state.phone) &&
      state.address != null;
}
