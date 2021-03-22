import 'package:mime/mime.dart';

class MimeUtils {
  static bool isImage(String path) {
    final mimeType = lookupMimeType(path);
    return mimeType.startsWith('image/');
  }
}
