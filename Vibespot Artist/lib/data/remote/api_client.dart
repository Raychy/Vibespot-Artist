import 'package:get_it/get_it.dart';
import 'package:vsartist/core/env.dart';
import 'package:vsartist/views/account/bloc/auth/auth_bloc.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/header_interceptor.dart';
import 'provider/api_request.dart';

class ApiClient {
  static var env = GetIt.I.get<Env>();
  static ApiRequest<ResponseType, InnerType>
      baseRequest<ResponseType, InnerType>() =>
          ApiRequest<ResponseType, InnerType>(
            baseUrl: env.baseUrl,
            dataKey: 'data',
            interceptors: [
              HeaderInterceptor({
                'Authorization': 'Bearer ${Auth.state.token}',
                "Content-Type": "application/json",
                "Accept": "application/json",
              }),
              AuthInterceptor(),
            ],
          );
}
