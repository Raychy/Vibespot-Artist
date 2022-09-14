part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  final String uid;
  final User? user;
  final String? token;
  const AuthState(
    this.token,
    this.user,
    this.uid,
  );
  AuthState copywith({String? token, User? user});
  @override
  List<Object?> get props => [user, token, uid];
}

/// the app is yet to verify authentication status
class AuthUninitialized extends AuthState {
  AuthUninitialized() : super(null, null, Uuid().v1());
  @override
  String toString() => 'AuthUninitialized';

  @override
  AuthState copywith({String? token, User? user}) => AuthUninitialized();
}

/// user is signed in
class Authenticated extends AuthState {
  Authenticated(String? token, User? user) : super(token, user, Uuid().v1());

  @override
  String toString() =>
      'Authenticated : ${this.uid}, ${this.user?.email}, user: $user';

  @override
  AuthState copywith({String? token, User? user, bool? useBiometrics}) =>
      Authenticated(token ?? this.token, user ?? this.user);
}

/// user has not signed in
class UnAuthenticated extends AuthState {
  UnAuthenticated(User? user) : super(null, user, Uuid().v1());

  @override
  AuthState copywith({String? token, User? user}) =>
      UnAuthenticated(user ?? this.user);

  @override
  String toString() => 'UnAuthenticated: ';
}
