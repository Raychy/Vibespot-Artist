import 'package:just_audio/just_audio.dart';

class AudioService {
  static final player = AudioPlayer();

  static Future<Duration?> getDuration({String? filePath, String? url}) async {
    if (url != null && url.isNotEmpty) return await player.setUrl(url);
    if (filePath != null && filePath.isNotEmpty)
      return await player.setFilePath(filePath);
  }
}
