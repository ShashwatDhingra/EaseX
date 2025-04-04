
import 'package:file_picker/file_picker.dart';
import 'package:flutter_file_saver/flutter_file_saver.dart';

class EaseFileSaver {
  /// Saves a file with the given content into an appropriate folder based on extension.
  ///
  /// Parameters:
  /// - `fileName`: The name of the file (e.g., 'document.txt', 'image.png').
  /// - `content`: The content to save (as a String).
  ///
  /// Example:
  /// ```dart
  /// await EaseFileSaver.saveFile(
  ///   fileName: 'hello.txt',
  ///   content: 'Hello World!',
  /// );
  /// ```
  /// 
  /// 
  /// 
  /// 




  static Future<void> saveFile({
    required String fileName,
   required  FileType type,
    required String content,
  }) async {

    await FlutterFileSaver().writeFileAsString(
      fileName: fileName+"."+type.toString(),
      data: content, 
    );
  }


}




enum FileType {
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
