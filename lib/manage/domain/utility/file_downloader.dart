import 'dart:typed_data';

abstract interface class FileDownloader {
  Future<void> fileDownload({
    required Uint8List data,
    required String fileName,
  });
}