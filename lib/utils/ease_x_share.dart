import 'dart:io';
import 'package:flutter/services.dart';
import 'package:mime/mime.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class EaseXShare {
  /// Share text via different applications.
  static Future<void> shareText(String text) async {
    await Share.share(text);
  }

  /// Share a single image file
  static Future<void> shareSingleImage(File imageFile, {String? text}) async {
    final mimeType = lookupMimeType(imageFile.path);
    if (mimeType != null && mimeType.startsWith('image')) {
      await Share.shareXFiles([XFile(imageFile.path)],
          text: text, sharePositionOrigin: Rect.zero);
    } else {
      throw Exception("Invalid image file");
    }
  }

  /// Share multiple images
  static Future<void> shareMultipleImages(List<File> imageFiles,
      {String? text}) async {
    final List<XFile> xFiles = imageFiles
        .map((file) => XFile(file.path, mimeType: lookupMimeType(file.path)))
        .toList();

    await Share.shareXFiles(xFiles, text: text);
  }

  /// Open WhatsApp chat with a specific phone number and optinal message.
  static Future<void> openWhatsAppChat(String countryCode, String phoneNumber,
      {String message = ""}) async {
    final Uri url = Uri.parse(
        "https://wa.me/$countryCode$phoneNumber?text=${Uri.encodeComponent(message)}");

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception("Could not open WhatsApp");
    }
  }

  /// Share File via different applications.
  static Future<void> shareFile(File file, {String? text}) async {
    await Share.shareXFiles([XFile(file.path)], text: text);
  }

  /// Share Video via different applications.
  static Future<void> shareVideo(File videoFile) async {
    await Share.shareXFiles([XFile(videoFile.path)]);
  }
}
