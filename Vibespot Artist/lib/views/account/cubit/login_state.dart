part of 'login_cubit.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String? email, password, confirmPassword;
  final Address? address;

  final String? firstname,
      lastname,
      youtubeChannel,
      username,
      phone,
      country,
      state,
      city,
      otp,
      stageName;

  LoginState(
      {this.confirmPassword,
      this.firstname,
      this.username,
      this.phone,
      this.country,
      this.state,
      this.city,
      this.otp,
      this.lastname,
        this.youtubeChannel,
      this.email,
      this.password,
      this.stageName,
      this.address,
      this.isLoading = false});
  LoginState copyWith(
          {String? email,
          String? password,
          bool? isLoading,
          String? firstname,
          String? username,
          String? lastname,
          String? youtubeChannel,
          String? phone,
          String? country,
          String? state,
          String? city,
          String? otp,
          String? stageName,
          Address? address,
          String? confirmPassword}) =>
      LoginState(
          address: address ?? this.address,
          email: email ?? this.email,
          password: password ?? this.password,
          city: city ?? this.city,
          state: state ?? this.state,
          lastname: lastname ?? this.lastname,
          youtubeChannel: youtubeChannel ?? this.youtubeChannel,
          country: country ?? this.country,
          phone: phone ?? this.phone,
          username: username ?? this.username,
          firstname: firstname ?? this.firstname,
          confirmPassword: confirmPassword ?? this.confirmPassword,
          stageName: stageName ?? this.stageName,
          otp: otp ?? this.otp,
          isLoading: isLoading ?? false);

  @override
  List<Object?> get props => [
        isLoading,
        email,
        password,
        firstname,
        username,
        phone,
        country,
        state,
        city,
        confirmPassword,
        lastname,
    youtubeChannel,
        stageName,
        otp,
        address
      ];
  Map<String, dynamic> signupToMap() => {
        'surname': lastname,
        'firstname': firstname,
        // 'username': username,
        'email': email,
        'password': password,
        'password_confirm': confirmPassword,
        'youtube_channel': youtubeChannel,
        'phone': phone,
        'stage_name': stageName,
        'country': address?.country,
        'state': address?.state,
        'city': address?.city
      };

  Map<String, dynamic> profileToMap(String? image) => {
        'surname': lastname,
        'firstname': firstname,
        'phone': phone,
        'artist_image': image,
        'stage_name': stageName,
        'country': address?.country,
        'youtube_channel': youtubeChannel,
        'state': address?.state,
        'city': address?.city
      };
  Map<String, dynamic> resetToMap(String email) => {
        'password_confirm': confirmPassword,
        'password': password,
        'token': otp,
        'email': email
      };
}
