import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:uuid/uuid.dart';
import 'package:vsartist/constants/pref_keys.dart';
import 'package:vsartist/models/user.dart';
import 'package:vsartist/services/secure_store.dart';
import 'package:vsartist/views/account/cubit/login_cubit.dart';

part 'auth_event.dart';
part 'auth_state.dart';

/// authentication bloc
// ignore: non_constant_identifier_names
final AuthBloc Auth = GetIt.I.get<AuthBloc>();

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  SecureStore _secureStore = SecureStore();
  static final AuthBloc _authBlocSingleton = AuthBloc._internal();

  factory AuthBloc() => _authBlocSingleton;

  AuthBloc._internal() : super(AuthUninitialized());
  @override
  Future<void> close() {
    _authBlocSingleton.close();
    return super.close();
  }

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AppStarted && state is AuthUninitialized)
      yield* _mapAppStartedToState(event);
    else if (event is LoggedIn)
      yield* _mapLoggedInToState(event);
    else if (event is UpdateUser) {
      yield state.copywith(user: event.user);
      var user = event.user.toJson();
      if (user != null) _secureStore.setString(PrefKeys.USER, user);
    } else if (event is UpdateToken)
      yield* _mapUpdateTokenToState(event);
    else if (event is LogOut)
      yield* _mapLogOutToState(event);
    else if (event is UpdateUser) yield Authenticated(state.token, event.user);
  }

  Stream<AuthState> _mapLogOutToState(LogOut event) async* {
    if (event.clearSaved) {
      _secureStore.deleteKey(PrefKeys.EMAIL);
      _secureStore.deleteKey(PrefKeys.PASSWORD);
    }
    yield UnAuthenticated(event.clearSaved ? null : state.user);
  }

  Stream<AuthState> _mapUpdateTokenToState(UpdateToken event) async* {
    yield state.copywith(token: event.token);
    _secureStore.setString(PrefKeys.TOKEN, event.token);
  }

  Stream<AuthState> _mapLoggedInToState(LoggedIn event) async* {
    yield Authenticated(event.token, event.user);
    if (event.keepLogin) {
      if (event.email != null && event.email!.isNotEmpty)
        _secureStore.setString(PrefKeys.EMAIL, event.email!);
      if (event.password != null && event.password!.isNotEmpty)
        _secureStore.setString(PrefKeys.PASSWORD, event.password!);
      var user = event.user.toJson();
      if (user != null) _secureStore.setString(PrefKeys.USER, user);
      if (event.token != null)
        _secureStore.setString(PrefKeys.TOKEN, event.token!);
    }
  }

  Stream<AuthState> _mapAppStartedToState(AuthEvent event) async* {
    String? token = await _secureStore.getString(PrefKeys.TOKEN);
    String? usr = await _secureStore.getString(PrefKeys.USER);
    var user = User.fromJson(usr ?? '');

    if (user != null && token != null) {
      yield Authenticated(token, user);
      LoginRepository().getProfile();
    } else
      yield UnAuthenticated(user);
  }
}
