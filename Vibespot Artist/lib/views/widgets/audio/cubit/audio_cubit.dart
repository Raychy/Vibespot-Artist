// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:just_audio/just_audio.dart';

// part 'audio_state.dart';

// class AudioCubit extends Cubit<AudioState> {
//   AudioCubit() : super(AudioState());

//   final player = AudioPlayer();
//   void updateDuration(Duration duration) =>
//       emit(state.copyWith(duration: duration));

//   void updateFile(String filePath) {
//     emit(state.copyWith(filePath: filePath));
//     getDuration(filePath);
//   }

//   void updateUrl(String url) => emit(state.copyWith(url: url));
//   getDuration(String filePath) async {
//     var duration = await player.setFilePath(filePath);
//     // var duration = await player.setFilePath('/path/to/file.mp3');
//     print('duration: $duration');
//     if (duration != null) updateDuration(duration);
//   }
// }
