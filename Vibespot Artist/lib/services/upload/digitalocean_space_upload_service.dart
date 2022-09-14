import 'dart:io';

import 'package:dospace/dospace.dart';
import 'package:get_it/get_it.dart';
import 'package:mime/mime.dart';
import 'package:uuid/uuid.dart';
import 'package:vsartist/core/env.dart';

import 'upload_service.dart';

class DigitaloceanSpaceUploadService extends UploadService {
  final Spaces spaces;
  DigitaloceanSpaceUploadService()
      : spaces = Spaces(
          region: GetIt.I<Env>().uploadRegion,
          accessKey: GetIt.I<Env>().uploadApiKey,
          secretKey: GetIt.I<Env>().uploadSecret,
        );

  @override
  void delete(String url) {}

  @override
  Future<String?> upload(String path, [String folderName = '']) async {
    Bucket bucket = spaces.bucket(GetIt.I<Env>().uploadBucketName);
    var file = File(path);
    if (await file.exists()) {
      var fileName = '$folderName/${Uuid().v4()}.${file.path.split('.').last}';
      try {
        await bucket.uploadFile(
            fileName, file, lookupMimeType(path) ?? '', Permissions.public);
        // print('${bucket.endpointUrl}/$fileName');
        return Uri.parse('${bucket.endpointUrl}/$fileName').normalizePath().toString();
      } catch (e) {
        print(e);
      }
    }
  }
}
