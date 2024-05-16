import 'dart:io';
import 'dart:typed_data';

import '../../domain/utility/file_downloader.dart';

class MobileExcelFileDownload implements FileDownloader {
  @override
  Future<void> fileDownload({
    required Uint8List data,
    required String fileName,
  }) async {
    String directoryPath = '/storage/emulated/0/Download';
    Directory directory = Directory(directoryPath);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }
    String filePath = '$directoryPath/$fileName';
    File file = File(filePath);
    await file.writeAsBytes(data);
  }
}
