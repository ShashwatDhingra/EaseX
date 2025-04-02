import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

/// 📸📹📂 Media Picker Utility (Images, Videos, Files)
/// Usage:
/// - Images: `EaseXMedia.pickImage()`
/// - Videos: `EaseXMedia.pickVideo()`
/// - Files: `EaseXMedia.pickFile()`
class EaseXMedia {
  static final ImagePicker _imagePicker = ImagePicker();
  static final FilePicker _filePicker = FilePicker.platform;

  /// --- IMAGE PICKER --- ///
  static Future<File?> pickImage({
    ImageSource source = ImageSource.gallery,
    Color? toolbarColor,
  }) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile == null) return null;

      File imageFile = File(pickedFile.path);
      return imageFile;
    } catch (e) {
      debugPrint('EaseXMedia (Image) Error: $e');
      return null;
    }
  }

  /// --- VIDEO PICKER --- ///

  /// 🎥 Pick a video from gallery/camera.
  static Future<File?> pickVideo({
    ImageSource source = ImageSource.gallery,
  }) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickVideo(source: source);
      return pickedFile != null ? File(pickedFile.path) : null;
    } catch (e) {
      debugPrint('EaseXMedia (Video) Error: $e');
      return null;
    }
  }

  /// --- FILE PICKER --- ///

  /// 📂 Pick any file (PDF, DOC, etc.) with optional file type filtering.
  static Future<File?> pickFile({
    List<String>? allowedExtensions,
    String? dialogTitle,
    int? maxSizeInBytes, // e.g., 10 * 1024 * 1024 (10MB)
  }) async {
    try {
      final result = await _filePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: allowedExtensions,
        dialogTitle: dialogTitle,
      );
      if (result == null) return null;

      final file = File(result.files.single.path!);
      if (maxSizeInBytes != null && await file.length() > maxSizeInBytes) {
        throw Exception('File exceeds size limit');
      }
      return file;
    } catch (e) {
      debugPrint('EaseXMedia (File) Error: $e');
      return null;
    }
  }

  /// --- MULTIPLE FILES --- ///

  /// 🗂️ Pick multiple files (images/docs).
  static Future<List<File>?> pickMultipleFiles({
    FileType fileType = FileType.image, // or FileType.any
  }) async {
    try {
      final FilePickerResult? result = await _filePicker.pickFiles(
        type: fileType,
        allowMultiple: true,
      );
      return result?.files.map((file) => File(file.path!)).toList();
    } catch (e) {
      debugPrint('EaseXMedia (Multiple Files) Error: $e');
      return null;
    }
  }
}
