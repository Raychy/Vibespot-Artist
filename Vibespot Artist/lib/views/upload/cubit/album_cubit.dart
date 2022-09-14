import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:vsartist/constants/api_urls.dart';
import 'package:vsartist/core/extensions/index.dart';
import 'package:vsartist/core/router/app_router.dart';
import 'package:vsartist/core/router/transissions/slide_side_route.dart';
import 'package:vsartist/data/data_repository.dart';
import 'package:vsartist/data/remote/api_services/music_api_service.dart';
import 'package:vsartist/data/remote/file_field.dart';
import 'package:vsartist/data/remote/provider/api_response.dart';
import 'package:vsartist/models/album.dart';
import 'package:vsartist/models/error_model.dart';
import 'package:vsartist/models/release.dart';
import 'package:vsartist/models/song.dart';
import 'package:vsartist/views/statistics/track/album_track_screen.dart';
import 'package:vsartist/views/upload/track_upload.dart';
import 'package:vsartist/views/widgets/app_dialog.dart';

import '../upload_options.dart';

part 'album_state.dart';
part 'album_repository.dart';

class AlbumAlbum extends Cubit<AlbumState> {
  AlbumAlbum() : super(AlbumState());
  AlbumRepository _repository = AlbumRepository();

  void titleChanged(String? value) => emit(state.copyWith(title: value));

  void descriptionChanged(String? value) =>
      emit(state.copyWith(description: value));

  void imageChanged(String? value) => emit(state.copyWith(image: value));

  void trackCountChanged(int? value) => emit(state.copyWith(trackCount: value));

  void releaseDateChanged(DateTime? value) =>
      emit(state.copyWith(releaseDate: value));

  void createAlbum(
    BuildContext context,
  ) async {
    emit(state.loading());
    AppDialog.showLoadingDialog(context);

    var response = await _repository.createAlbum(state.toMap);
    AppRouter.navigationKey.currentState?.pop();
    if (response.isSuccessful && response.body != null) {
      Navigator.of(context).pushReplacement(SlideSideRoute(
          settings: RouteSettings(name: 'album-track'),
          page: AlbumTrackScreen(data: response.body!, startMode: true)));

      // Navigator.of(context).pushReplacement(SlideSideRoute(
      //     settings: RouteSettings(name: 'track upload'),
      //     page: UploadOptions(
      //       count: state.trackCount ?? 1,
      //       navigateTo: AlbumTrackScreen(data: response.body!, startMode: true),
      //       album: response.body!,
      //       // reloadPage: _reload(),
      //     )));
    } else {
      // if(response.statusCode == 413)
      // print('response.statusCode--${response.statusCode}');
      // print(response.isSuccessful);
      if (response.statusCode == 413)
        AppDialog.show(context, 'Error',
            'Large file uploaded, please upload a smaller file');
      else
        AppDialog.error(context,
            title: 'Error', error: (response.error as ErrorModel?));
    }
    emit(state.copyWith());
  }

  void updateAlbum(BuildContext context, String albumID) async {
    emit(state.loading());
    AppDialog.showLoadingDialog(context);

    var response = await _repository.updateAlbum(albumID, state.toMap);
    AppRouter.navigationKey.currentState?.pop();
    if (response.isSuccessful && response.body != null) {
      Navigator.of(context).pop();
      AppDialog.show(
          AppRouter.navigationKey.currentContext!, 'Update Success', '');
    } else {
      // if(response.statusCode == 413)
      // print('response.statusCode--${response.statusCode}');
      // print(response.isSuccessful);
      if (response.statusCode == 413)
        AppDialog.show(context, 'Error',
            'Large file uploaded, please upload a smaller file');
      else
        AppDialog.error(context,
            title: 'Error', error: (response.error as ErrorModel?));
    }
    emit(state.copyWith());
  }

  void updateRelease(BuildContext context, String releaseID) async {
    emit(state.loading());
    AppDialog.showLoadingDialog(context);

    var response =
        await _repository.updateRelease(releaseID, state.releaseToMap);
    AppRouter.navigationKey.currentState?.pop();
    if (response.isSuccessful && response.body != null) {
      Navigator.of(context).pop();
      AppDialog.show(
          AppRouter.navigationKey.currentContext!, 'Update Success', '');
    } else {
      if (response.statusCode == 413) {
        AppDialog.show(context, 'Error',
            'Large file uploaded, please upload a smaller file');
      } else
        AppDialog.error(context,
            title: 'Error', error: (response.error as ErrorModel?));
    }
    emit(state.copyWith());
  }

  void createRelease(BuildContext context) async {
    emit(state.loading());
    AppDialog.showLoadingDialog(context);
    IMAGE_URL.value= state.image!;
    var response = await _repository.createRelease(state.releaseToMap);
    AppRouter.navigationKey.currentState?.pop();
    if (response.isSuccessful && response.body != null) {
      // print(response.body);
      Navigator.of(context).pushReplacement(SlideSideRoute(
          settings: RouteSettings(name: 'release-track'),
          page: TrackUpload(
            release: response.body!,
            // navigateTo: ReleaseTrackScreen(data: response.body!)
          )));
    } else {
      AppDialog.error(context,
          title: 'Error', error: (response.error as ErrorModel?));
    }
    emit(state.copyWith());
  }
}
