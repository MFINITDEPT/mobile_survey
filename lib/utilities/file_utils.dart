// ignore: public_member_api_docs
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

// ignore: public_member_api_docs
class FileUtils {
  // ignore: avoid_classes_with_only_static_members
  static Uint8List s() => null;

  static void openFile(String path) => OpenFile.open(path);

  static Future<File> compressFile(File file, String targetPath) async {
    var minSize =( 1080/2).toInt();
    var extDir = await getApplicationDocumentsDirectory();
    var dirPath = '${extDir.path}/app_name/files/';
    var fileName = "$dirPath${targetPath}_${_timestamp()}.jpg";
    print(fileName);
    await Directory(dirPath).create(recursive: true);
    var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, fileName,
        autoCorrectionAngle: false,
        format: CompressFormat.jpeg,
        minWidth: minSize,
        minHeight: minSize,
        quality: 80
    );

    print(file.lengthSync());
    print(result?.lengthSync());

    return result;
  }

  static String _timestamp() =>
      DateTime.now().millisecondsSinceEpoch.toString();
}
