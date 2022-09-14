import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:vsartist/constants/app_colors.dart';
import 'package:vsartist/core/router/app_router.dart';
import 'package:vsartist/services/upload/upload_service.dart';
import 'package:vsartist/views/upload/cubit/track_cubit.dart';
import 'package:vsartist/views/widgets/app_dialog.dart';

class AudioUpload extends StatefulWidget {
  final TrackCubit cubit;
  const AudioUpload({Key? key, required this.cubit}) : super(key: key);

  @override
  _AudioUploadState createState() => _AudioUploadState();
}

class _AudioUploadState extends State<AudioUpload> {
  late AudioPlayer player;

  @override
  initState() {
    player = AudioPlayer();
    super.initState();
  }

  getDuration(String filePath) async {
    print("filePath");
    print(filePath);
    var duration = await player.setFilePath(filePath);
    // var duration = await player.setFilePath('/path/to/file.mp3');
    print('duration: $duration');
    if (duration != null) widget.cubit.updateDuration(duration);
    uploadFile();
  }

  File? _file;

  uploadFile() async {
    AppDialog.showLoadingDialog(
        context,
        Card(
            margin: EdgeInsets.all(20),
            color: AppColors.BACKGROUND_COLOR,
            child: SizedBox.fromSize(
                size: Size(600, 60),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        SizedBox.fromSize(
                            // size: Size.fromRadius(30),
                            child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Theme(
                                  data: ThemeData.dark(),
                                  child: CupertinoActivityIndicator(
                                      // strokeWidth: 1,
                                      ),
                                ))),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Uploading file',
                              style: TextStyle(color: Colors.white)),
                        ),
                        // LinearProgressIndicator(),
                      ],
                    )))));

    var url = await GetIt.I<UploadService>().upload(_file?.path ?? '');
    await Future.delayed(Duration(milliseconds: 1000));
    AppRouter.navigationKey.currentState?.pop();

    if (url != null)
      widget.cubit.audioChanged(url);
    else {
      AppDialog.show(
          context, 'Error', 'An error occurred, could not upload image');
    }
  }

  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: Platform.isAndroid
            ? ['mp3', 'wav', 'flac']
            : ['.mp3', '.wav', '.flac']);

    print(result);

    if (result != null && result.files.single.path != null) {
      _file = File(result.files.single.path ?? '');
      if (_file != null) getDuration(_file!.path);
    }
  }

//   double _checkSize(File file){
//     int sizeInBytes = file.lengthSync();
// double sizeInMb = sizeInBytes / (1024 * 1024);
// if (sizeInMb > 10){
//     // This file is Longer the
// }
//   }

  @override
  void dispose() {
    player.stop();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: pickFile,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            // color: AppColors.PRIMARY.withOpacity(.03),
            borderRadius: BorderRadius.circular(0),
            border: Border.all(color: Colors.white, width: .3)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.image,
              color: Colors.orange.shade700,
            ),
            SizedBox(width: 20),
            Text('Selected audio',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w300)),
            Spacer(),
            if (widget.cubit.state.audio != null)
              Icon(
                Icons.check_circle,
                color: Colors.green,
              ),
          ],
        ),
      ),
    );
  }
}
