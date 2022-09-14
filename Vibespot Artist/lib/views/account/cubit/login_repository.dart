part of 'login_cubit.dart';

class LoginRepository extends DataRepository {
  AuthenticationService apiService = AuthenticationService();

  Future<ApiResponse<User, User>> login(String email, String password) async {
    return await handleRequest<User, User>(
        () => apiService.login(email, password));
  }

  Future<ApiResponse<User, User>> register(Map<String, dynamic> body) async {
    return await handleRequest<User, User>(() => apiService.register(body));
  }

  Future<ApiResponse<User, User>> getProfile() async {
    var response = await handleRequest<User, User>(() => apiService.profile());
    if (response.isSuccessful && response.body != null) {
      Auth.add(UpdateUser(response.body!));
    }
    return response;
  }

  Future<ApiResponse<User, User>> updateProfile(
      Map<String, dynamic> body) async {
    var response =
        await handleRequest<User, User>(() => apiService.editProfile(body));
    if (response.isSuccessful && response.body != null) {
      Auth.add(UpdateUser(response.body!));
    }
    return response;
  }

  Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>>
      forgotPassword(String email) async {
    return await handleRequest<Map<String, dynamic>, Map<String, dynamic>>(
        () => apiService.forgotPassword(email));
  }

    Future<ApiResponse<Map<String, dynamic>, Map<String, dynamic>>>
    resetPassword(Map<String, dynamic> body) async {
    return await handleRequest<Map<String, dynamic>, Map<String, dynamic>>(
        () => apiService.resetPassword(body));
  }
}
