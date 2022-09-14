import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:vsartist/constants/api_urls.dart';
import 'package:vsartist/core/extensions/index.dart';
import 'package:vsartist/core/router/app_router.dart';
import 'package:vsartist/core/router/transissions/slide_side_route.dart';
import 'package:vsartist/data/remote/provider/api_response.dart';
import 'package:vsartist/global_variables.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/models/error_model.dart';
import 'package:vsartist/views/statistics/playlist/bloc/playlist_bloc.dart';
import 'package:vsartist/views/statistics/track/album_track_screen.dart';
import 'package:vsartist/views/statistics/track/bloc/track_bloc.dart';
import 'package:vsartist/views/upload/cubit/album_cubit.dart';
import 'package:vsartist/views/widgets/app_dialog.dart';
import 'package:vsartist/views/widgets/location/cubit/location_cubit.dart';
import 'package:vsartist/views/widgets/place/address.dart';

import '../upload_options.dart';

part 'track_state.dart';

class TrackCubit extends Cubit<TrackState> {
  TrackCubit() : super(TrackState());
  AlbumRepository _repository = AlbumRepository();

  void featuringByChanged(String? value) =>
      emit(state.copyWith(featuringBy: value));
  void producedByChanged(String? value) =>
      emit(state.copyWith(producedBy: value));
  void pushLocationChanged(Address? value) =>
      emit(state.copyWith(pushLocation: value));
  void sateVibesChanged(Address? value) =>
      emit(state.copyWith(sateVibes: value));
  void titleChanged(String? value) => emit(state.copyWith(title: value));

  void genreChanged(String? value) => emit(state.copyWith(genre: value));
  void paymentChanged(String? value) => emit(state.copyWith(payment: value));

  void imageChanged(String? value) => emit(state.copyWith(image: value));
  void audioChanged(String? value) => emit(state.copyWith(audio: value));

  void trackCountChanged(int? value) => emit(state.copyWith(trackCount: value));

  void releaseDateChanged(DateTime? value) =>
      emit(state.copyWith(releaseDate: value));

  void updateDuration(Duration duration) =>
      emit(state.copyWith(duration: duration));

  Future createTrack(BuildContext context, LocationState location,
      {int? albumId,
      int? releaseId,
      Widget? navigateTo,
      int count = 1,
      int position = 1, int total =1,
      Function()? reloadList}) async {
    emit(state.loading());
    AppDialog.showLoadingDialog(context);

    var response = await _repository
        .createTrack(state.toMap(albumId: albumId, releaseId: releaseId));

    AppRouter.navigationKey.currentState?.pop();
    if (reloadList != null) reloadList();
    if (response.isSuccessful && response.body != null) {
      // print(response.body);
      if (GetIt.I.isRegistered<TrackBloc>()) {
        GetIt.I<TrackBloc>().load();
      }

      Navigator.of(context).pop();
      var album = Album((b) => b
        ..title = ''
        ..description = ''
        ..id = albumId);
      if (count > 1 && albumId != null) {
        Navigator.push(
            AppRouter.navigationKey.currentContext!,
            SlideSideRoute(
                settings: RouteSettings(name: 'track upload'),
                page: UploadOptions(
                    album: album, count: count - 1, position: position + 1, total: total
                    // reloadPage: _reload(),
                    )));
      }
      // var album = Album((b) => b
      //   ..title = ''
      //   ..description = ''
      //   ..id = albumId);
      // Navigator.pop(context);
      // Navigator.of(context).pushReplacement(SlideSideRoute(
      //     settings: RouteSettings(name: 'track upload'),
      //     page: UploadOptions(
      //       count: count - 1,
      //       navigateTo: AlbumTrackScreen(data: album, startMode: true),
      //       album: album,
      //       // reloadPage: _reload(),
      //     )));
      // } else {
      //   Navigator.of(context).pushReplacement(SlideSideRoute(
      //       page: navigateTo, settings: RouteSettings(name: '')));
      // }
      // } else {

      // }
      Future.delayed(Duration(milliseconds: 200), () {
        AppDialog.show(context, 'Uploaded', 'track uploaded successfully');
      });
    } else {
      AppDialog.error(AppRouter.navigationKey.currentContext!,
          title: 'Error', error: (response.error as ErrorModel?));
    }
    emit(state.copyWith());
  }

  Future<void> addTrackToPlaylist(BuildContext context, String trackID) async {
    emit(state.loading());
    AppDialog.showLoadingDialog(context);

    var response = await _repository.addTrackToPlaylist(trackID);
    AppRouter.navigationKey.currentState?.pop();
    if (response.isSuccessful && response.body != null) {
      var message = response.body?.getKey<String>('message') ?? '';
      AppDialog.show(context, 'Success', 'Added track to your playlist');
    } else {
      AppDialog.error(context,
          title: 'Error', error: (response.error as ErrorModel?));
    }
    emit(state.copyWith());
    BlocProvider.of<PlaylistBloc>(context).load();
  }

  Future<void> removeTrackFromPlaylist(
      BuildContext context, String trackID) async {
    emit(state.loading());
    AppDialog.showLoadingDialog(context);

    var response = await _repository.removeTrackFromPlaylist(trackID);
    AppRouter.navigationKey.currentState?.pop();
    if (response.isSuccessful && response.body != null) {
      // var message = response.body?.getKey<String>('message') ?? '';
      AppDialog.show(context, 'Success', 'Removed song from playlist');
    } else {
      AppDialog.error(context,
          title: 'Error', error: (response.error as ErrorModel?));
    }
    emit(state.copyWith());
    BlocProvider.of<PlaylistBloc>(context).load();
  }

  Future<void> releaseToAlbum(
      BuildContext context, String trackID, String albumID,
      {int count = 1, int position = 1, int total = 1}) async {
    emit(state.loading());
    AppDialog.showLoadingDialog(context);

    var response = await _repository.releaseToAlbum(trackID, albumID);

    AppRouter.navigationKey.currentState?.pop();

    if (response.isSuccessful && response.body != null) {
      AppRouter.navigationKey.currentState?.pop();
      GetIt.I<TrackBloc>().load();
      if (count > 1) {
        var album = Album((b) => b
          ..title = ''
          ..description = ''
          ..id = int.tryParse(albumID) ?? 0);
        Navigator.push(
            AppRouter.navigationKey.currentContext!,
            SlideSideRoute(
                settings: RouteSettings(name: 'track upload'),
                page: UploadOptions(
                  album: album,
                  count: count - 1, total: total,
                  position: position + 1,
                  // reloadPage: _reload(),
                )));
      } else {
        AppDialog.show(
          AppRouter.navigationKey.currentContext!,
          'Success',
          'track added to your album',
        );
      }
    } else {
      AppDialog.error(context,
          title: 'Error', error: (response.error as ErrorModel?));
    }
    emit(state.copyWith());
  }

  Future<void> delete(BuildContext context,
      {String? albumID,
      String? releaseID,
      String? trackID,
      int count = 1}) async {
    emit(state.loading());
    AppDialog.showLoadingDialog(context);

    String message = '';

    ApiResponse<Map<String, dynamic>, Map<String, dynamic>>? response;
    if (trackID != null && albumID != null) {
      response = await _repository.deleteAlbumTrack(trackID, albumID);
      message = 'successfully deleted track';
      // print(
      //     'in auth interceptor response $trackID, $albumID  ${response.statusCode} ${response.body}');
    } else if (albumID != null) {
      response = await _repository.deleteAlbum(albumID);
      message = 'successfully deleted album';
    } else if (releaseID != null) {
      response = await _repository.deleteSingle(releaseID);

      message = 'successfully deleted single';
    }

    // AppRouter.navigationKey.currentState?.pop();

    if ((response?.isSuccessful ?? false) && response?.body != null) {
      AppRouter.navigationKey.currentState?.pop();
      AppDialog.show(context, 'Success', message);
    } else {
      AppDialog.error(context,
          title: 'Error', error: (response?.error as ErrorModel?));
    }
    emit(state.copyWith());
  }
}
