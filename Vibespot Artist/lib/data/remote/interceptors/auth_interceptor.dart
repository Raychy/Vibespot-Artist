import 'package:flutter/foundation.dart';
import 'package:vsartist/core/router/app_router.dart';
import 'package:vsartist/data/remote/interceptors/api_interceptor.dart';
import 'package:vsartist/data/remote/provider/api_response.dart';
import 'package:vsartist/views/account/bloc/auth/auth_bloc.dart';
import 'package:vsartist/views/widgets/app_dialog.dart';
// import 'package:vsartist/views/auth/cubit/auth/auth_bloc.dart';

/// monitor Api response and dispatch logout of the status code is 401
class AuthInterceptor extends ApiInterceptor {
  @override
  ApiResponse<ResponseType, InnerType> onError<ResponseType, InnerType>(
      ApiResponse<ResponseType, InnerType> response) {
    if (kDebugMode)
      print('in auth interceptor response ${response.statusCode}');
    if (response.statusCode == 401 && Auth.state is Authenticated) {
      Auth.add(LogOut(clearSaved: false));
      Future.delayed(Duration(milliseconds: 700), () {
        AppDialog.show(
            AppRouter.navigationKey.currentContext!, 'Session expired', '');
      });
    }
    return response;
  }
}
