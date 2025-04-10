import 'package:flutter_file_saver/flutter_file_saver.dart';

class EaseXFileSaver {
  static Future<void> saveFile({
    required String fileName,
    required FileType type,
    required dynamic content,
  }) async {
    await FlutterFileSaver().writeFileAsString(
      fileName: "$fileName.${type.name}",
      data: content,
    );
  }
}

enum FileType {
  text,
  pdf,
  png,
  jpg,
  jpeg,
  gif,
  webp,
  bmp,
  mp4,
  mov,
  avi,
  mkv,
  flv,
  mp3,
  wav,
  aac,
  ogg,
}
