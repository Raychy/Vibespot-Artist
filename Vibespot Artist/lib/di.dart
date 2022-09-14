import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vsartist/services/upload/digitalocean_space_upload_service.dart';

import 'core/env.dart';
import 'core/preference_store/hive_preference_store.dart';
import 'core/preference_store/preference_store.dart';
import 'core/simple_bloc_delegate.dart';
import 'data/local/hive_repository.dart';
import 'data/local/local_repository.dart';
import 'data/remote/provider/api_provider.dart';
import 'data/remote/provider/http_override.dart';
import 'data/remote/provider/providers/http_api_provider.dart';
import 'services/upload/upload_service.dart';
import 'views/account/bloc/auth/auth_bloc.dart';
import 'views/statistics/playlist/bloc/playlist_bloc.dart';
import 'views/statistics/release/bloc/release_bloc.dart';

/// dependency injection class
class DI {
  static Future<void> setUp() async {
    // initialize hive database
    await Hive.initFlutter();

    GetIt getIt = GetIt.I;
    HttpOverrides.global = MyHttpOverrides();

    Bloc.observer = SimpleBlocDelegate();

    getIt.registerSingletonAsync<PreferenceStore>(() async {
      var pref = HivePreferenceStore();
      await pref.initStore();
      return pref;
    });

    getIt.registerSingletonAsync<LocalRepository>(() async {
      var pref = HiveRepository();
      await pref.init();
      return pref;
    });

    getIt.registerSingleton<ApiProvider>(HttpApiProvider());
    getIt.registerSingleton<Env>(kDebugMode ? Development() : Production());
    GetIt.I.registerSingleton<UploadService>(DigitaloceanSpaceUploadService());

    await GetIt.instance.allReady();
    getIt.registerSingleton<AuthBloc>(AuthBloc());

    Auth..add(AppStarted());
  }

  static Widget providers(Widget child) => MultiProvider(providers: [
        BlocProvider(create: (_) => Auth),
        BlocProvider(create: (_) => PlaylistBloc()),
        // BlocProvider(create: (_) => ReleaseBloc()),
      ], child: child);
}
