part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

/// dispatched when the app starts
class AppStarted extends AuthEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthEvent {
  final User user;
  final String? email;
  final String? token;
  final String? password;
  final bool keepLogin; 

  LoggedIn(this.user,
      {this.token, this.keepLogin = true, this.email, this.password});
  @override
  List<Object?> get props => [user, token, keepLogin, email, password];
  @override
  String toString() => 'LoggedIn';
}

class LogOut extends AuthEvent {
  final bool clearSaved;

  LogOut({this.clearSaved = false});
  @override
  List<Object> get props => [clearSaved];
  @override
  String toString() => 'LogOut: clearSaved: $clearSaved';
}

class UpdateUser extends AuthEvent {
  final User user;

  UpdateUser(this.user);
  @override
  List<Object> get props => [user];
  @override
  String toString() => 'UpdateUser';
}


class UpdateToken extends AuthEvent {
  final String token;

  UpdateToken(this.token) : super();
  @override
  List<Object> get props => [];
  @override
  String toString() => 'UpdateToken';
}
