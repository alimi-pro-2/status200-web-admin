import 'dart:typed_data';

abstract interface class Downloader {
  Future<void> download({
    required Uint8List data,
    required String fileName,
  });
}
