import 'package:flutter/material.dart';
import 'package:vsartist/views/artist_features/uploads/album_upload_file.dart';
import 'package:vsartist/views/artist_features/uploads/singles-upload.dart';

class UploadCommon {
  singleUploadPage(context, pages, page, releaseName, tracksModel) {
    return Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new SinglesUpload(
          pages: pages,
          releaseName: releaseName,
          uploadSingles: tracksModel,
          pager: page);
    }));
  }

  albumTrackPage(
      context, pages, page, releaseName, tracksModel, List<int>? single_Ids) {
    return Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new AlbumUpload(
        pages: pages,
        releaseName: releaseName,
        uploadAlbum: tracksModel,
        page: page,
        single_Ids: single_Ids,

        // single_Ids:
      );
    }));
  }

  // albumTrackSelectIdsPage(
  //     context, pages, page, releaseName, tracksModel, List<int> selectedIds) {
  //   return Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
  //     return new AlbumSelectedIdsUpload(
  //         pages: pages,
  //         releaseName: releaseName,
  //         uploadAlbum: tracksModel,
  //         page: page,
  //         songs: selectedIds);
  //   }));
  // }
}
