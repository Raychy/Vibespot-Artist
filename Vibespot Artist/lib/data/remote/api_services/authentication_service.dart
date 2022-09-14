import 'package:vsartist/constants/api_urls.dart';
import 'package:vsartist/data/remote/interceptors/json_interceptor.dart';
import 'package:vsartist/data/remote/interceptors/token_interceptor.dart';
import 'package:vsartist/data/remote/provider/api_methods.dart';
import 'package:vsartist/data/remote/provider/api_request.dart';
import 'package:vsartist/data/remote/provider/api_response.dart';
import 'package:vsartist/models/error_model.dart';
import 'package:vsartist/models/user.dart';

import '../api_client.dart';
import 'base_api_service.dart';

class AuthenticationService extends BaseApiService {
  Future<ApiResponse<User, User>> login(String email, String password) {
    return provider
        .send<User, User>(ApiClient.baseRequest<User, User>().copyWith(
            path: ApiUrls.LOGIN,
            method: ApiMethods.POST,
            interceptors: [JsonInterceptor<ErrorModel>(), TokenInterceptor()],
            body: <String, dynamic>{
              'email': email,
              'password': password,
            },
            error: ErrorDescription(key: ''),
            dataKey: 'data'));
  }

  Future<ApiResponse<User, User>> register(Map<String, dynamic> body) {
    print(body);
    return provider.send<User, User>(ApiClient.baseRequest<User, User>()
        .copyWith(
            path: ApiUrls.REGISTER,
            method: ApiMethods.POST,
            interceptors: [JsonInterceptor<ErrorModel>(), TokenInterceptor()],
            error: ErrorDescription(),
            body: body,
            dataKey: 'data'));
  }

  Future<ApiResponse<User, User>> profile() {
    return provider.send<User, User>(ApiClient.baseRequest<User, User>()
        .copyWith(
            path: ApiUrls.PROFILE,
            method: ApiMethods.GET,
            interceptors: [JsonInterceptor<ErrorModel>(), TokenInterceptor()],
            error: ErrorDescription(key: 'body'),
            dataKey: 'data'));
  }

  Future<ApiResponse<User, User>> editProfile(Map<String, dynamic> body) {
    return provider.send<User, User>(ApiClient.baseRequest<User, User>()
        .copyWith(
            path: ApiUrls.EDIT_PROFILE,
            method: ApiMethods.POST,
            // isMultipart: true,
            interceptors: [JsonInterceptor<ErrorModel>(), TokenInterceptor()],
            error: ErrorDescription(key: ''),
            body: body,
            dataKey: 'data'));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>> resetPassword(
      Map<String, dynamic> body) {
    return provider.send<Map<String, dynamic>, Map<String, dynamic>>(
        ApiClient.baseRequest<Map<String, dynamic>, Map<String, dynamic>>()
            .copyWith(
      path: ApiUrls.RESET_PASSWORD,
      method: ApiMethods.POST,
      interceptors: [
        JsonInterceptor<ErrorModel>(),
      ],
      body: body
    ));
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>>
      forgotPassword(String email) {
    return provider.send<Map<String, dynamic>, Map<String, dynamic>>(
        ApiClient.baseRequest<Map<String, dynamic>, Map<String, dynamic>>()
            .copyWith(
      path: ApiUrls.FORGOT_PASSWORD,
      method: ApiMethods.POST,
      interceptors: [
        JsonInterceptor<ErrorModel>(),
      ],
      body: {"email": email},
    ));
  }

  
}
